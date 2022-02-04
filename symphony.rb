class Symphony < Formula
  desc "Framework for solving mixed integer linear programs"
  homepage "https://github.com/coin-or/SYMPHONY"
  url "https://github.com/coin-or/SYMPHONY/archive/refs/tags/releases/5.6.18.tar.gz"
  sha256 "f566e2986c6b4269a5a128cea13622d3d90b046b7a9151ebd89f27c495f183a0"
  revision 1

  head "https://github.com/coin-or/SYMPHONY"

  depends_on "pkg-config" => :build

  depends_on "coin-or-tools/coinor/cgl"
  depends_on "coin-or-tools/coinor/clp"
  depends_on "coin-or-tools/coinor/dylp"
  depends_on "coin-or-tools/coinor/glpk@448"
  depends_on "gcc"
  depends_on "readline"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/symphony",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot",
            "--enable-gnu-packages",
            "--with-application"]

    ENV.append "CXXFLAGS", "-I#{Formula["readline"].opt_include}"
    ENV.append "LDFLAGS",  "-L#{Formula["readline"].opt_lib} -lreadline"

    args << "--with-cgl-lib=-L#{Formula["coin-or-tools/coinor/cgl"].opt_lib} -lCgl"
    args << "--with-cgl-incdir=#{Formula["coin-or-tools/coinor/cgl"].opt_include}/cgl/coin"

    args << "--with-clp-lib=-L#{Formula["coin-or-tools/coinor/clp"].opt_lib} -lClp -lOsiClp"
    args << "--with-clp-incdir=#{Formula["coin-or-tools/coinor/clp"].opt_include}/clp/coin"

    args << "--with-dylp-lib=-L#{Formula["coin-or-tools/coinor/dylp"].opt_lib} -lDylp"
    args << "--with-dylp-incdir=#{Formula["coin-or-tools/coinor/dylp"].opt_include}/dylp/coin"

    args << "--with-glpk-lib=-L#{Formula["coin-or-tools/coinor/glpk@448"].opt_lib} -lglpk"
    args << "--with-glpk-incdir=#{Formula["coin-or-tools/coinor/glpk@448"].opt_include}"
    args << "--with-gmpl"

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"

    # (pkgshare / "Datasets").install "Datasets/sample.mps"
    # (pkgshare / "Datasets").install "Datasets/sample.mod", "Datasets/sample.dat"
  end

  test do
    system "#{bin}/symphony",
           "-F",
           "#{Formula["coin-or-tools/coinor/coin_data_sample"].pkgshare}/coin/Data/Sample/exmip1.mps"
  end
end
