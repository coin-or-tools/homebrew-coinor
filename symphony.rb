class Symphony < Formula
  desc "Framework for solving mixed integer linear programs"
  homepage "https://projects.coin-or.org/SYMPHONY"
  url "http://www.coin-or.org/download/pkgsource/SYMPHONY/SYMPHONY-5.6.13.tgz"
  sha256 "62353422dae24c24fe02b41ba9ffeecbcda2940b68cf477c2867df0aebaa6812"
  head "https://projects.coin-or.org/svn/SYMPHONY/trunk"

  depends_on "homebrew/science/asl" => :optional
  depends_on "homebrew/science/glpk" => :optional
  depends_on "homebrew/science/openblas" => :optional

  asl_dep = (build.with? "asl") ? ["with-asl"] : []
  glpk_dep = (build.with? "glpk") ? ["with-glpk"] : []
  openblas_dep = (build.with? "openblas") ? ["with-openblas"] : []

  depends_on "homebrew/science/mumps" => [:optional, "without-mpi"] + openblas_dep
  depends_on "homebrew/science/suite-sparse" => [:optional] + openblas_dep

  mumps_dep = (build.with? "mumps") ? ["with-openblas"] : []
  suite_sparse_dep = (build.with? "suite-sparse") ? ["with-openblas"] : []

  depends_on "clp" => (asl_dep + glpk_dep + openblas_dep + mumps_dep + suite_sparse_dep)
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
           ]

    if build.with? "glpk"
      args << "--with-glpk-lib=-L#{Formula["glpk"].opt_lib} -lglpk"
      args << "--with-glpk-incdir=#{Formula["glpk"].opt_include}"
    end

    system "./configure", *args

    system "make"
    system "make", "test"
    ENV.deparallelize # make install fails in parallel.
    system "make", "install"
  end
end
