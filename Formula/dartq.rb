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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.24/dartq-0.1.24-macos-arm64.tar.gz"
      sha256 "abc7fde89cc3b213c3c91101c92dcb54ce52ea90080a1593bf3ea291dd5aae07"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.24/dartq-0.1.24-macos-x86_64.tar.gz"
      sha256 "17afa0f26ece886ff6fd30bd90f54726cb825bb581d932a26ff4d59a69c11ac2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.24/dartq-0.1.24-linux-arm64.tar.gz"
      sha256 "94ad39e97f4aaa1d89f3f2dd7df179a77b96bb1e4da3e47a9b88e2dfcd2edaab"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.24/dartq-0.1.24-linux-x86_64.tar.gz"
      sha256 "97271cab41e7a041ddfb474334a8b7838802aa46d96f1e8eba74abc95a647aa9"
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
