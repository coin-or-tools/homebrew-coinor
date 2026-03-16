class CoinDataMiplib3 < Formula
  desc "MIPLib models"
  homepage "https://github.com/coin-or-tools/Data-miplib3"
  url "https://github.com/coin-or-tools/Data-miplib3/archive/refs/tags/releases/1.2.9.tar.gz"
  sha256 "4e4aa82d70989b115542c8394384e5e43a16db0550df472fed8fb0d67111e5ec"

  head "https://github.com/coin-or-tools/Data-miplib3.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_miplib3-1.2.9"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "bd9a8bfba1497fd370c840fd5fdf055ff591f89588188088b9cb2e33ca1ee768"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "8695217e1434c8c465e12e2ff6ba47ed2a398ae2d6c7b19da4c137e1f3521c85"
    sha256 cellar: :any_skip_relocation, sequoia:      "9387674df66a7ba6b116073a6c77a7e616906ed74d8f2d80b6a3b4f36db836fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1b7558af1d2d53b6a08ff387ad96b94ea7d7c4521e02458e920c9636d3316f7d"
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
