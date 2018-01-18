class CoinDataMiplib3 < Formula
  desc "MIPLib models"
  homepage "https://www.coin-or.org/download/source/Data"
  url "https://www.coin-or.org/download/source/Data/Data-miplib3-1.2.6.tgz"
  sha256 "076d933c531ec65aa94945c7ba47c7bc0258d3844b7def5b3d62632c3fd961b8"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
