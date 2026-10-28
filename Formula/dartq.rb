class Dartq < Formula
  desc "AI-first Dart toolchain: resident engine, daemon RPC, and CLI (beta)"
  homepage "https://github.com/fluttercandies/dartq"
  url "https://github.com/fluttercandies/dartq/releases/download/v0.1.0/dartq-0.1.0-aarch64-apple-darwin.tar.gz"
  sha256 "909b7c31d6f97f118359e40b9a19a9977dcd3734db7b4908fa9ee4b53b08f489"
  license any_of: ["Apache-2.0", "MIT"]

  livecheck do
    url "https://github.com/fluttercandies/dartq/releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.0/dartq-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "909b7c31d6f97f118359e40b9a19a9977dcd3734db7b4908fa9ee4b53b08f489"
    end
  end

  def install
    bin.install "dartq"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dartq --version")
  end
end
