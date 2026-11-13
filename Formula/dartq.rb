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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.23/dartq-0.1.23-macos-arm64.tar.gz"
      sha256 "998fe98fe1fc25e4f8fafe4bd9ec381dfbb1f0335d9c2f11ee48346844627f32"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.23/dartq-0.1.23-macos-x86_64.tar.gz"
      sha256 "39bf1c040b66f0288a9832084ac1b955fdff96310dc47a71ab7f07fcbfc7e65f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.23/dartq-0.1.23-linux-arm64.tar.gz"
      sha256 "a9075728dd006bff5acc1ebf71b55eab407b05a94ea6f90963ac07af8b41456f"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.23/dartq-0.1.23-linux-x86_64.tar.gz"
      sha256 "9aeca2fd9a36ba7c5ee9245fe15edd5b88ca6d01e46b6be3b519e5fdd985da23"
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
