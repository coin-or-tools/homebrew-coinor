class CoinDataStochastic < Formula
  desc "Stochastic models"
  homepage "http://www.coin-or.org/download/pkgsource/Data"
  url "http://www.coin-or.org/download/source/Data/Data-Stochastic-1.1.5.tgz"
  sha256 "6fdfa29b51e5d27ce243a902ae98bca9924390484262a3df8e986476d51f4692"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
