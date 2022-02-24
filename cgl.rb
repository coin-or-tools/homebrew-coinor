class Cgl < Formula
  desc "Cut-generation library"
  homepage "https://github.com/coin-or/Cgl"
  url "https://github.com/coin-or/Cgl/archive/refs/tags/releases/0.60.5.tar.gz"
  sha256 "5a2e7ca380425b3d7279d0759c625a367d06ec8293698b59f82fae38ae5df64e"

  head "https://github.com/coin-or/Cgl.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/cgl-0.60.4_1"
    sha256 cellar: :any,                 big_sur:      "8326f9a549ec9d72fd13338189b226aa70f24dcaf3294de8df2781b384be56b2"
    sha256 cellar: :any,                 catalina:     "edee468661b542a3ef14cb341a4efd56d3594464abaf44fd2c8d1104a7f4ef21"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "231b3e013594077ae22c6249f70caeec57a4a1bd5aed9f79d469ae5c851ae367"
  end

  keg_only "conflicts with formula in core"

  depends_on "pkg-config" => :build

  depends_on "coin-or-tools/coinor/clp"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/cgl",
            "--with-sample-datadir=#{Formula["coin-or-tools/coinor/coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-clp-lib=-L#{Formula["coin-or-tools/coinor/clp"].opt_lib} -lClp",
            "--with-clp-incdir=#{Formula["coin-or-tools/coinor/clp"].opt_include}/clp/coin",
            "--with-dot",
            "--without-osidylp",
            "--without-osivol"]
           ]

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
