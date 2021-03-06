class CoinDataStochastic < Formula
  desc "Stochastic models"
  homepage "https://github.com/coin-or-tools/Data-Stochastic"
  url "https://github.com/coin-or-tools/Data-Stochastic/archive/releases/1.1.7.tar.gz"
  sha256 "73292a7765d2c439d95013944d5ed00ef66feb79c010aa9a4427a3028ed7a785"
  head "https://github.com/coin-or-tools/Data-Stochastic/tree/releases/1.1.7"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
