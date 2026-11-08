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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.14/dartq-0.1.14-macos-arm64.tar.gz"
      sha256 "7ade7860256a7bec252f218aea3417b7e4253f5734c52008ba4786399a77f9ae"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.14/dartq-0.1.14-macos-x86_64.tar.gz"
      sha256 "cde9060756f42165e5616f44daf670a623227b4a6525c1467bc112848a82e707"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.14/dartq-0.1.14-linux-arm64.tar.gz"
      sha256 "251b4afd0b71eb7f662a4f966ae12666dfaa57bf5f66dc15537ba3055112a1d4"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.14/dartq-0.1.14-linux-x86_64.tar.gz"
      sha256 "0dec10186aa3d9b5b79ff00fc9d5ca5904f68625b424c6373bccbe9c49b0ea1d"
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
