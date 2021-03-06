class CoinDataStochastic < Formula
  desc "Stochastic models"
<<<<<<< Updated upstream
  homepage "https://www.coin-or.org/download/source/Data"
  url "https://www.coin-or.org/download/source/Data/Data-Stochastic-1.1.7.tgz"
  sha256 ""
=======
  homepage "https://github.com/coin-or-tools/Data-Stochastic" # Updated homepage url reference to GitHub
  url "https://github.com/coin-or-tools/Data-Stochastic/archive/releases/1.1.7.tar.gz" # Updated url reference to GitHub, version updated to 1.1.7
  sha256 "73292a7765d2c439d95013944d5ed00ef66feb79c010aa9a4427a3028ed7a785" # Updated sha256 checksum to match updated version
  head "https://github.com/coin-or-tools/Data-Stochastic/tree/releases/1.1.7" # Added head and made url reference to GitHub for version 1.1.7
  revision 1  # Added revision count
>>>>>>> Stashed changes

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
