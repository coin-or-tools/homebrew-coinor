class Vol < Formula
  desc "Subgradient method that produces primal and dual solutions"
  homepage "https://projects.coin-or.org/Vol"
  url "https://www.coin-or.org/download/pkgsource/Vol/Vol-1.5.4.tgz"
  sha256 "6cd53e2f4ad0aa68348901bf12fe146335812ee1d85bf272ae0c2bbd76faf1ae"
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
