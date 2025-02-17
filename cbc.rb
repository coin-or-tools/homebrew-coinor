class Cbc < Formula
  desc "Mixed integer linear programming solver"
  homepage "https://github.com/coin-or/Cbc"
  url "https://github.com/coin-or/Cbc/archive/refs/tags/releases/2.10.7.tar.gz"
  sha256 "5aa5490e2bc39c3c03f3636c9bca459cb3f8f365e0280fd0c4759ce3119e5b19"
  revision 2

  head "https://github.com/coin-or/Cbc.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/cbc-2.10.7_2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d63e3c76714ebe7781d249155cf0ffba6a7332d62b740ed9bbf751e642085710"
  end

  keg_only "conflicts with formula in core"

  depends_on "pkg-config" => :build

  depends_on "ampl-mp@3.1.0"
  depends_on "bzip2"
  depends_on "coin-or-tools/coinor/cgl"
  depends_on "coin-or-tools/coinor/clp"
  depends_on "coin-or-tools/coinor/coinutils"
  depends_on "coin-or-tools/coinor/glpk@448"
  depends_on "coin-or-tools/coinor/mumps-seq"
  depends_on "coin-or-tools/coinor/osi"
  depends_on "gcc"
  depends_on "openblas"
  depends_on "zlib"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/cbc",
            "--with-sample-datadir=#{Formula["coin-or-tools/coinor/coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin-or-tools/coinor/coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--enable-cbc-parallel",
            "--with-dot"]

    args << "--with-glpk-lib=-L#{Formula["coin-or-tools/coinor/glpk@448"].opt_lib} -lglpk"
    args << "--with-glpk-incdir=#{Formula["coin-or-tools/coinor/glpk@448"].opt_include}"

    args << "--with-asl-incdir=#{Formula["ampl-mp@3.1.0"].opt_include}/asl"
    args << "--with-asl-lib=-L#{Formula["ampl-mp@3.1.0"].opt_lib} -lasl"

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
