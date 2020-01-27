class CoinDataSample < Formula
  desc "Sample models"
  homepage "https://www.coin-or.org/download/source/Data"
  url "https://www.coin-or.org/download/source/Data/Data-Sample-1.2.11.tgz"
  sha256 "7d201dc37098dd1f7d68c24d71ca8083eaaa344ec44bd18799ac6245363f8467"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
