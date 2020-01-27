class Osi < Formula
  desc "Abstract class to generic LP solver, derived classes for specific solvers"
  homepage "https://projects.coin-or.org/Osi/"
  url "https://www.coin-or.org/download/pkgsource/Osi/Osi-0.108.5.tgz"
  sha256 "b3b842c9c3c1fa4a869a7cc87b8295185fa517c5a2dcb096372526458dc745f9"
  head "https://projects.coin-or.org/svn/Osi/trunk"

  option "with-glpk", "Build with interface to GLPK and support for reading AMPL/GMPL models"

  glpk_dep = (build.with? "glpk") ? ["with-glpk"] : []
  openblas_dep = (build.with? "openblas") ? ["with-openblas"] : []

  depends_on "openblas" => :optional
  depends_on "glpk448" if build.with? "glpk"

  depends_on "coin-or-tools/coinor/coinutils" => (glpk_dep + openblas_dep)
  depends_on "pkg-config" => :build

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/osi",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"]

    if build.with? "glpk"
      args << "--with-glpk-lib=-L#{Formula["glpk448"].opt_lib} -lglpk"
      args << "--with-glpk-incdir=#{Formula["glpk448"].opt_include}"
    end

    system "./configure", *args

    ENV.deparallelize # make fails in parallel.
    system "make"
    system "make", "test"
    system "make", "install"
  end
end
