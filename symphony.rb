class Symphony < Formula
  desc "Framework for solving mixed integer linear programs"
  homepage "https://projects.coin-or.org/SYMPHONY"
  url "http://www.coin-or.org/download/pkgsource/SYMPHONY/SYMPHONY-5.6.14.tgz"
  sha256 "666d1c72c4bb084b470c4f066b1694f7b3b11a479de15d9d1e9bfe1b53e3ae63"
  head "https://projects.coin-or.org/svn/SYMPHONY/trunk"

  option "without-openmp", "Disable openmp support"
  option "with-asl", "Build CLP with ASL support"
  option "with-glpk", "Build with support for reading AMPL/GMPL models"
  option "with-mumps", "Build CLP with MUMPS support"
  option "with-openblas", "Build CLP with OpenBLAS support"
  option "with-suite-sparse", "Build CLP with SuiteSparse support"

  asl_dep = (build.with? "asl") ? ["with-asl"] : []
  glpk_dep = (build.with? "glpk") ? ["with-glpk"] : []
  mumps_dep = (build.with? "mumps") ? ["with-mumps"] : []
  openblas_dep = (build.with? "openblas") ? ["with-openblas"] : []
  suitesparse_dep = (build.with? "suite-sparse") ? ["with-suite-sparse"] : []

  depends_on "homebrew/science/openblas" => :optional
  depends_on "homebrew/science/glpk448" if build.with? "glpk"
  depends_on "homebrew/science/asl" => :optional
  depends_on "homebrew/science/mumps" => [:optional, "without-mpi"] + openblas_dep
  depends_on "homebrew/science/suite-sparse" => [:optional] + openblas_dep
  depends_on "readline" => :recommended
  depends_on "clp" => (asl_dep + glpk_dep + mumps_dep + openblas_dep + suitesparse_dep)
  depends_on "cgl"
  depends_on :fortran

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/cbc",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot",
            "--enable-gnu-packages",
            "--with-application",
            ]

    if build.with? "readline"
      ENV.append "CXXFLAGS", "-I#{Formula["readline"].opt_include}"
      ENV.append "LDFLAGS",  "-L#{Formula["readline"].opt_lib} -lreadline"
    end

    if build.with? "glpk"
      args << "--with-glpk-lib=-L#{Formula["glpk448"].opt_lib} -lglpk"
      args << "--with-glpk-incdir=#{Formula["glpk448"].opt_include}"
      ENV.append "CPPFLAGS", "-I#{Formula["mysql"].opt_include}/mysql"
      args << "--with-gmpl"
    end

    args << "--disable-openmp" if build.without? "openmp"

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"

    (pkgshare / "Datasets").install "Datasets/sample.mps"
    (pkgshare / "Datasets").install "Datasets/sample.mod", "Datasets/sample.dat" if build.with? "gmpl"

  end

  test do
    system "#{bin}/symphony", "-F", "#{pkgshare}/Datasets/sample.mps"
    system "#{bin}/symphony", "-F", "#{pkgshare}/Datasets/sample.mod", "-D", "#{pkgshare}/Datasets/sample.dat" if build.with? "gmpl"
  end
end
