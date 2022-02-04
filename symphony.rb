class Symphony < Formula
  desc "Framework for solving mixed integer linear programs"
  homepage "https://github.com/coin-or/SYMPHONY"
  url "https://github.com/coin-or/SYMPHONY/archive/refs/tags/releases/5.6.17.tar.gz"
  sha256 "f6c2b9c9e60ebff4a665e243e765649334c5d0680f536d3d9c0c372025ab96dc"
  revision 1

  head "https://github.com/coin-or/SYMPHONY"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/symphony-5.6.17_1"
    sha256 cellar: :any,                 big_sur:      "1abc5b95dd71c4f8adf52c2e3d4dd7fb0ca3ef603919682c2bc4057ecec43e4a"
    sha256 cellar: :any,                 catalina:     "b96391eb3099afa52d40d7edf30f72ba98857483a3c67f523c37f331ed6a7987"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7597c630fadef7c6ba99197d16f9a00d0c2f334cf04b757cc1f431e7e4977652"
  end

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
