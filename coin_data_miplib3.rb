class CoinDataMiplib3 < Formula
  desc "MIPLib models"
  homepage "https://github.com/coin-or-tools/Data-miplib3" 
  url "https://github.com/coin-or-tools/Data-miplib3/archive/releases/1.2.8.tar.gz" 
  sha256 "72f5255e3078406e3c6f2fee01ead0cd7a4b182c35ffa2c5d4ebd230914c0fe3"
  head "https://github.com/coin-or-tools/Data-Netlib/tree/releases/1.2.8"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
