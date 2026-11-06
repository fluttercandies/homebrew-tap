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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.7/dartq-0.1.7-macos-arm64.tar.gz"
      sha256 "0f34fccdbf48f66b31a78acf43da16cc80470ff7bc8b90824b232fdbfce5c98c"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.7/dartq-0.1.7-macos-x86_64.tar.gz"
      sha256 "bd6137cd6feb57563825189543ecbbb76daf4e175eef81c81a15b7c553420091"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.7/dartq-0.1.7-linux-arm64.tar.gz"
      sha256 "4da79548341ed8b048ae30f68ba7810f038c8d4a96ff5ddcafc52739d04e176d"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.7/dartq-0.1.7-linux-x86_64.tar.gz"
      sha256 "2a9db740fbfd83d2973957eaa7bd9fade8179a90d8bddb0cf5f5f921554c2b07"
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
