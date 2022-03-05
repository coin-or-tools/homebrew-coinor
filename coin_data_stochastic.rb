class CoinDataStochastic < Formula
  desc "Stochastic models"
  homepage "https://github.com/coin-or-tools/Data-Stochastic"
  url "https://github.com/coin-or-tools/Data-Stochastic/archive/refs/tags/releases/1.1.7.tar.gz"
  sha256 "de65ca248c23dcdfc13d0212f903de034f48c9d7c22ee249ce65afc8372fd9cb"

  head "https://github.com/coin-or-tools/Data-Stochastic.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_stochastic-1.1.7"
    sha256 cellar: :any_skip_relocation, big_sur:      "d93167bfb7bdc4cfa4b3ac45cf5b4332b46810cbe083d3541c1b772b5ca25c38"
    sha256 cellar: :any_skip_relocation, catalina:     "d0d1af97f5f8b6d71f2a766d899314cbe7362246863c66a45ad9f1fb78f8145d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bd75c5531f8f5c6b325a0ef9799adbc6868dd4f29251eedc5a8251c74ff47a39"
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
