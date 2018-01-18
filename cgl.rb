class Cgl < Formula
  desc "Cut-generation library"
  homepage "https://projects.coin-or.org/Cgl"
  url "https://www.coin-or.org/download/pkgsource/Cgl/Cgl-0.59.9.tgz"
  sha256 "d2d43e2a062f2c23328e6910a2606a7da49dec15d8fb4482f894293f6595e7b8"
  head "https://projects.coin-or.org/svn/Cgl/trunk"

  option "with-asl", "Build CLP with ASL support"
  option "with-glpk", "Build CLP with support for reading AMPL/GMPL models"
  option "with-mumps", "Build CLP with MUMPS support"
  option "with-openblas", "Build CLP with OpenBLAS support"
  option "with-suite-sparse", "Build CLP with SuiteSparse support"

  asl_dep = (build.with? "asl") ? ["with-asl"] : []
  glpk_dep = (build.with? "glpk") ? ["with-glpk"] : []
  mumps_dep = (build.with? "mumps") ? ["with-mumps"] : []
  openblas_dep = (build.with? "openblas") ? ["with-openblas"] : []
  suitesparse_dep = (build.with? "suite-sparse") ? ["with-suite-sparse"] : []

  depends_on "clp" => (asl_dep + glpk_dep + mumps_dep + openblas_dep + suitesparse_dep)

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/cgl",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-dot",
           ]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
