class Dylp < Formula
  desc "Dynamic simplex algorithm for linear programming"
  homepage "https://github.com/coin-or/DyLP/" # Updated homepage url reference to GitHub
  url "https://github.com/coin-or/DyLP/archive/releases/1.10.4.tar.gz" # Updated url reference to GitHub, version already up-to-date as of review
  sha256 "46f32047085852c8db73ef188c6357c926479a0da554c19e33fe3ed75d0b01c9" # Updated sha256 checksum to match GitHub version
  head "https://github.com/coin-or/DyLP/tree/releases/1.10.4/DyLP" # Updated url reference to GitHub, version already up-to-date as of review
  revision 1 # Added revision count

  depends_on "coin-or-tools/coinor/osi"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/dylp",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
