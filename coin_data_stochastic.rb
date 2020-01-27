class CoinDataStochastic < Formula
  desc "Stochastic models"
  homepage "https://www.coin-or.org/download/source/Data"
  url "https://www.coin-or.org/download/source/Data/Data-Stochastic-1.1.6.tgz"
  sha256 "2e2df9cd16bb8d07739cc5b14f0b52a6e697cd181e5e3c793cff83804491c255"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
