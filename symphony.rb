class Symphony < Formula
  desc "Framework for solving mixed integer linear programs"
  homepage "https://projects.coin-or.org/SYMPHONY"
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

  mumps_dep = (build.with? "mumps") ? ["with-mumps"] : []
  suite_sparse_dep = (build.with? "suite-sparse") ? ["with-suite-sparse"] : []

  depends_on "mysql" => :build if build.with? "gmpl"
  depends_on "readline" => :recommended

  depends_on "clp" => (asl_dep + openblas_dep + mumps_dep + suite_sparse_dep)
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

    if build.with? "gmpl"
      # Symphony uses a patched version of GLPK for reading MPL files.
      # Use a private version rather than require the Homebrew version of GLPK.
      cd "ThirdParty/Glpk" do
        system "./get.Glpk"
      end
      ENV.append "CPPFLAGS", "-I#{Formula["mysql"].opt_include}/mysql"
      args << "--with-gmpl"
    end

    if build.without? "openmp"
      args << "--disable-openmp"
    end

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"

    (share / "symphony/Datasets").install "Datasets/sample.mps"
    (share / "symphony/Datasets").install "Datasets/sample.mod", "Datasets/sample.dat" if build.with? "gmpl"

  end

  test do
    system "#{bin}/symphony", "-F", "#{share}/symphony/Datasets/sample.mps"
    system "#{bin}/symphony", "-F", "#{share}/symphony/Datasets/sample.mod", "-D", "#{share}/symphony/Datasets/sample.dat" if build.with? "gmpl"
  end
end
