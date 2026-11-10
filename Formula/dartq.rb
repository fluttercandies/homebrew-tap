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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.16/dartq-0.1.16-macos-arm64.tar.gz"
      sha256 "70ed28129d24733bf74dcfa9647ae356eae9be6d1c43795a0baf71ccb880357a"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.16/dartq-0.1.16-macos-x86_64.tar.gz"
      sha256 "d32ccd26451d7c9883aae3a0a8571ca4a0a98eb36469dbeb97ea13050783dcc6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.16/dartq-0.1.16-linux-arm64.tar.gz"
      sha256 "17b10b297d41d1504df31d18b90c04b2b95fd7df0d09182ed5609e2339123536"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.16/dartq-0.1.16-linux-x86_64.tar.gz"
      sha256 "717e688dfe4e90f3f925d3a5508b0e0aa09d339923e4b296a4b39e0cf4dba735"
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
