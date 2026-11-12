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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.21/dartq-0.1.21-macos-arm64.tar.gz"
      sha256 "b4379c7b5c835664365fb74d00c35f6084f8dcdfda2816e1b426f1abf2fc181d"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.21/dartq-0.1.21-macos-x86_64.tar.gz"
      sha256 "ab5bb99cbd94833ec0bb4c6c5a749e13e590493f927824cc702e492169aa848a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.21/dartq-0.1.21-linux-arm64.tar.gz"
      sha256 "fa022d2e11b532a4dfd546dbf5facfeefe1ec2199c6c34bf592c3eac20422b4f"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.21/dartq-0.1.21-linux-x86_64.tar.gz"
      sha256 "b758e1122e6e8faa466ce76f0c2b28bc13aaea0087c4fa5ba2e6cd68bd3c7490"
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
