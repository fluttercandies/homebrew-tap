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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.10/dartq-0.1.10-macos-arm64.tar.gz"
      sha256 "a435a4e59a43d1a8c8a45f938b3147e774af8949ebb1b5c368419a1a9ff27371"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.10/dartq-0.1.10-macos-x86_64.tar.gz"
      sha256 "126a797b20903d259009687c07bb29586f5717deebb227af1b60e9bcb5707ea6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.10/dartq-0.1.10-linux-arm64.tar.gz"
      sha256 "2783cb1f3b45fffa9e5025a946d18777e496450150462d4322eb97565dced02f"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.10/dartq-0.1.10-linux-x86_64.tar.gz"
      sha256 "ef1f1b797a999eca6bb444025c5da8fcb9338aa6d0c8fa88b971a36107bb7673"
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
