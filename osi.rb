class Osi < Formula
  desc "Abstract class to generic LP solver, derived classes for specific solvers"
  homepage "https://github.com/coin-or/Osi" # Updated homepage url reference to GitHub
  url "https://github.com/coin-or/Osi/archive/releases/0.108.6.tar.gz" # Updated url reference to GitHub, version updated to 0.108.6
  sha256 "984a5886825e2da9bf44d8a665f4b92812f0700e451c12baf9883eaa2315fad5" # Updated sha256 checksum to match updated version
  head "https://github.com/coin-or/Osi/tree/releases/0.108.6/Osi" # Updated head url reference to GitHub, version updated to 0.108.6
  revision 1 # Added revision count

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
