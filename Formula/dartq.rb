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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.20/dartq-0.1.20-macos-arm64.tar.gz"
      sha256 "ccf8e77adb2debee723a6a9ccac9cb52d07e2dbf752568223da7ab9bf18f869d"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.20/dartq-0.1.20-macos-x86_64.tar.gz"
      sha256 "f070fb672bb2bbc0eab6f787c68f6b18cc138a62361cc31d7f94d89e5afc8c60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.20/dartq-0.1.20-linux-arm64.tar.gz"
      sha256 "49e59d4218b275231a11a6da7185792ddbd70ca053b14d8d95889dff66f43420"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.20/dartq-0.1.20-linux-x86_64.tar.gz"
      sha256 "0964723f21733d4e1bd42d30fd4d4ee3e61b6ad1688d7959f5f56c908215d1ff"
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
