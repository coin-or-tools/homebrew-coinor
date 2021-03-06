class CoinDataSample < Formula
  desc "Sample models"
  homepage "https://github.com/coin-or-tools/Data-Sample"
  url "https://github.com/coin-or-tools/Data-Sample/archive/releases/1.2.12.tar.gz"
  sha256 "e9e67c04adfbd85523890b346326b106075df615e922c229277e138dbcb77e64" 
  head "https://github.com/coin-or-tools/Data-Sample/tree/releases/1.2.12" 

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
