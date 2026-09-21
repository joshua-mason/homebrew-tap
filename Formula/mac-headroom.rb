class MacHeadroom < Formula
  desc "Find where macOS disk space went and clear caches safely"
  homepage "https://github.com/joshua-mason/mac-headroom"
  url "https://github.com/joshua-mason/mac-headroom/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "bc7b631e42b101f6d49301780be2ffff0519b4263405a4f946716cdaa303c20e"
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
