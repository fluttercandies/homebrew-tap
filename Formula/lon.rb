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
      sha256 "a7e649c4c045802ecf3844ee7c09bbac85f743f076772686685e1e07a59a136d"
    end

    on_intel do
      url "https://github.com/fluttercandies/lon/releases/download/rust-v0.1.0/lon-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "4569c9d0c3643c2c3ac73ad4e681bc6c562dc48440bffa469b0aa623c7e2d494"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/lon/releases/download/rust-v0.1.0/lon-0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "50ea550e3bb8beb2e247782b7d0768af46a886d17b50f858b019b46032cc90bd"
    end

    on_intel do
      url "https://github.com/fluttercandies/lon/releases/download/rust-v0.1.0/lon-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "688bdb31c764acae3e0b0bda548a82ae7e2ea3406789be4eba7694a714958ddd"
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
