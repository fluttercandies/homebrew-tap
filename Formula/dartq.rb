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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.30/dartq-0.1.30-macos-arm64.tar.gz"
      sha256 "bce44bc13deaa7669f0bbdd89791c78a9113c8ae14faef1889abd3bc2cde804f"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.30/dartq-0.1.30-macos-x86_64.tar.gz"
      sha256 "9432d9d3cb51be62ee5402922b4567db1344efef25bb3cfabf640c3c684947fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.30/dartq-0.1.30-linux-arm64.tar.gz"
      sha256 "cb126cb40f5842cebfe7c312ff6fcf68d26c3e1d294653f652326b9efa4bcc34"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.30/dartq-0.1.30-linux-x86_64.tar.gz"
      sha256 "1dcb38ad3006af48568e32636fd48cb207edcd13503463f2989c86b0ba4ae2df"
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
