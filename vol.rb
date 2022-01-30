class Vol < Formula
  desc "Subgradient method that produces primal and dual solutions"
  homepage "https://github.com/coin-or/Vol"
  url "https://github.com/coin-or/Vol/archive/refs/tags/releases/1.5.4.tar.gz"
  sha256 "93c2afff8ce920de964fee5e679f5c11de3c3f472ebccde62fb513d8d3a9f467"
  revision 1

  head "https://github.com/coin-or/Vol.git"

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
