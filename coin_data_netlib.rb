class CoinDataNetlib < Formula
  desc "Netlib LP models"
  homepage "https://github.com/coin-or-tools/Data-Netlib"
  url "https://github.com/coin-or-tools/Data-Netlib/archive/refs/tags/releases/1.2.8.tar.gz"
  sha256 "4675357aae83d70ebf1b5874bbda1bd89fabf462dac7e4a0fffb202b1e9c4129"
  revision 1

  head "https://github.com/coin-or-tools/Data-Netlib.git"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
