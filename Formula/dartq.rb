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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.8/dartq-0.1.8-macos-arm64.tar.gz"
      sha256 "503ba1e140b5ed3cbd47dfcf4813219146f76d3e11894a5224f598c4fd6d9e06"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.8/dartq-0.1.8-macos-x86_64.tar.gz"
      sha256 "b1f6af33023436e8a6a762de1cf0e1fce79c317fa4c94e85fdad5de10b0d05bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.8/dartq-0.1.8-linux-arm64.tar.gz"
      sha256 "6e5cbff686c7dc1ad39b09eb1d748be57ef7b976c7b938e841e1177680ace86e"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.8/dartq-0.1.8-linux-x86_64.tar.gz"
      sha256 "cabaaa44de72a65a72cfc9f5c33f564ac06e58df34a5c968013050461d5dc909"
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
