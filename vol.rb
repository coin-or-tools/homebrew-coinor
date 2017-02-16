class Vol < Formula
  desc "Subgradient method that produces primal and dual solutions"
  homepage "https://projects.coin-or.org/Vol"
  url "http://www.coin-or.org/download/pkgsource/Vol/Vol-1.5.2.tgz"
  sha256 "4b6f06159c58c79f1f40ad5bc5d4e069b4d0bbce3953f41f5c673493f2a09e54"
  head "https://projects.coin-or.org/svn/Vol/trunk"

  depends_on "coin_data_sample"
  depends_on "osi" => :recommended
  depends_on "pkg-config" => :build

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/vol",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-dot",
           ]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
