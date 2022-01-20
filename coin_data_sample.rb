class CoinDataSample < Formula
  desc "Sample models"
  homepage "https://github.com/coin-or-tools/Data-Sample"
  url "https://github.com/coin-or-tools/Data-Sample/archive/refs/tags/releases/1.2.12.tar.gz"
  sha256 "e9e67c04adfbd85523890b346326b106075df615e922c229277e138dbcb77e64"

  head "https://github.com/coin-or-tools/Data-Sample.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_sample-1.2.11_1"
    sha256 cellar: :any_skip_relocation, big_sur:      "cfa1b657c1df3a7767987455b353f22ffe1ac38f42901cb7c33afb2c0525c281"
    sha256 cellar: :any_skip_relocation, catalina:     "a4292a0a2011478ef75e575cb0ea587c0af3327b1e36b01d5fe3a1b298c3638a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3efa8d13b5630f9ad14b38b9caef27f30ab59502921c57941a47876d54e098a0"
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
