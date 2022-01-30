class CoinDataSample < Formula
  desc "Sample models"
  homepage "https://github.com/coin-or-tools/Data-Sample"
  url "https://github.com/coin-or-tools/Data-Sample/archive/refs/tags/releases/1.2.11.tar.gz"
  sha256 "888d21a31e93a529eb3743a92f2ba62b94b3eed4ddc44351feb8034a84c71ec5"
  revision 1

  head "https://github.com/coin-or-tools/Data-Sample.git"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
