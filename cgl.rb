class Cgl < Formula
  desc "Cut-generation library"
  homepage "https://github.com/coin-or/Cgl"
  url "https://github.com/coin-or/Cgl/archive/refs/tags/releases/0.60.5.tar.gz"
  sha256 "5a2e7ca380425b3d7279d0759c625a367d06ec8293698b59f82fae38ae5df64e"
  revision 1

  head "https://github.com/coin-or/Cgl.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/cgl-0.60.5_1"
    sha256 cellar: :any,                 big_sur:      "cc216ff362787ae8eded9927aa5e42cd41359b8bbe0eda1772fe7deeb5486919"
    sha256 cellar: :any,                 catalina:     "26c93fa9913d68a8adee0b3aea306ef0f592ee8a83fccb0616b3cf07e1359c4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bf8626f34b7734320781b94ec047fce63e7ddcc3dc7ea7ae2141e3a44d3d247f"
  end

  keg_only "conflicts with formula in core"

  depends_on "pkg-config" => :build

  depends_on "ampl-mp@3.1.0"
  depends_on "bzip2"
  depends_on "coin-or-tools/coinor/clp"
  depends_on "coin-or-tools/coinor/coinutils"
  depends_on "coin-or-tools/coinor/glpk@448"
  depends_on "coin-or-tools/coinor/mumps-seq"
  depends_on "coin-or-tools/coinor/osi"
  depends_on "zlib"
  depends_on "openblas"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/cgl",
            "--with-sample-datadir=#{Formula["coin-or-tools/coinor/coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-clp-lib=-L#{Formula["coin-or-tools/coinor/clp"].opt_lib} -lClp",
            "--with-clp-incdir=#{Formula["coin-or-tools/coinor/clp"].opt_include}/clp/coin",
            "--with-dot",
            "--without-osidylp",
            "--without-osivol"]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
