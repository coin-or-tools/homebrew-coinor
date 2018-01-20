class Cbc < Formula
  desc "Mixed integer linear programming solver"
  homepage "https://projects.coin-or.org/Cbc"
  url "https://www.coin-or.org/download/pkgsource/Cbc/Cbc-2.9.9.tgz"
  sha256 "2b905d1b39132a84ba624cc6f5910eb4b8d864dec4f061a2afbc030c5d802df4"
  head "https://projects.coin-or.org/svn/Cbc/trunk"

  option "with-glpk", "Build with support for reading AMPL/GMPL models"

  depends_on "ampl-mp" => :optional
  depends_on "gcc"
  depends_on "glpk448" if build.with? "glpk"
  depends_on "dpo/openblas/mumps" => [:optional, "without-open-mpi"]
  depends_on "openblas" => :optional
  depends_on "pkg-config" => :build
  depends_on "suite-sparse" => :optional

  asl_dep = (build.with? "ampl-mp") ? ["with-ampl-mp"] : []
  glpk_dep = (build.with? "glpk") ? ["with-glpk"] : []
  openblas_dep = (build.with? "openblas") ? ["with-openblas"] : []
  mumps_dep = (build.with? "mumps") ? ["with-mumps"] : []
  suite_sparse_dep = (build.with? "suite-sparse") ? ["with-suite-sparse"] : []

  depends_on "clp" => (asl_dep + glpk_dep + openblas_dep + mumps_dep + suite_sparse_dep)
  depends_on "cgl"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/cbc",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"]

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
