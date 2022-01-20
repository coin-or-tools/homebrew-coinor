class CoinDataStochastic < Formula
  desc "Stochastic models"
  homepage "https://github.com/coin-or-tools/Data-Stochastic"
  url "https://github.com/coin-or-tools/Data-Stochastic/archive/refs/tags/releases/1.1.7.tar.gz"
  sha256 "de65ca248c23dcdfc13d0212f903de034f48c9d7c22ee249ce65afc8372fd9cb"

  head "https://github.com/coin-or-tools/Data-Stochastic.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_stochastic-1.1.6_1"
    sha256 cellar: :any_skip_relocation, big_sur:      "7a101827ce0c37b954726e5fda9bf67a91d21b228898c96cb9e6b6e20b6c9f1a"
    sha256 cellar: :any_skip_relocation, catalina:     "f962c7f6d9b444c7b439086c7b10061cbf17168611777ed00c7ee4de9c026af3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ae3d227644cc7e2d9d497eb49ea349396d3280f6166fb65ddf0583e76e4ddccc"
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
