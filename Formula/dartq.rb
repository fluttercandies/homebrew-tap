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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.15/dartq-0.1.15-macos-arm64.tar.gz"
      sha256 "88e835e939a24de214f3aa1fd323ec7bdcefff877236ecc01517b59936b83ae0"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.15/dartq-0.1.15-macos-x86_64.tar.gz"
      sha256 "1c265950e7b443aab56298407e5f58f6673e3b0c4ffc7bed7828782cd14ed3f1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.15/dartq-0.1.15-linux-arm64.tar.gz"
      sha256 "10651c885e8cbc9dd78d6cc8848e7502e70d8af22294c88e5463f5f77ee1afb1"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.15/dartq-0.1.15-linux-x86_64.tar.gz"
      sha256 "1f17124902a621e5c0f0d316ff523aeff290b4effa166a1ad59bf9b900eab19f"
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
