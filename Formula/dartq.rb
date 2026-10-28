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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.0/dartq-0.1.0-macos-arm64.tar.gz"
      sha256 "a1220b5ea3cf026471c0ffc4f006f9c62607291a81f32a18cce67e6a0dc39dcc"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.0/dartq-0.1.0-macos-x86_64.tar.gz"
      sha256 "a7c67d3a63522254841089862315dcd347ef313335fcf3b72c0718fdbd96c25b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.0/dartq-0.1.0-linux-arm64.tar.gz"
      sha256 "16ccface4d0d982516c38256780fb2683ad286e6f0d863f2706598f2193eefc3"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.0/dartq-0.1.0-linux-x86_64.tar.gz"
      sha256 "c38ca582a906ab149c5a2fa82b260cce1f2736684e331241a44ba8383e1fd46d"
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
