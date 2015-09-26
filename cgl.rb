class Cgl < Formula
  desc "Cut-generation library"
  homepage "https://projects.coin-or.org/Cgl"
  url "http://www.coin-or.org/download/pkgsource/Cgl/Cgl-0.59.6.tgz"
  sha256 "7714a42526a98319bfa331d3d6a73a73c277abf23c3c59c25b602965b9d66d4c"
  head "https://projects.coin-or.org/svn/Cgl/trunk"

  depends_on "clp"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/cgl",
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
