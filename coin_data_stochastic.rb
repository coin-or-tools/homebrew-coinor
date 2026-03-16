class CoinDataStochastic < Formula
  desc "Stochastic models"
  homepage "https://github.com/coin-or-tools/Data-Stochastic"
  url "https://github.com/coin-or-tools/Data-Stochastic/archive/refs/tags/releases/1.1.7.tar.gz"
  sha256 "de65ca248c23dcdfc13d0212f903de034f48c9d7c22ee249ce65afc8372fd9cb"
  revision 1

  head "https://github.com/coin-or-tools/Data-Stochastic.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_stochastic-1.1.7_1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "44a8072fd02d0bbed8b995bf0fc1ab053c970d593048892e15759b6711a807e4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "aa3224e3cbd12cb616781cebf8bc5bd9d2f3c0d37ce6a4194018c059b26ac44d"
    sha256 cellar: :any_skip_relocation, sequoia:      "3ba3c0b6dc89f91383f400fc922d98ab0c1dfd56194d9dececf9a2a9831d38bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "af8217e8cb24048608b032db2d7e62f8e55010f7bd3768e8dd96fc5a75de8409"
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
