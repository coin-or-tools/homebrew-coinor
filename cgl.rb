class Cgl < Formula
  desc "Cut-generation library"
  homepage "https://github.com/coin-or/Cgl"
  url "https://github.com/coin-or/Cgl/archive/refs/tags/releases/0.60.9.tar.gz"
  sha256 "558421ccd6aa91d6922dd1baa04e37aa4c75ba0472118dc11779e5d6a19bfb38"

  head "https://github.com/coin-or/Cgl.git"

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
