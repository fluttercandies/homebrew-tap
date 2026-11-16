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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.28/dartq-0.1.28-macos-arm64.tar.gz"
      sha256 "77b451f52981f7e3777dda9856c36aab56d808ec7ddc25ef2eb89d14476b5f22"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.28/dartq-0.1.28-macos-x86_64.tar.gz"
      sha256 "7135c7647ad08a151cf2e5f5f3c85a7621769f37a232462464a9c260e50dd892"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.28/dartq-0.1.28-linux-arm64.tar.gz"
      sha256 "97d1bd78e93c966e75a690ea5dca1da7fc1e475bbcc5218c3385ebeb4d3ce02a"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.28/dartq-0.1.28-linux-x86_64.tar.gz"
      sha256 "f3a08965e66ebdf40b04cc47cb202d32069fac718b896ac9ca8f50c63faa3093"
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
