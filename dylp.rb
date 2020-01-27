class Dylp < Formula
  desc "Dynamic simplex algorithm for linear programming"
  homepage "https://projects.coin-or.org/DyLP"
  url "https://www.coin-or.org/download/pkgsource/DyLP/DyLP-1.10.4.tgz"
  sha256 "1cf833257a9a849bbb880228565aafc625a842999c3ff322f34f0b352892798b"
  head "https://projects.coin-or.org/svn/DyLP/trunk"

  depends_on "coin-or-tools/coinor/osi"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/dylp",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
