class Osi < Formula
  desc "abstract class to a generic linear programming solver, and derived classes for specific solvers"
  homepage "https://projects.coin-or.org/Osi/"
  url "http://www.coin-or.org/download/pkgsource/Osi/Osi-0.107.5.tgz"
  sha256 "c578256853109e33a8ad8f1917ca8850a027d8a0987ef87166d34de1a256a57d"
  head "https://projects.coin-or.org/svn/Osi/trunk"

  depends_on "coinutils"

  depends_on "doxygen"

  depends_on "graphviz" => :build  # For documentation.
  depends_on "pkg-config" => :build

  depends_on "homebrew/science/glpk" => :optional
  depends_on "homebrew/science/openblas" => :optional

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/osi",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"
           ]

    if build.with? "glpk"
      args << "--with-glpk-lib=-L#{Formula["glpk"].opt_lib} -lglpk"
      args << "--with-glpk-incdir=#{Formula["glpk"].opt_include}"
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

    ENV.deparallelize  # make fails in parallel.
    system "make"
    system "make", "test"
    system "make", "install"
  end
end
