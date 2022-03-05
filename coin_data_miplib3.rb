class CoinDataMiplib3 < Formula
  desc "MIPLib models"
  homepage "https://github.com/coin-or-tools/Data-miplib3"
  url "https://github.com/coin-or-tools/Data-miplib3/archive/refs/tags/releases/1.2.8.tar.gz"
  sha256 "f7899e59bff4c597d91a24c7462d473358cd37b2877dc040eccd390b56933f9c"

  head "https://github.com/coin-or-tools/Data-miplib3.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_miplib3-1.2.8"
    sha256 cellar: :any_skip_relocation, big_sur:      "2337fe36aecab70eea7aec8086e75eeb81cf370fb1e15a1cb21f5d5b7249af87"
    sha256 cellar: :any_skip_relocation, catalina:     "38296f717b1801f8b6f55c7fd293d19827da43ea8b3f72c0b59c1ee1da2d1d85"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ae6de0753909ad9f4e11cad5665f7b2a87cb1c32f9151a3fc4872e317f65fc5f"
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
