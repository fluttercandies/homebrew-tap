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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.11/dartq-0.1.11-macos-arm64.tar.gz"
      sha256 "66e3eed17a59559f56cefd530a1e32ed8a5e7cf6d6770b4c1c0f4d1b3d60f1f3"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.11/dartq-0.1.11-macos-x86_64.tar.gz"
      sha256 "cf84d833da14368d0d640346369e297fd223283d2e16128f232cacd039cfdba9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.11/dartq-0.1.11-linux-arm64.tar.gz"
      sha256 "0f1cbde1382287ae5ecc80a3023ee8a3f6c3c5ab83bc2bef7b9c8b12fd7369b7"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.11/dartq-0.1.11-linux-x86_64.tar.gz"
      sha256 "bc07d9788627f7b26609cb231263401d8451e137de0eb35fead90a645ec96f81"
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
