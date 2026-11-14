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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.25/dartq-0.1.25-macos-arm64.tar.gz"
      sha256 "f97f7d5b583dc381fa67268fcbb0bc34a4f3bd769b503445d6cbe08d5aa47259"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.25/dartq-0.1.25-macos-x86_64.tar.gz"
      sha256 "22c5fb12a52961c095a3467bcbde3186723a3076865faa7fba29a45e36d62164"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.25/dartq-0.1.25-linux-arm64.tar.gz"
      sha256 "986f2dfd7d8e22aa635ccb98bfe5e1caa51a015f32b6d9f31470fbd6105fbe67"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.25/dartq-0.1.25-linux-x86_64.tar.gz"
      sha256 "e3ac12b62157339de9358335d6ad949d61142f4f02f743d87fe94e6a3ed12732"
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
