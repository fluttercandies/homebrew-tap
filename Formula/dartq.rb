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
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.29/dartq-0.1.29-macos-arm64.tar.gz"
      sha256 "3a1ec1ca26618c51fa4ea3ce6bcc54883ca57607ee6ae2322ea769cff06533b4"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.29/dartq-0.1.29-macos-x86_64.tar.gz"
      sha256 "f264c25e5dc9d89bd8e15657789753107fa582474719ff537feaf343e9726a68"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.29/dartq-0.1.29-linux-arm64.tar.gz"
      sha256 "dd6787ffae5dc70acd7961733f5d5ba73f63b53f6e82156e22a1ec104ca06731"
    end
    on_intel do
      url "https://github.com/fluttercandies/dartq/releases/download/v0.1.29/dartq-0.1.29-linux-x86_64.tar.gz"
      sha256 "5a769d5614222185ff978da17b39a8de9f20bd6f834a8d3692cf0a5d13548a09"
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
