class CoinDataNetlib < Formula
  desc "Netlib LP models"
  homepage "https://github.com/coin-or-tools/Data-Netlib"
  url "https://github.com/coin-or-tools/Data-Netlib/archive/refs/tags/releases/1.2.10.tar.gz"
  sha256 "a1526411fe0bd9e83e1f9df5b68f17f45e7138b0327c7786d3cc2b578a738074"

  head "https://github.com/coin-or-tools/Data-Netlib.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_netlib-1.2.8_1"
    sha256 cellar: :any_skip_relocation, big_sur:      "7fe63490b380635e680de82598e56f63465fd0c47bea4c1abdb93db668866536"
    sha256 cellar: :any_skip_relocation, catalina:     "16264e1a6a85982fbae92e1f6b3bca835a7a3aafce8f0843fd6fba2c7624a2eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dc714199e7346b1e7623b8ce3f85e1b72a4db5bb079ae670ed3e0d38e6aac5fb"
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
