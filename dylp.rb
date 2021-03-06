class Dylp < Formula
  desc "Dynamic simplex algorithm for linear programming"
  homepage "https://github.com/coin-or/DyLP/"
  url "https://github.com/coin-or/DyLP/archive/releases/1.10.4.tar.gz"
  sha256 "46f32047085852c8db73ef188c6357c926479a0da554c19e33fe3ed75d0b01c9"
  head "https://github.com/coin-or/DyLP/tree/releases/1.10.4/DyLP"

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
