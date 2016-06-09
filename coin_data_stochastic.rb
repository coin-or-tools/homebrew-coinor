class CoinDataStochastic < Formula
  desc "Stochastic models"
  homepage "http://www.coin-or.org/download/pkgsource/Data"
  url "http://www.coin-or.org/download/pkgsource/Data/Data-Stochastic-1.1.5.tgz"
  sha256 "c6c3d1badd553684f15dc4a1db90fd641f937ad79f5b5f1c5100d323f5ebf15c"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
