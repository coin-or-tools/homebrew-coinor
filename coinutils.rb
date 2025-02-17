class Coinutils < Formula
  desc "Utilities used by other Coin-OR projects"
  homepage "https://github.com/coin-or/CoinUtils"
  url "https://github.com/coin-or/CoinUtils/archive/refs/tags/releases/2.11.11.tar.gz"
  sha256 "27da344479f38c82112d738501643dcb229e4ee96a5f87d4f406456bdc1b2cb4"
  revision 1

  head "https://github.com/coin-or/CoinUtils.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coinutils-2.11.11_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "efdfa0d4e0d2b1cb2b0940d90e33ac10ad18010cf0f91f968e207941fa890502"
  end

  keg_only "conflicts with formula in core"

  depends_on "graphviz" => :build # For documentation.
  depends_on "pkg-config" => :build

  depends_on "bzip2" if OS.linux?
  depends_on "coin-or-tools/coinor/coin_data_netlib"
  depends_on "coin-or-tools/coinor/coin_data_sample"
  depends_on "coin-or-tools/coinor/glpk@448"
  depends_on "doxygen"
  depends_on "gcc"
  depends_on "openblas"
  depends_on "zlib"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/coinutils",
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

    system "./configure", *args

    system "make"
    ENV.deparallelize # make install fails in parallel.
    system "make", "test"
    system "make", "install"
  end
end
