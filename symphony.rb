class Symphony < Formula
  desc "Framework for solving mixed integer linear programs"
  homepage "https://projects.coin-or.org/SYMPHONY"
<<<<<<< HEAD
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
=======
  url "http://www.coin-or.org/download/pkgsource/SYMPHONY/SYMPHONY-5.6.13.tgz"
  sha256 "62353422dae24c24fe02b41ba9ffeecbcda2940b68cf477c2867df0aebaa6812"
  head "https://projects.coin-or.org/svn/SYMPHONY/trunk"

  depends_on "homebrew/science/asl" => :optional
  depends_on "homebrew/science/glpk" => :optional
  depends_on "homebrew/science/openblas" => :optional

  option "without-openmp", "Disable openmp support"

  asl_dep = (build.with? "asl") ? ["with-asl"] : []
  openblas_dep = (build.with? "openblas") ? ["with-openblas"] : []
  option "with-gmpl", "GNU Modeling Language support via GLPK"

  depends_on "homebrew/science/mumps" => [:optional, "without-mpi"] + openblas_dep
  depends_on "homebrew/science/suite-sparse" => [:optional] + openblas_dep
>>>>>>> 73efb9d... Adding recipe for SYMPHONY

  mumps_dep = (build.with? "mumps") ? ["with-mumps"] : []
  suite_sparse_dep = (build.with? "suite-sparse") ? ["with-suite-sparse"] : []

  depends_on "mysql" => :build if build.with? "gmpl"
  depends_on "readline" => :recommended

<<<<<<< HEAD
  depends_on "clp" => (asl_dep + glpk_dep + mumps_dep + openblas_dep + suitesparse_dep)
=======
  depends_on "clp" => (asl_dep + openblas_dep + mumps_dep + suite_sparse_dep)
>>>>>>> 73efb9d... Adding recipe for SYMPHONY
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
<<<<<<< HEAD
            "--enable-gnu-packages",
            "--with-application",
=======
	    "--enable-gnu-packages",
	    "--with-application",
>>>>>>> 73efb9d... Adding recipe for SYMPHONY
           ]

    if build.with? "readline"
      ENV.append "CXXFLAGS", "-I#{Formula["readline"].opt_include}"
      ENV.append "LDFLAGS",  "-L#{Formula["readline"].opt_lib} -lreadline"
    end

<<<<<<< HEAD
    if build.with? "glpk"
      args << "--with-glpk-lib=-L#{Formula["glpk448"].opt_lib} -lglpk"
      args << "--with-glpk-incdir=#{Formula["glpk448"].opt_include}"
=======
    if build.with? "gmpl"
      # Symphony uses a patched version of GLPK for reading MPL files.
      # Use a private version rather than require the Homebrew version of GLPK.
      cd "ThirdParty/Glpk" do
        system "./get.Glpk"
      end
>>>>>>> 73efb9d... Adding recipe for SYMPHONY
      ENV.append "CPPFLAGS", "-I#{Formula["mysql"].opt_include}/mysql"
      args << "--with-gmpl"
    end

<<<<<<< HEAD
    args << "--disable-openmp" if build.without? "openmp"
=======
    if build.without? "openmp"
      args << "--disable-openmp"
    end
>>>>>>> 73efb9d... Adding recipe for SYMPHONY

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"

<<<<<<< HEAD
    (pkgshare / "Datasets").install "Datasets/sample.mps"
    (pkgshare / "Datasets").install "Datasets/sample.mod", "Datasets/sample.dat" if build.with? "gmpl"
=======
    (share / "symphony/Datasets").install "Datasets/sample.mps"
    (share / "symphony/Datasets").install "Datasets/sample.mod", "Datasets/sample.dat" if build.with? "gmpl"
>>>>>>> 73efb9d... Adding recipe for SYMPHONY

  end

  test do
    system "#{bin}/symphony", "-F", "#{share}/symphony/Datasets/sample.mps"
<<<<<<< HEAD
    system "#{bin}/symphony", "-F", "#{share}/symphony/Datasets/sample.mod", "-D", "#{pkgshare}/Datasets/sample.dat" if build.with? "gmpl"
=======
    system "#{bin}/symphony", "-F", "#{share}/symphony/Datasets/sample.mod", "-D", "#{share}/symphony/Datasets/sample.dat" if build.with? "gmpl"
>>>>>>> 73efb9d... Adding recipe for SYMPHONY
  end
end
