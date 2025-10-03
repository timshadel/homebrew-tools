class Pikchr < Formula
  desc "Renders fenced Pikchr code blocks in Markdown/text as inline or standalone SVG"
  homepage "https://zenomt.github.io/pikchr-cmd/"
  url "https://github.com/zenomt/pikchr-cmd/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "ac67d9e552431c89c249563e6df4de5f16ad29d9c55055ff27d331cd77499e1b"
  license "MIT"
  head "https://github.com/zenomt/pikchr-cmd.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  def install
    pkgshare.install "README.md.in", "README.md", "usage.svg"
    system "make", "pikchr"
    bin.install "pikchr"
  end

  test do
    cp pkgshare/"README.md.in", testpath/"README.md.in"
    cp pkgshare/"README.md", testpath/"README.md.expected"
    cp pkgshare/"usage.svg", testpath/"usage.svg.expected"

    # Test embedding SVG
    system "sh", "-c", <<~EOS
      #{bin}/pikchr -S 'title="Click Me!" style="font-size: smaller"' \
        < #{testpath}/README.md.in > #{testpath}/README.md
    EOS

    # Test standalone SVG
    system "sh", "-c", <<~EOS
      #{bin}/pikchr -qb -N @usage -a 'style="font-size:initial;font-family:sans-serif;background-color:white"' \
        < #{testpath}/README.md.in > #{testpath}/usage.svg
    EOS

    assert_equal (testpath/"README.md.expected").read, (testpath/"README.md").read
    assert_equal (testpath/"usage.svg.expected").read, (testpath/"usage.svg").read
  end
end
