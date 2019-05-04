class Cbc < Formula
  desc "Mixed integer linear programming solver"
  homepage "https://projects.coin-or.org/Cbc"
  url "https://www.coin-or.org/download/pkgsource/Cbc/Cbc-2.10.2.tgz"
  sha256 "4fab575d135703c231e8492c2389a25a8dfe92aed2cc3f1149babf976e7a2f84"
  head "https://projects.coin-or.org/svn/Cbc/trunk"
  revision 1

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
