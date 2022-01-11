class Osi < Formula
  desc "Abstract class to generic LP solver, derived classes for specific solvers"
  homepage "https://github.com/coin-or/Osi"
  url "https://github.com/coin-or/Osi/archive/refs/tags/releases/0.108.7.tar.gz"
  sha256 "f1bc53a498585f508d3f8d74792440a30a83c8bc934d0c8ecf8cd8bc0e486228"
  head "https://projects.coin-or.org/svn/Osi/trunk"

  option "with-glpk", "Build with interface to GLPK and support for reading AMPL/GMPL models"

  glpk_dep = build.with?("glpk") ? ["with-glpk"] : []
  openblas_dep = build.with?("openblas") ? ["with-openblas"] : []

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
