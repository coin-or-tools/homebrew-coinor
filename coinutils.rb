class Coinutils < Formula
  desc "Utilities used by other Coin-OR projects"
  homepage "https://github.com/coin-or/CoinUtils"
  url "https://github.com/coin-or/CoinUtils/archive/refs/tags/releases/2.11.13.tar.gz"
  sha256 "ddfea48e10209215748bc9f90a8c04abbb912b662c1aefaf280018d0a181ef79"
  revision 1
  
  head "https://github.com/coin-or/CoinUtils.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coinutils-2.11.13"
    sha256 cellar: :any,                 arm64_tahoe:  "8eeb4bb5b32c8c260afac3164b27686948c0559020e293dbc624f42534c02dcf"
    sha256 cellar: :any,                 arm64_sonoma: "92c4216e87a59720fea004ed6996d402fe3bd68cba78ec1816223e79f1d27934"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "acc4071c849d6928363ca6d8726484ac37e53f4acfba70018c34c1b1a911a245"
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
  depends_on "zlib-ng-compat"

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
