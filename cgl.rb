class Cgl < Formula
  desc "Cut-generation library"
  homepage "https://github.com/coin-or/Cgl"
  url "https://github.com/coin-or/Cgl/archive/refs/tags/releases/0.60.10.tar.gz"
  sha256 "41b7ac9402db883d9c487eb7101e59eb513cefd726e6e7a669dc94664d9385e6"

  head "https://github.com/coin-or/Cgl.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/cgl-0.60.10"
    sha256 cellar: :any,                 arm64_sonoma: "5e75f7757f2771040c325de0cea03d0150cc6b466348448a997e18095d1d9c76"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8981d561bd07a5ddd06e1f20f3f37498d36cd5293022a36b4fa64a046a0b2553"
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
  depends_on "openblas"
  depends_on "zlib"
  depends_on "zlib-ng-compat"

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
