class Vol < Formula
  desc "Subgradient method that produces primal and dual solutions"
  homepage "https://github.com/coin-or/Vol" 
  url "https://github.com/coin-or/Vol/archive/releases/1.5.4.tar.gz"
  sha256 "5057fdd9f1a685b44e728ea9d6e501819ab357281569b7628790afd9db44ec3d"
  head "https://github.com/coin-or/Vol/tree/releases/1.5.4/Vol"

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
