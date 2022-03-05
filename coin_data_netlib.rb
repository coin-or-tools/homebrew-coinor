class CoinDataNetlib < Formula
  desc "Netlib LP models"
  homepage "https://github.com/coin-or-tools/Data-Netlib"
  url "https://github.com/coin-or-tools/Data-Netlib/archive/refs/tags/releases/1.2.10.tar.gz"
  sha256 "a1526411fe0bd9e83e1f9df5b68f17f45e7138b0327c7786d3cc2b578a738074"

  head "https://github.com/coin-or-tools/Data-Netlib.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_netlib-1.2.10"
    sha256 cellar: :any_skip_relocation, big_sur:      "b8f35293ac1d06877600005ed5c37e91920874f33e12c81eca992db225e00492"
    sha256 cellar: :any_skip_relocation, catalina:     "a530cedcb669e3207eb2f0e7c04597c8ce8f3566f00afd9623a4cb463d078233"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "780c230901e4a707efa5d5fea7587686f5f63172809048a575f58b657917b1b2"
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
