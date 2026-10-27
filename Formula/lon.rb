class Lon < Formula
  desc "Compact, canonical, lossless JSON codec for AI-first data exchange"
  homepage "https://github.com/fluttercandies/lon"
  url "https://github.com/fluttercandies/lon/releases/download/rust-v0.1.0/lon-0.1.0-aarch64-apple-darwin.tar.gz"
  license "BSD-3-Clause"

  livecheck do
    url "https://github.com/fluttercandies/lon/releases/latest"
    regex(/^rust-v?(\d+(?:\.\d+)+)$/i)
  end

  on_macos do
    on_arm do
      url "https://github.com/fluttercandies/lon/releases/download/rust-v0.1.0/lon-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "9c6afb04f3136f67d2951b0a96be0e18d8494e76d8bbd4f4d5942c874f1dd7ac"
    end

    on_intel do
      url "https://github.com/fluttercandies/lon/releases/download/rust-v0.1.0/lon-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "ab1eac266d418154da564c09a681abdbda47955eb9ff5f560abab5108fb9589b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fluttercandies/lon/releases/download/rust-v0.1.0/lon-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6f0cd6a3ba8a2a44eede2425b7df3be225d6196e7469d0244e72976548ddd0ac"
    end
  end

  def install
    bin.install "lon"
  end

  test do
    assert_equal "{name:Ada active:true}",
      pipe_output("#{bin}/lon encode", '{"name":"Ada","active":true}').strip
  end
end
