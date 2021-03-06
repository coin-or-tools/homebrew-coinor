class Vol < Formula
  desc "Subgradient method that produces primal and dual solutions"
  homepage "https://github.com/coin-or/Vol" # Updated homepage url reference to GitHub
  url "https://github.com/coin-or/Vol/archive/releases/1.5.4.tar.gz" # Updated url reference to GitHub, version already up-to-date as of review
  sha256 "5057fdd9f1a685b44e728ea9d6e501819ab357281569b7628790afd9db44ec3d" # Updated sha256 checksum to match GitHub version
  head "https://github.com/coin-or/Vol/tree/releases/1.5.4/Vol" # Updated head url reference to GitHub, version already up-to-date as of review
  revision 1 # Added revision count

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
