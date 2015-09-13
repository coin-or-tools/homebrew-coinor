class Osi < Formula
  desc "abstract class to a generic linear programming solver, and derived classes for specific solvers"
  homepage "https://projects.coin-or.org/Osi/"
  url "http://www.coin-or.org/download/pkgsource/Osi/Osi-0.107.5.tgz"
  sha256 "c578256853109e33a8ad8f1917ca8850a027d8a0987ef87166d34de1a256a57d"
  head "https://projects.coin-or.org/svn/Osi/trunk"

  depends_on "homebrew/science/glpk" => :optional
  depends_on "homebrew/science/openblas" => :optional

  glpk_dep = (build.with? "glpk") ? ["with-glpk"] : []
  openblas_dep = (build.with? "openblas") ? ["with-openblas"] : []

  depends_on "coinutils" => (glpk_dep + openblas_dep)

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/osi",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot",
           ]

    system "./configure", *args

    ENV.deparallelize # make fails in parallel.
    system "make"
    system "make", "test"
    system "make", "install"
  end
end
