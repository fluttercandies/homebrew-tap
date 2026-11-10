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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.19/dartq-0.1.19-macos-arm64.tar.gz"
      sha256 "157e4c5759400800a6c438bfd21ed7e9855b54a29bdf641dc0e7cf2c786fe757"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.19/dartq-0.1.19-macos-x86_64.tar.gz"
      sha256 "e0f1d6d43136119196bf2964c976a365f2f9aa43c0ee86e7039bdf8ccff5f451"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.19/dartq-0.1.19-linux-arm64.tar.gz"
      sha256 "43db06fd69faf8afaabb2a782ee5f97e9e6857b4c97e0fc196b339b22f381f6a"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.19/dartq-0.1.19-linux-x86_64.tar.gz"
      sha256 "606ae1563b969b79544de2e3149af7db57f5eed0b610ef446031e4590866bf00"
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
