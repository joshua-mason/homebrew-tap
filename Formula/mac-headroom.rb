class MacHeadroom < Formula
  desc "Find where macOS disk space went and clear caches safely"
  homepage "https://github.com/joshua-mason/mac-headroom"
  url "https://github.com/joshua-mason/mac-headroom/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "a6d7ca37e878014e7ceb20e54dd81612a7232e1341ae9f22e5944b8713a50f45"
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
