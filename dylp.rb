class Dylp < Formula
  desc "Dynamic simplex algorithm for linear programming"
  homepage "https://projects.coin-or.org/DyLP"
  url "https://www.coin-or.org/download/pkgsource/DyLP/DyLP-1.10.3.tgz"
  sha256 "34984099975e324864ec8b585208007708097ca9d1738e9a3ee6292f43942456"
  head "https://projects.coin-or.org/svn/DyLP/trunk"

  depends_on "coin-or-tool/coinor/osi"

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
