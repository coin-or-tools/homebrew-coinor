class CoinDataMiplib3 < Formula
  desc "MIPLib models"
  homepage "https://www.coin-or.org/download/source/Data"
  url "https://www.coin-or.org/download/source/Data/Data-miplib3-1.2.7.tgz"
  sha256 "7a6b15435e77e6758d605d0654f0fd2aeeec2d34061b0e95e71f698a047cbb4b"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
