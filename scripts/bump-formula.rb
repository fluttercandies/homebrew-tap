#!/usr/bin/env ruby
# frozen_string_literal: true

# Generic formula bumper for this tap.
#
# A formula is auto-bumpable when its `url` lines point at GitHub Release
# assets whose tag and filename both embed the release version, e.g.
#   .../releases/download/rust-v0.1.0/lon-0.1.0-aarch64-apple-darwin.tar.gz
#
# For every such formula the script:
#   1. derives the upstream repo, tag prefix, and current version from the URLs,
#   2. asks the GitHub Releases API for the newest tag with the same prefix,
#   3. downloads each referenced asset at the new version and computes sha256,
#   4. rewrites the tag, the versioned asset filenames, and the sha256 line
#      that follows each rewritten URL,
#   5. gates the result with `brew style` and commits "chore: bump <name> to <version>".
#
# Formulas that do not follow the convention (no matching URLs, mixed tags,
# assets without the version in the filename, incomplete new release) are
# skipped with a note, never modified.
#
# Usage: ruby scripts/bump-formula.rb [formula-name ...]   # no args = all

require "digest"
require "json"
require "open-uri"
require "tmpdir"

REPO_ROOT = File.expand_path("..", __dir__)
GITHUB_TOKEN = ENV.fetch("GITHUB_TOKEN", "")

def github_json(url)
  headers = { "User-Agent" => "fluttercandies-tap-bump" }
  headers["Authorization"] = "token #{GITHUB_TOKEN}" unless GITHUB_TOKEN.empty?
  URI.parse(url).open(headers).read.then { |body| JSON.parse(body) }
rescue StandardError => e
  warn "  ! GitHub request failed (#{url}): #{e.message}"
  nil
end

def download(url, dest)
  headers = { "User-Agent" => "fluttercandies-tap-bump" }
  headers["Authorization"] = "token #{GITHUB_TOKEN}" unless GITHUB_TOKEN.empty?
  IO.binwrite(dest, URI.parse(url).open(headers).read)
  true
rescue StandardError
  false
end

# Newest release tag sharing the formula's tag prefix, or nil.
def latest_tag(repo, prefix)
  releases = github_json("https://api.github.com/repos/#{repo}/releases?per_page=30")
  return nil unless releases.is_a?(Array)

  pattern = /\A#{Regexp.escape(prefix)}(\d+(?:\.\d+)+)\z/
  releases.filter_map { |r| r["tag_name"] }.find { |t| t.match?(pattern) }
end

def bump_formula(path)
  name = File.basename(path, ".rb")
  text = File.read(path)

  urls = text.scan(%r{https://github\.com/([\w.-]+/[\w.-]+)/releases/download/([^/"\s]+)/([^/"\s]+)})
             .map { |repo, tag, asset| { repo:, tag:, asset: } }
  if urls.empty?
    puts "#{name}: no GitHub Release asset URLs; skipped (not auto-bumpable)."
    return nil
  end

  repos = urls.map { |u| u[:repo] }.uniq
  tags = urls.map { |u| u[:tag] }.uniq
  if repos.size != 1 || tags.size != 1
    puts "#{name}: multiple repos or tags in URLs; skipped."
    return nil
  end

  repo = repos.first
  tag = tags.first
  match = tag.match(/\A(.*?)(\d+(?:\.\d+)+)\z/)
  unless match
    puts "#{name}: tag #{tag} has no version suffix; skipped."
    return nil
  end
  prefix = match[1]
  version = match[2]

  unless urls.all? { |u| u[:asset].include?(version) }
    puts "#{name}: asset filenames do not embed #{version}; skipped."
    return nil
  end

  fresh = latest_tag(repo, prefix)
  if fresh.nil?
    puts "#{name}: no #{prefix}* release found upstream; skipped."
    return nil
  end
  if fresh == tag
    puts "#{name}: already at #{tag}; up to date."
    return nil
  end
  new_version = fresh.delete_prefix(prefix)

  Dir.mktmpdir("tap-bump") do |dir|
    base = "https://github.com/#{repo}/releases/download/#{fresh}"
    asset_hash = {}
    asset_map = {}
    urls.map { |u| u[:asset] }.uniq.each do |asset|
      new_asset = asset.gsub(version, new_version)
      dest = File.join(dir, new_asset)
      unless download("#{base}/#{new_asset}", dest)
        puts "#{name}: release #{fresh} is missing #{new_asset}; skipped this round."
        return nil
      end
      asset_hash[new_asset] = Digest::SHA256.file(dest).hexdigest
      asset_map[asset] = new_asset
    end

    updated = text.gsub("releases/download/#{tag}/", "releases/download/#{fresh}/")
    asset_map.each { |old_asset, new_asset| updated = updated.gsub(old_asset, new_asset) }
    lines = updated.lines
    lines.each_with_index do |line, i|
      next unless line.include?("url \"") && line.include?(base)

      asset = line[/url "([^"]+)"/, 1].split("/").last
      hash = asset_hash[asset] or next
      ((i + 1)...[i + 4, lines.size].min).each do |j|
        if lines[j] =~ /sha256 "[0-9a-f]{64}"/
          lines[j] = lines[j].sub(/"[0-9a-f]{64}"/, "\"#{hash}\"")
          break
        end
      end
    end
    updated = lines.join

    File.write(path, updated)
    unless system("brew", "style", path, out: File::NULL, err: File::NULL)
      File.write(path, text)
      puts "#{name}: generated update failed brew style; reverted and skipped."
      return nil
    end
  end

  { name:, from: tag, to: fresh, version: new_version }
end

def main
  wanted = ARGV.map { |a| a.end_with?(".rb") ? File.basename(a, ".rb") : a }
  formulae = Dir[File.join(REPO_ROOT, "Formula", "*.rb")].sort
  formulae = formulae.select { |f| wanted.include?(File.basename(f, ".rb")) } unless wanted.empty?

  bumps = formulae.filter_map { |path| bump_formula(path) }
  if bumps.empty?
    puts "Nothing to bump."
    return
  end

  system("git", "-C", REPO_ROOT, "config", "user.name", "github-actions[bot]")
  system("git", "-C", REPO_ROOT, "config", "user.email", "41898282+github-actions[bot]@users.noreply.github.com")
  bumps.each do |bump|
    path = File.join(REPO_ROOT, "Formula", "#{bump[:name]}.rb")
    system("git", "-C", REPO_ROOT, "add", path)
    system("git", "-C", REPO_ROOT, "commit", "-m", "chore: bump #{bump[:name]} to #{bump[:version]}")
  end
  system("git", "-C", REPO_ROOT, "push")
  bumps.each { |b| puts "Bumped #{b[:name]}: #{b[:from]} -> #{b[:to]}." }
end

main
