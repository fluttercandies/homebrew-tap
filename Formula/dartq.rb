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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.12/dartq-0.1.12-macos-arm64.tar.gz"
      sha256 "471f0f261b0f9d7309461d9d5b8cef8761b6ce50f64861330e5cd905ed5f8018"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.12/dartq-0.1.12-macos-x86_64.tar.gz"
      sha256 "42403cd8d0f4d1a7a4b431ec220e64e24262c845ab03f27ec59521efd99bcb91"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.12/dartq-0.1.12-linux-arm64.tar.gz"
      sha256 "d79df66fd149abfc1dffd93e0d7c24506d8917b633e3c4cafb22a5eb5a3ea106"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.12/dartq-0.1.12-linux-x86_64.tar.gz"
      sha256 "16b5b0b3853c06f7f3393e52e982472872149fec8db1f0b597511bbd08e110dd"
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
