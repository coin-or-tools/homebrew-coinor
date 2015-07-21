class CoinDataNetlib < Formula
  desc "Netlib LP models"
  homepage "http://www.coin-or.org/download/pkgsource/Data"
  url "http://www.coin-or.org/download/source/Data/Netlib-1.2.6.tgz"
  sha256 "02b3ef5cc7cce6ecf3778181f34faf8c1733af0e73cba09367d7fbd905b462b7"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}"
    system "make", "install"
  end
end
