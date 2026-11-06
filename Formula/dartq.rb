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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.9/dartq-0.1.9-macos-arm64.tar.gz"
      sha256 "1ffd33e025997cf246603db70c69ec2391902e400c25d5339eb0d778076ebd16"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.9/dartq-0.1.9-macos-x86_64.tar.gz"
      sha256 "6acbec0737e7cc22f006e3f0f1e430c62da363cbc00b58932b412eb3b86f3f87"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.9/dartq-0.1.9-linux-arm64.tar.gz"
      sha256 "e484ef07b142e2d6b297d3e309926cebd68daaee2a26b2546f95799d35339d96"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.9/dartq-0.1.9-linux-x86_64.tar.gz"
      sha256 "a2b797fd0bdccfea0c4504e4c50ba4c53069bd31cd600d7ca0469c0ab7d00e4b"
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
