class CoinDataSample < Formula
  desc "Sample models"
<<<<<<< Updated upstream
  homepage "https://www.coin-or.org/download/source/Data"
  url "https://www.coin-or.org/download/source/Data/Data-Sample-1.2.12.tgz"
  sha256 ""
=======
  homepage "https://github.com/coin-or-tools/Data-Sample" # Updated homepage url reference to GitHub
  url "https://github.com/coin-or-tools/Data-Sample/archive/releases/1.2.12.tar.gz" # Updated url reference to GitHub, version updated to 1.2.12
  sha256 "e9e67c04adfbd85523890b346326b106075df615e922c229277e138dbcb77e64" # Updated sha256 checksum to match updated version
  head "https://github.com/coin-or-tools/Data-Sample/tree/releases/1.2.12" # Added head and made url reference to GitHub for version 1.2.12
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
