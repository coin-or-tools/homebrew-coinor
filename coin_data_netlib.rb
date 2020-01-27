class CoinDataNetlib < Formula
  desc "Netlib LP models"
  homepage "https://www.coin-or.org/download/source/Data"
  url "https://www.coin-or.org/download/source/Data/Data-Netlib-1.2.8.tgz"
  sha256 "f6358d756a1d0ae2ac159a422ceb661f080bf527f7b5a3e30320839beb8de3e4"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
