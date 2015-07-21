class CoinDataStochastic < Formula
  desc "Stochastic models"
  homepage "http://www.coin-or.org/download/pkgsource/Data"
  url "http://www.coin-or.org/download/source/Data/Stochastic-1.1.5.tgz"
  sha256 "65bbf7611ef6f3d41e76f3d1430f74a14097567d595b75b58f67b4b726ebb697"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}"
    system "make", "install"
  end
end
