class Osi < Formula
  desc "Abstract class to generic LP solver, derived classes for specific solvers"
  homepage "https://github.com/coin-or/Osi"
  url "https://github.com/coin-or/Osi/archive/refs/tags/releases/0.108.10.tar.gz"
  sha256 "614c2b329caf57c00326412266299fdfd93c5691492034fbb46990b5e71cc5a7"

  head "https://github.com/coin-or/Osi.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/osi-0.108.10"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b5b9cc1463d6ec5ecad3d811901f7786ac2fab12feb3aa630497cdc9faf0de81"
  end

  keg_only "conflicts with formula in core"

  depends_on "pkg-config" => :build

  depends_on "coin-or-tools/coinor/coinutils"
  depends_on "coin-or-tools/coinor/glpk@448"
  depends_on "openblas" => :recommended

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/osi",
            "--with-sample-datadir=#{Formula["coin-or-tools/coinor/coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin-or-tools/coinor/coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot",
            "--with-glpk-lib=-L#{Formula["coin-or-tools/coinor/glpk@448"].opt_lib} -lglpk",
            "--with-glpk-incdir=#{Formula["coin-or-tools/coinor/glpk@448"].opt_include}"]

    # the build fails if we include the location of CoinUtils: symbols that are in libglpk are supposedly undefined
    # "--with-coinutils-lib=-L#{Formula["coin-or-tools/coinor/coinutils"].opt_lib} -lCoinUtils",
    # "--with-coinutils-incdir=#{Formula["coin-or-tools/coinor/coinutils"].opt_include}/coinutils/coin"]

    if build.with? "openblas"
      openblaslib = "-L#{Formula["openblas"].opt_lib} -lopenblas"
      openblasinc = Formula["openblas"].opt_include.to_s
      args << "--with-blas-lib=#{openblaslib}"
      args << "--with-blas-incdir=#{openblasinc}"
      args << "--with-lapack-lib=#{openblaslib}"
      args << "--with-lapack-incdir=#{openblasinc}"
    end

    system "./configure", *args

    ENV.deparallelize # make fails in parallel.
    system "make"
    system "make", "test"
    system "make", "install"
  end
end
