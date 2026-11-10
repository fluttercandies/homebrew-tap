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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.17/dartq-0.1.17-macos-arm64.tar.gz"
      sha256 "def94c845caf31ccf039756b82f31a8efd7d1c3a7ff5db578f19c6bf215ab9cb"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.17/dartq-0.1.17-macos-x86_64.tar.gz"
      sha256 "ec05cb5de8a90737ccfbdfbafd43cad3124c77a73bd20c7f134e9643f16954c8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.17/dartq-0.1.17-linux-arm64.tar.gz"
      sha256 "e57e5375607d78882b653e4285055e2123ae5d616fb0f46efd7357452c8615ac"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.17/dartq-0.1.17-linux-x86_64.tar.gz"
      sha256 "9a911c31226aeefb5908a59564606a48d17d6efc2c724924823b19d153285b95"
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
