class Vol < Formula
  desc "Subgradient method that produces primal and dual solutions"
  homepage "https://github.com/coin-or/Vol"
  url "https://github.com/coin-or/Vol/archive/refs/tags/releases/1.5.4.tar.gz"
  sha256 "93c2afff8ce920de964fee5e679f5c11de3c3f472ebccde62fb513d8d3a9f467"
  revision 1

  head "https://github.com/coin-or/Vol.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/vol-1.5.4_1"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:  "55a0c20cb995b953318164438c42d480f0e1d0c155e6e29879e1c681b0e1b820"
    sha256 cellar: :any,                 arm64_sonoma: "f2ed46c868db2c9022f0c555543e71ef8279a392ba202da130ecb61aa4bd530d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8b5c2d16658982a9a8bd5219b75db01262439d1c69cca12b1bcdaa11f5f59eba"
  end

  depends_on "bzip2"
  depends_on "coin-or-tools/coinor/coinutils"
  depends_on "coin-or-tools/coinor/glpk@448"
  depends_on "coin-or-tools/coinor/osi"
  depends_on "coin_data_sample"
  depends_on "openblas"
  depends_on "zlib-ng-compat"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/vol",
            "--with-sample-datadir=#{Formula["coin-or-tools/coinor/coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-dot"]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
