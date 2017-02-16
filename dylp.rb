class Dylp < Formula
  desc "Dynamic simplex algorithm for linear programming"
  homepage "https://projects.coin-or.org/DyLP"
  url "http://www.coin-or.org/download/pkgsource/DyLP/DyLP-1.10.2.tgz"
  sha256 "d17ff86c313aec7e6e00aa7abb3665446390096570cd141bf438afd65723db90"
  head "https://projects.coin-or.org/svn/Dylp/trunk"

  depends_on "osi"
  depends_on "pkg-config" => :build

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/dylp",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot",
           ]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
