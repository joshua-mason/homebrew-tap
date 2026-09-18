class MacHeadroom < Formula
  desc "Find where macOS disk space went and clear caches safely"
  homepage "https://github.com/joshua-mason/mac-headroom"
  url "https://github.com/joshua-mason/mac-headroom/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "83dcdbd9de8150fb0fcaa62c0f218200377459e1efd5e920f5cc63fc8cbcb431"
  license "MIT"
  head "https://github.com/joshua-mason/mac-headroom.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "mac-headroom #{version}", shell_output("#{bin}/mac-headroom --version")
    # `list` only prints the built-in cleaners. Anything that inspects the disk
    # shells out to diskutil and tmutil, which need Full Disk Access and hang
    # in the test sandbox rather than failing.
    assert_match "chrome-cache", shell_output("#{bin}/mac-headroom list")
  end
end
