class Dylp < Formula
  desc "Dynamic simplex algorithm for linear programming"
  homepage "https://github.com/coin-or/DyLP"
  url "https://github.com/coin-or/DyLP/archive/refs/tags/releases/1.10.4.tar.gz"
  sha256 "5825bede088d78af772cb9a348d10032895d824461c8d22dbd76a70caa8b5b00"
  revision 1

  head "https://github.com/coin-or/DyLP.git"

  depends_on "coin-or-tools/coinor/osi"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/dylp",
            "--with-sample-datadir=#{Formula["coin-or-tools/coinor/coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin-or-tools/coinor/coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
