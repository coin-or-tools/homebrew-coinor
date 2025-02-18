class Clp < Formula
  desc "Linear programming solver"
  homepage "https://github.com/coin-or/Clp"
  url "https://github.com/coin-or/Clp/archive/refs/tags/releases/1.17.10.tar.gz"
  sha256 "0d79ece896cdaa4a3855c37f1c28e6c26285f74d45f635046ca0b6d68a509885"

  head "https://github.com/coin-or/Clp.git"

  keg_only "conflicts with formula in core"

  depends_on "pkg-config" => :build

  depends_on "ampl-mp@3.1.0"
  depends_on "bzip2"
  depends_on "coin-or-tools/coinor/coinutils"
  depends_on "coin-or-tools/coinor/glpk@448"
  depends_on "coin-or-tools/coinor/mumps-seq"
  depends_on "coin-or-tools/coinor/osi"
  depends_on "gcc"
  depends_on "openblas"
  depends_on "readline"
  depends_on "zlib"
  depends_on "suite-sparse" => :optional

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/clp",
            "--with-sample-datadir=#{Formula["coin-or-tools/coinor/coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin-or-tools/coinor/coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"]

    if build.with? "openblas"
      openblaslib = "-L#{Formula["openblas"].opt_lib} -lopenblas"
      openblasinc = Formula["openblas"].opt_include.to_s
      args << "--with-blas-lib=#{openblaslib}"
      args << "--with-blas-incdir=#{openblasinc}"
      args << "--with-lapack-lib=#{openblaslib}"
      args << "--with-lapack-incdir=#{openblasinc}"
    end

    args << "--with-glpk-lib=-L#{Formula["coin-or-tools/coinor/glpk@448"].opt_lib} -lglpk"
    args << "--with-glpk-incdir=#{Formula["coin-or-tools/coinor/glpk@448"].opt_include}"

    args << "--with-asl-incdir=#{Formula["ampl-mp@3.1.0"].opt_include}/asl"
    args << "--with-asl-lib=-L#{Formula["ampl-mp@3.1.0"].opt_lib} -lasl"

    mumps_libs = %w[-ldmumps -lmumps_common -lpord -lmpiseq]
    mumps_libcmd = "-L#{Formula["coin-or-tools/coinor/mumps-seq"].opt_lib} " + mumps_libs.join(" ")
    args << "--with-mumps-incdir=#{Formula["coin-or-tools/coinor/mumps-seq"].opt_libexec}/include"
    args << "--with-mumps-lib=#{mumps_libcmd}"

    if build.with? "suite-sparse"
      # configure: error: Cannot find symbol(s) amd_defaults with AMD
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
