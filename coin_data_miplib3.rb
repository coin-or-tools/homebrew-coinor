class CoinDataMiplib3 < Formula
  desc "MIPLib models"
  homepage "https://github.com/coin-or-tools/Data-miplib3"
  url "https://github.com/coin-or-tools/Data-miplib3/archive/refs/tags/releases/1.2.8.tar.gz"
  sha256 "f7899e59bff4c597d91a24c7462d473358cd37b2877dc040eccd390b56933f9c"

  head "https://github.com/coin-or-tools/Data-miplib3.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_miplib3-1.2.7_1"
    sha256 cellar: :any_skip_relocation, big_sur:      "9685f3412bfbae39080ad00804b1167e5ba5154059145604ff13d7a4fa41bc22"
    sha256 cellar: :any_skip_relocation, catalina:     "f238365016b7ce5de35f985461c060c9fd631b1b1d97f59c10e3da57f5b82237"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cd8931f9109c8ebcd0cba2e790f123cfe06679c26cd6138072682379803a5021"
  end

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
