class CoinDataMiplib3 < Formula
  desc "MIPLib models"
<<<<<<< Updated upstream
  homepage "https://www.coin-or.org/download/source/Data"
  url "https://www.coin-or.org/download/source/Data/Data-miplib3-1.2.8.tgz"
  sha256 ""
=======
  homepage "https://github.com/coin-or-tools/Data-miplib3" # Updated homepage url reference to GitHub
  url "https://github.com/coin-or-tools/Data-miplib3/archive/releases/1.2.8.tar.gz" # Updated url reference to GitHub, version updated to 1.2.8
  sha256 "72f5255e3078406e3c6f2fee01ead0cd7a4b182c35ffa2c5d4ebd230914c0fe3" # Updated sha256 checksum to match updated version
  head "https://github.com/coin-or-tools/Data-Netlib/tree/releases/1.2.8" # Added head and made url reference to GitHub for version 1.2.8
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
