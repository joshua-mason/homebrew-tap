class MacHeadroom < Formula
  desc "Find where macOS disk space went and clear caches safely"
  homepage "https://github.com/joshua-mason/mac-headroom"
  url "https://github.com/joshua-mason/mac-headroom/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "6f79610feb123a2625a8bf9725d818fef219f5e8418b0e98664fa26e0316b568"
  license "MIT"
  head "https://github.com/joshua-mason/mac-headroom.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "mac-headroom", shell_output("#{bin}/mac-headroom --version")
    # diagnose reads the disk and records a reading; it deletes nothing.
    assert_match "Data volume", shell_output("#{bin}/mac-headroom diagnose")
    # A plain clean must be a dry run, whatever else changes.
    assert_match "DRY RUN", shell_output("#{bin}/mac-headroom clean")
  end
end
