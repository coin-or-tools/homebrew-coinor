class CoinDataMiplib3 < Formula
  desc "MIPLib models"
  homepage "https://github.com/coin-or-tools/Data-miplib3"
  url "https://github.com/coin-or-tools/Data-miplib3/archive/refs/tags/releases/1.2.7.tar.gz"
  sha256 "49578f714cd87247510747b8c63886ed3a6a1a90ffbbbf7e3cb772657737d622"
  revision 1

  head "https://github.com/coin-or-tools/Data-miplib3.git"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
