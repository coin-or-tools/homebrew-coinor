class Cgl < Formula
  desc "Cut-generation library"
  homepage "https://projects.coin-or.org/Cgl"
  url "https://www.coin-or.org/download/pkgsource/Cgl/Cgl-0.60.2.tgz"
  sha256 "44ce4c567a55d4e7550c31f9255e655e365108f03a2cd55db623c142a535a9e9"
  head "https://projects.coin-or.org/svn/Cgl/trunk"

  option "with-ampl-mp", "Build CLP with ASL support"
  option "with-glpk", "Build CLP with support for reading AMPL/GMPL models"
  option "with-mumps", "Build CLP with MUMPS support"
  option "with-openblas", "Build CLP with OpenBLAS support"
  option "with-suite-sparse", "Build CLP with SuiteSparse support"

  asl_dep = (build.with? "ampl-mp") ? ["with-ampl-mp"] : []
  glpk_dep = (build.with? "glpk") ? ["with-glpk"] : []
  mumps_dep = (build.with? "mumps") ? ["with-mumps"] : []
  openblas_dep = (build.with? "openblas") ? ["with-openblas"] : []
  suitesparse_dep = (build.with? "suite-sparse") ? ["with-suite-sparse"] : []

  depends_on "coin-or-tools/coinor/clp" => (asl_dep + glpk_dep + mumps_dep + openblas_dep + suitesparse_dep)
  depends_on "pkg-config" => :build

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/cgl",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-dot"]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
