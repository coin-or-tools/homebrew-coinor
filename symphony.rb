class Symphony < Formula
  desc "Framework for solving mixed integer linear programs"
  homepage "https://github.com/coin-or/SYMPHONY" # Updated homepage url reference to GitHub
  url "https://github.com/coin-or/SYMPHONY/archive/releases/5.6.17.tar.gz" # Updated url reference to GitHub, version already up-to-date as of review
  sha256 "9631c11f4b4b631b4b9e74f0438af44c152d82043568b0b906c95705700b654d" # Updated sha256 checksum to match GitHub version
  head "https://github.com/coin-or/SYMPHONY/tree/releases/5.6.17/SYMPHONY" # Updated head url reference to GitHub, version already up-to-date as of review
  revision 1 # Added revision count

  option "without-openmp", "Disable openmp support"
  option "with-ampl-mp", "Build CLP with ASL support"
  option "with-glpk", "Build with support for reading AMPL/GMPL models"
  option "with-mumps", "Build CLP with MUMPS support"
  option "with-openblas", "Build CLP with OpenBLAS support"
  option "with-suite-sparse", "Build CLP with SuiteSparse support"

  asl_dep = build.with?("ampl-mp") ? ["with-ampl-mp"] : []
  glpk_dep = build.with?("glpk") ? ["with-glpk"] : []
  mumps_dep = build.with?("mumps") ? ["with-mumps"] : []
  openblas_dep = build.with?("openblas") ? ["with-openblas"] : []
  suitesparse_dep = build.with?("suite-sparse") ? ["with-suite-sparse"] : []

  depends_on "gcc"
  depends_on "glpk448" if build.with? "glpk"
  depends_on "pkg-config" => :build
  depends_on "readline" => :recommended

  depends_on "coin-or-tools/coinor/cgl"
  depends_on "coin-or-tools/coinor/clp" => (asl_dep + glpk_dep + mumps_dep + openblas_dep + suitesparse_dep)

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

    if build.with? "readline"
      ENV.append "CXXFLAGS", "-I#{Formula["readline"].opt_include}"
      ENV.append "LDFLAGS",  "-L#{Formula["readline"].opt_lib} -lreadline"
    end

    if build.with? "glpk"
      args << "--with-glpk-lib=-L#{Formula["glpk448"].opt_lib} -lglpk"
      args << "--with-glpk-incdir=#{Formula["glpk448"].opt_include}"
      args << "--with-gmpl"
    end

    args << "--disable-openmp" if build.without? "openmp"

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"

    (pkgshare / "Datasets").install "Datasets/sample.mps"
    (pkgshare / "Datasets").install "Datasets/sample.mod", "Datasets/sample.dat" if build.with? "glpk"
  end

  test do
    system "#{bin}/symphony", "-F", "#{pkgshare}/Datasets/sample.mps"
    system "#{bin}/symphony", "-F", "#{pkgshare}/Datasets/sample.mod", "-D", "#{pkgshare}/Datasets/sample.dat" if build.with? "gmpl"
  end
end
