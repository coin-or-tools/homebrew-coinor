class Vol < Formula
  desc "Subgradient method that produces primal and dual solutions"
  homepage "https://projects.coin-or.org/Vol"
  url "https://www.coin-or.org/download/pkgsource/Vol/Vol-1.5.3.tgz"
  sha256 "3e895d858bb68831024f4c7c6a0fefbc03f89fe78fb6cfc69c4df5396d3e2a64"
  head "https://projects.coin-or.org/svn/Vol/trunk"

  depends_on "coin_data_sample"
  depends_on "coin-or-tools/coinor/osi" => :recommended

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/vol",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-dot"]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
