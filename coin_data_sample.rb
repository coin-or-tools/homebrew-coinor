class CoinDataSample < Formula
  desc "Sample models"
  homepage "https://www.coin-or.org/download/source/Data"
  url "https://www.coin-or.org/download/source/Data/Data-Sample-1.2.10.tgz"
  sha256 "aaa25196f742a7905bab4e5021224a3b4000dd017b0f00bd05c890f7e6284f76"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
