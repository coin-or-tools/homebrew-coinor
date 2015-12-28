class Coinutils < Formula
  desc "Utilities used by other Coin-OR projects"
  homepage "http://www.coin-or.org/projects/CoinUtils.xml"
  url "http://www.coin-or.org/download/pkgsource/CoinUtils/CoinUtils-2.10.10.tgz"
  sha256 "bedace82a76d4644efabb3a0bce03d5f00933a8500dbff084a7b7791aeb91561"

  option "with-glpk", "Build with support for reading AMPL/GMPL models" 

  depends_on :fortran

  depends_on "coin_data_sample"
  depends_on "coin_data_netlib"

  depends_on "doxygen"
  depends_on "graphviz" => :build  # For documentation.
  depends_on "pkg-config" => :build

  depends_on "homebrew/science/openblas" => :optional
  depends_on "homebrew/science/glpk448" if build.with? "glpk"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/coinutils",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot",
           ]

    if build.with? "glpk"
      args << "--with-glpk-lib=-L#{Formula["glpk448"].opt_lib} -lglpk"
      args << "--with-glpk-incdir=#{Formula["glpk448"].opt_include}"
    end

    if build.with? "openblas"
      openblaslib = "-L#{Formula["openblas"].opt_lib} -lopenblas"
      openblasinc = "#{Formula["openblas"].opt_include}"
      args << "--with-blas-lib=#{openblaslib}"
      args << "--with-blas-incdir=#{openblasinc}"
      args << "--with-lapack-lib=#{openblaslib}"
      args << "--with-lapack-incdir=#{openblasinc}"
    end

    system "./configure", *args

    system "make"
    ENV.deparallelize  # make install fails in parallel.
    system "make", "test"
    system "make", "install"
  end
end
