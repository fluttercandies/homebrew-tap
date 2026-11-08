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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.13/dartq-0.1.13-macos-arm64.tar.gz"
      sha256 "05bea9a488c0b88686abf09f89853102aea62fd498bfdb110fa3a50e2595a92d"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.13/dartq-0.1.13-macos-x86_64.tar.gz"
      sha256 "ffc886014add609d9b9c695591023f2e73885340649de066dcde797519d00e0c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.13/dartq-0.1.13-linux-arm64.tar.gz"
      sha256 "aa4bd538f6875fb84dc892f32df5208681e395e67a2caf97747fdb44c18e894d"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.13/dartq-0.1.13-linux-x86_64.tar.gz"
      sha256 "90ffd171679fa8ed9c2ef28b443aeae58d0169c6e46b99d0a6bb0693c0817fbf"
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
