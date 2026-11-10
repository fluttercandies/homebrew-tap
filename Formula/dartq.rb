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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.18/dartq-0.1.18-macos-arm64.tar.gz"
      sha256 "209dde6c8b792daa8f3972c5a7bc7d63822f2067c3ae02162790f2ad56445b40"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.18/dartq-0.1.18-macos-x86_64.tar.gz"
      sha256 "9cfe60c884c7cb002c378339041fefc450d50d200f6485dad3c8a548c826461b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.18/dartq-0.1.18-linux-arm64.tar.gz"
      sha256 "bc4b3855bd3d778e0c66f8e335224282ff69b5a8239f46987453bd3c08a367d3"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.18/dartq-0.1.18-linux-x86_64.tar.gz"
      sha256 "32cc62954d606b6dc75ad4ffee60ade7f643ee199e439b7f1edc81fbc063693c"
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
