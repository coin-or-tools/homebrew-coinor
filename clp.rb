class Clp < Formula
  desc "Linear programming solver"
  homepage "https://github.com/coin-or/Clp"
  url "https://github.com/coin-or/Clp/archive/refs/tags/releases/1.17.6.tar.gz"
  sha256 "afff465b1620cfcbb7b7c17b5d331d412039650ff471c4160c7eb24ae01284c9"
  head "https://projects.coin-or.org/svn/Clp/trunk"

  option "with-glpk", "Build with support for reading AMPL/GMPL models"

  glpk_dep = build.with?("glpk") ? ["with-glpk"] : []
  openblas_dep = build.with?("openblas") ? ["with-openblas"] : []

  depends_on "ampl-mp" => :optional
  depends_on "gcc"
  depends_on "glpk448" if build.with? "glpk"
  depends_on "openblas" => :optional
  depends_on "suite-sparse" => :optional if build.without? "glpk"

  depends_on "dpo/openblas/mumps" => [:optional, "without-open-mpi"]

  depends_on "coin-or-tools/coinor/coinutils"
  depends_on "coin-or-tools/coinor/osi" => (glpk_dep + openblas_dep)
  depends_on "pkg-config" => :build

  depends_on "readline" => :recommended

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/clp",
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

    if build.with? "asl"
      args << "--with-asl-incdir=#{Formula["asl"].opt_include}/asl"
      args << "--with-asl-lib=-L#{Formula["asl"].opt_lib} -lasl"
    end

    if build.with? "mumps"
      mumps_libs = %w[-ldmumps -lmumps_common -lpord -lmpiseq]
      mumps_libcmd = "-L#{Formula["mumps"].opt_lib} " + mumps_libs.join(" ")
      args << "--with-mumps-incdir=#{Formula["mumps"].opt_libexec}/include"
      args << "--with-mumps-lib=#{mumps_libcmd}"
    end

    if (build.with? "glpk") || (build.with? "suite-sparse")
      args << "--with-amd-incdir=#{Formula["suite-sparse"].opt_include}"
      args << "--with-amd-lib=-L#{Formula["suite-sparse"].opt_lib} -lamd"
      args << "--with-cholmod-incdir=#{Formula["suite-sparse"].opt_include}"
      args << "--with-cholmod-lib=-L#{Formula["suite-sparse"].opt_lib} -lcolamd -lcholmod -lsuitesparseconfig"
    end

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
