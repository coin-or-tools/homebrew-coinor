class CoinDataNetlib < Formula
  desc "Netlib LP models"
<<<<<<< Updated upstream
  homepage "https://www.coin-or.org/download/source/Data"
  url "https://www.coin-or.org/download/source/Data/Data-Netlib-1.2.9.tgz"
  sha256 ""
=======
  homepage "https://github.com/coin-or-tools/Data-Netlib" # Updated homepage url reference to GitHub
  url "https://github.com/coin-or-tools/Data-Netlib/archive/releases/1.2.9.tar.gz" # Updated url reference to GitHub, version updated to 1.2.9
  sha256 "cfc9f4ca02db25458cce66f2b9128daf623cb9204ef41e980fc42dedeb0f76d0" # Updated sha256 checksum to match updated version
  head "https://github.com/coin-or-tools/Data-Netlib/tree/releases/1.2.9" # Added head and made url reference to GitHub for version 1.2.9
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
