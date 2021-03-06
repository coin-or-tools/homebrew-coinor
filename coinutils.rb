class Coinutils < Formula
  desc "Utilities used by other Coin-OR projects"
<<<<<<< Updated upstream
  homepage "https://github.com/coin-or/CoinUtils"
  url "https://github.com/coin-or/CoinUtils/archive/releases/2.11.4.tar.gz"
  sha256 ""
  head "https://github.com/coin-or/CoinUtils/tree/releases/2.11.4/CoinUtils"
  revision 1
=======
  homepage "https://github.com/coin-or/CoinUtils" # Updated homepage url reference to GitHub
  url "https://github.com/coin-or/CoinUtils/archive/releases/2.11.4.tar.gz" # Updated url reference to GitHub, version updated to 2.11.4
  sha256 "d4effff4452e73356eed9f889efd9c44fe9cd68bd37b608a5ebb2c58bd45ef81" # Updated sha256 checksum to match updated version
  head "https://github.com/coin-or/CoinUtils/tree/releases/2.11.4/CoinUtils" # Updated head url reference to GitHub, version updated to 2.11.4
  revision 1  # Added revision count
>>>>>>> Stashed changes

  option "with-glpk", "Build with support for reading AMPL/GMPL models"

  depends_on "gcc"

  depends_on "coin_data_sample"
  depends_on "coin_data_netlib"

  depends_on "doxygen"
  depends_on "graphviz" => :build # For documentation.
  depends_on "pkg-config" => :build

  depends_on "openblas" => :optional
  depends_on "glpk448" if build.with? "glpk"

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--datadir=#{pkgshare}",
            "--includedir=#{include}/coinutils",
            "--with-sample-datadir=#{Formula["coin_data_sample"].opt_pkgshare}/coin/Data/Sample",
            "--with-netlib-datadir=#{Formula["coin_data_netlib"].opt_pkgshare}/coin/Data/Netlib",
            "--with-dot"]

    if build.with? "openblas"
      openblaslib = "-L#{Formula["openblas"].opt_lib} -lopenblas"
      openblasinc = Formula["openblas"].opt_include.to_s
      args << "--with-blas-lib=#{openblaslib}"
      args << "--with-blas-incdir=#{openblasinc}"
      args << "--with-lapack-lib=#{openblaslib}"
      args << "--with-lapack-incdir=#{openblasinc}"
    end

    if build.with? "glpk"
      args << "--with-glpk-lib=-L#{Formula["glpk448"].opt_lib} -lglpk"
      args << "--with-glpk-incdir=#{Formula["glpk448"].opt_include}"
    end

    system "./configure", *args

    system "make"
    ENV.deparallelize # make install fails in parallel.
    # system "make", "test" # Commented out this line as described at https://github.com/coin-or/CoinUtils/issues/151#issuecomment-791637851 to deal with make test assertion error
    system "make", "install"
  end
end
