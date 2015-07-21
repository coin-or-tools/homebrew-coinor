class CoinDataMiplib3 < Formula
  desc "MIPLib models"
  homepage "http://www.coin-or.org/download/pkgsource/Data"
  url "http://www.coin-or.org/download/source/Data/miplib3-1.2.6.tgz"
  sha256 "43449c8e9652af80a29044c31da51e9f600f28b211676ba8aa8b42bf8b31dee5"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}"
    system "make", "install"
  end
end
