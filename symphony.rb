class Symphony < Formula
  desc "Framework for solving mixed integer linear programs"
  homepage "https://github.com/coin-or/SYMPHONY"
  url "https://github.com/coin-or/SYMPHONY/archive/refs/tags/releases/5.7.2.tar.gz"
  sha256 "0807187a907027590fb860454b20cfde29dd61a2ce21b8af6be2ece4327955da"

  head "https://github.com/coin-or/SYMPHONY"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/symphony-5.7.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fa6c70528fb7e19fdcd7dc1696079348dbe7497bfb1b78894305f4c11940b6cd"
  end

  depends_on "pkg-config" => :build

  depends_on "coin-or-tools/coinor/cgl"
  depends_on "coin-or-tools/coinor/clp"
  depends_on "coin-or-tools/coinor/coinutils"
  depends_on "coin-or-tools/coinor/glpk@448"
  depends_on "coin-or-tools/coinor/osi"
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
