class Dylp < Formula
  desc "Dynamic simplex algorithm for linear programming"
  homepage "https://github.com/coin-or/DyLP"
  url "https://github.com/coin-or/DyLP/archive/refs/tags/releases/1.10.4.tar.gz"
  sha256 "5825bede088d78af772cb9a348d10032895d824461c8d22dbd76a70caa8b5b00"
  revision 1

  head "https://github.com/coin-or/DyLP.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/dylp-1.10.4_1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f45199230bd5237d36a09c24cf791abac0b819bef408b0df086bd9fa9d5f5482"
  end

  depends_on "bzip2"
  depends_on "coin-or-tools/coinor/coinutils"
  depends_on "coin-or-tools/coinor/glpk@448"
  depends_on "coin-or-tools/coinor/osi"
  depends_on "openblas"
  depends_on "zlib-ng-compat"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/dylp",
            "--with-sample-datadir=#{Formula["coin-or-tools/coinor/coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin-or-tools/coinor/coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
