class Clp < Formula
  desc "Linear programming solver"
  homepage "https://github.com/coin-or/Clp"
  url "https://github.com/coin-or/Clp/archive/refs/tags/releases/1.17.7.tar.gz"
  sha256 "c4c2c0e014220ce8b6294f3be0f3a595a37bef58a14bf9bac406016e9e73b0f5"

  head "https://github.com/coin-or/Clp.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/clp-1.17.6_1"
    sha256 cellar: :any,                 big_sur:      "d34b4a2691d2a93e7b6333a321fe8de10317ca662c1ab94d27a98b4bdb963cfb"
    sha256 cellar: :any,                 catalina:     "274d598a7edf376e015d47fa257cf1f142e22bc4880e63fbb021cbfccccdda45"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5115d4f19f48c240308dd561939bb54c40036ae5f43fef7c8ac53fe8cf3a4788"
  end

  keg_only "conflicts with formula in core"

  depends_on "pkg-config" => :build

  depends_on "ampl-mp"
  depends_on "coin-or-tools/coinor/coinutils"
  depends_on "coin-or-tools/coinor/glpk@448"
  depends_on "coin-or-tools/coinor/mumps-seq"
  depends_on "coin-or-tools/coinor/osi"
  depends_on "gcc"
  depends_on "readline"
  depends_on "openblas" => :recommended
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

    args << "--with-asl-incdir=#{Formula["ampl-mp"].opt_include}/asl"
    args << "--with-asl-lib=-L#{Formula["ampl-mp"].opt_lib} -lasl"

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
