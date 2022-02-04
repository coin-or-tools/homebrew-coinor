class Vol < Formula
  desc "Subgradient method that produces primal and dual solutions"
  homepage "https://github.com/coin-or/Vol"
  url "https://github.com/coin-or/Vol/archive/refs/tags/releases/1.5.4.tar.gz"
  sha256 "93c2afff8ce920de964fee5e679f5c11de3c3f472ebccde62fb513d8d3a9f467"
  revision 1

  head "https://github.com/coin-or/Vol.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/vol-1.5.4_1"
    sha256 cellar: :any,                 big_sur:      "68a64053bafb6f61ac5746b48f3cee0c55cd9c7c2df6c495fbcee3e28fbe6b38"
    sha256 cellar: :any,                 catalina:     "bf119993d785ed6ba7a0e751c0a88269900b25ea8c2b7798b85a35e8a8869030"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2943549f09c8b8c83bbfc8118cd46011f78a3518cfc32647ced86d2a3df1f72e"
  end

  depends_on "coin_data_sample"
  depends_on "coin-or-tools/coinor/osi" => :recommended

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
