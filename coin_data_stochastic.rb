class CoinDataStochastic < Formula
  desc "Stochastic models"
  homepage "https://github.com/coin-or-tools/Data-Stochastic"
  url "https://github.com/coin-or-tools/Data-Stochastic/archive/refs/tags/releases/1.1.6.tar.gz"
  sha256 "0ce99bfd3ae2b42f858fac2ca4d77b6ef89d2b2f215fd63cd61ead51e9988f1f"
  revision 1

  head "https://github.com/coin-or-tools/Data-Stochastic.git"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
