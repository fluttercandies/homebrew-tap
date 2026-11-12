# dartq Homebrew formula.
# Rendered by scripts/release/render-formula.sh from the v0.1.0 release
# assets, with three local corrections the tagged tree's template predates:
# the audit-compliant any_of dual license, no explicit version stanza, and
# the linux-arm64 block (the asset exists on the release). From v0.1.1 the
# in-repo template renders all of this directly.
class Dartq < Formula
  desc "Fast static analysis engine for Dart and Flutter"
  homepage "https://github.com/fluttercandies/dartq"
  license any_of: ["Apache-2.0", "MIT"]

  on_macos do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.22/dartq-0.1.22-macos-arm64.tar.gz"
      sha256 "dad0a6d286d79c7f63c3063f27bdf4c7b0844da22c759e3bece3a0ea73a07f28"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.22/dartq-0.1.22-macos-x86_64.tar.gz"
      sha256 "43aedbd035bf2de13c2b5f8b3bb02181bc45764d8f5c8883192538913ab99475"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.22/dartq-0.1.22-linux-arm64.tar.gz"
      sha256 "8d081d77d03acb8deccca01bfbdd039121250d7a34cf9603645d04b233d0db43"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.22/dartq-0.1.22-linux-x86_64.tar.gz"
      sha256 "7f074570c14b9497f2846365978d630bc085ffdbcc99ef49c637c93c90448025"
    end
  end

  def install
    bin.install "dartq"
  end

  def caveats
    <<~EOS
      dartq analyzes Dart and Flutter code and needs a Dart SDK already on
      this machine (installed via Flutter, fvm, or dart.dev). It does not
      install or manage one: point it at your SDK with --sdk <dart-sdk-root>
      or the DART_SDK environment variable.
    EOS
  end

  test do
    system "#{bin}/dartq", "--version"
  end
end
