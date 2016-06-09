class CoinDataNetlib < Formula
  desc "Netlib LP models"
  homepage "http://www.coin-or.org/download/pkgsource/Data"
  url "http://www.coin-or.org/download/pkgsource/Data/Data-Netlib-1.2.6.tgz"
  sha256 "dd687e5a35087ae0da825c5e24832b2ebaacc36a2ee73df084d4ef92e575e1ab"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
