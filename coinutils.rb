class Coinutils < Formula
  desc "Utilities used by other Coin-OR projects"
  homepage "https://projects.coin-or.org/CoinUtils"
  url "https://www.coin-or.org/download/pkgsource/CoinUtils/CoinUtils-2.11.2.tgz"
  sha256 "f27b76617d090fb82fba6229ce165c7acfef5d5d1fff40528c6bad4e55a4477b"

  option "with-glpk", "Build with support for reading AMPL/GMPL models"

  depends_on "gcc"

  depends_on "coin_data_sample"
  depends_on "coin_data_netlib"

  depends_on "doxygen"
  depends_on "graphviz" => :build # For documentation.
  depends_on "pkg-config" => :build

  depends_on "openblas" => :optional
  depends_on "glpk448" if build.with? "glpk"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/coinutils",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"]

    if build.with? "openblas"
      openblaslib = "-L#{Formula["openblas"].opt_lib} -lopenblas"
      openblasinc = Formula["openblas"].opt_include.to_s
      args << "--with-blas-lib=#{openblaslib}"
      args << "--with-blas-incdir=#{openblasinc}"
      args << "--with-lapack-lib=#{openblaslib}"
      args << "--with-lapack-incdir=#{openblasinc}"
    end

    if build.with? "glpk"
      args << "--with-glpk-lib=-L#{Formula["glpk448"].opt_lib} -lglpk"
      args << "--with-glpk-incdir=#{Formula["glpk448"].opt_include}"
    end

    system "./configure", *args

    system "make"
    ENV.deparallelize # make install fails in parallel.
    system "make", "test"
    system "make", "install"
  end
end
