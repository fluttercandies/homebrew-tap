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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.27/dartq-0.1.27-macos-arm64.tar.gz"
      sha256 "4d038ee064a58fe3a707b54f2aa1024746e0705250f0f57ebfc4c76a02b1b148"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.27/dartq-0.1.27-macos-x86_64.tar.gz"
      sha256 "80294e92acfd055f36732644729470982b9904158a0b1fd7a7b3d2e463e7c8e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.27/dartq-0.1.27-linux-arm64.tar.gz"
      sha256 "2eaf9e81adcc640f0ed3af03143125eadbbbc9653cc8370666d75512a34e6c47"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.27/dartq-0.1.27-linux-x86_64.tar.gz"
      sha256 "ae078116ea952abf6f40cec09b080949bc9b1c981a0cc8c2eb0df6ab48c7d22d"
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
