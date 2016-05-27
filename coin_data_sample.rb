class CoinDataSample < Formula
  desc "Sample models"
  homepage "http://www.coin-or.org/download/pkgsource/Data"
  url "http://www.coin-or.org/download/pkgsource/Data/Data-Sample-1.2.10.tgz"
  sha256 "ec7de931a06126040910964b6ce89a3d0cf64132fdde187689cc13277e2c1985"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
