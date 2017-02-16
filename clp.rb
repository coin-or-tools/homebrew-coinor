class Clp < Formula
  desc "Linear programming solver"
  homepage "https://projects.coin-or.org/Clp"
  url "http://www.coin-or.org/download/pkgsource/Clp/Clp-1.16.7.tgz"
  sha256 "05e8537c334d086b945389ea42a17ee70e4c192d1ff67ac6ab38817ace24b207"
  head "https://projects.coin-or.org/svn/Clp/trunk"

  option "with-glpk", "Build with support for reading AMPL/GMPL models"

  glpk_dep = (build.with? "glpk") ? ["with-glpk"] : []
  openblas_dep = (build.with? "openblas") ? ["with-openblas"] : []

  depends_on "homebrew/science/openblas" => :optional
  depends_on "homebrew/science/glpk448" if build.with? "glpk"
  depends_on "homebrew/science/asl" => :optional
  depends_on "homebrew/science/mumps" => [:optional, "without-mpi"] + openblas_dep

  ss_opts = openblas_dep.clone
  ss_opts << :optional if build.without? "glpk"
  depends_on "homebrew/science/suite-sparse" => ss_opts

  depends_on "coinutils"
  depends_on "osi" => (glpk_dep + openblas_dep)

  depends_on "readline" => :recommended
  depends_on :fortran
  depends_on "pkg-config" => :build

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
