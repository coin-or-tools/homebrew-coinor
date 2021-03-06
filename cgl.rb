class Cgl < Formula
  desc "Cut-generation library"
  homepage "https://github.com/coin-or/Cgl" 
  url "https://github.com/coin-or/Cgl/archive/releases/0.60.3.tar.gz" 
  sha256 "cfeeedd68feab7c0ce377eb9c7b61715120478f12c4dd0064b05ad640e20f3fb"
  head "https://github.com/coin-or/Cgl/tree/releases/0.60.3/Cgl" 

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
