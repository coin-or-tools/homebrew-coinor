class Dylp < Formula
  desc "Dynamic simplex algorithm for linear programming"
  homepage "https://github.com/coin-or/DyLP"
  url "https://github.com/coin-or/DyLP/archive/refs/tags/releases/1.10.4.tar.gz"
  sha256 "5825bede088d78af772cb9a348d10032895d824461c8d22dbd76a70caa8b5b00"
  revision 1

  head "https://github.com/coin-or/DyLP.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/dylp-1.10.4_1"
    sha256 cellar: :any,                 big_sur:      "60ae7cae035dd7bcb4f6569ba4875cbdc456ab408938f469d484150ed5d11686"
    sha256 cellar: :any,                 catalina:     "fdc3f16f2765661ed2be22b1a18cfb59f66f6705483d801470e7e8c4f532f5e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a74f36a134e76e42db9381a9a7403878d6788222f2372cfb60c76e8f4e151c26"
  end

  depends_on "coin-or-tools/coinor/osi"

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
