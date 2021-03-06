class Cbc < Formula
  desc "Mixed integer linear programming solver"
  homepage "https://github.com/coin-or/Cbc"
  url "https://github.com/coin-or/Cbc/archive/releases/2.10.5.tar.gz"
  sha256 "6b823a3fab554774018ec636f21f73ac7edd439b995dc0897a187dd657b23f18"
  head "https://github.com/coin-or/Cbc/tree/releases/2.10.5/Cbc"
  revision 2

  option "with-glpk", "Build with support for reading AMPL/GMPL models"
  option "with-parallel", "Build with parallel mode enabled"

  depends_on "ampl-mp" => :optional
  depends_on "gcc"
  depends_on "glpk448" if build.with? "glpk"
  depends_on "dpo/openblas/mumps" => [:optional, "without-mpi"]
  depends_on "openblas" => :optional
  depends_on "pkg-config" => :build
  depends_on "suite-sparse" => :optional

  asl_dep = (build.with? "ampl-mp") ? ["with-ampl-mp"] : []
  glpk_dep = (build.with? "glpk") ? ["with-glpk"] : []
  openblas_dep = (build.with? "openblas") ? ["with-openblas"] : []
  mumps_dep = (build.with? "mumps") ? ["with-mumps"] : []
  suite_sparse_dep = (build.with? "suite-sparse") ? ["with-suite-sparse"] : []

  depends_on "coin-or-tools/coinor/clp" => (asl_dep + glpk_dep + openblas_dep + mumps_dep + suite_sparse_dep)
  depends_on "coin-or-tools/coinor/cgl"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/cbc",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"]

    args << "--enable-cbc-parallel" if build.with? "parallel"

    if build.with? "glpk"
      args << "--with-glpk-lib=-L#{Formula["glpk448"].opt_lib} -lglpk"
      args << "--with-glpk-incdir=#{Formula["glpk448"].opt_include}"
    end

    if build.with? "ampl-mp"
      args << "--with-asl-incdir=#{Formula["ampl-mp"].opt_include}/asl"
      args << "--with-asl-lib=-L#{Formula["ampl-mp"].opt_lib} -lasl"
    end

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
