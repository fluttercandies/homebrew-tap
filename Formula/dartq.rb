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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.26/dartq-0.1.26-macos-arm64.tar.gz"
      sha256 "0a25e0ff6bf1179279bcf9ee5ec55b3e4d77870a9a5a8b7a52634b9874cb99f4"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.26/dartq-0.1.26-macos-x86_64.tar.gz"
      sha256 "a023db81e314f924a1e26c9ece7a745c4c7ece162ce35e7ecea68a6356dede4e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.26/dartq-0.1.26-linux-arm64.tar.gz"
      sha256 "cb88ab5baa81b8d768e8338371e85ba1740a52c79f3c3ccf69ee3da32fc0a847"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.26/dartq-0.1.26-linux-x86_64.tar.gz"
      sha256 "c8bcce5b1d2191c3377b23139302d681b97606bb2d0f6ea74563ffa0eb0784dc"
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
