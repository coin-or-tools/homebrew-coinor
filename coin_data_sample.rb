class CoinDataSample < Formula
  desc "Sample models"
  homepage "https://github.com/coin-or-tools/Data-Sample"
  url "https://github.com/coin-or-tools/Data-Sample/archive/refs/tags/releases/1.2.13.tar.gz"
  sha256 "cb4c3713b2a2510d0b6387c24a68c88ba5eff27e2c392429653b1bdef50f06c9"

  head "https://github.com/coin-or-tools/Data-Sample.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_sample-1.2.13"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e64d636fac75b6e38ce9a9df5421d42a665e12efdcabc98665ef59dbd1ed5af3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "f55aae183e32b010721db4dd7b1a527666a62648d0e75e92039553d1d59afb99"
    sha256 cellar: :any_skip_relocation, sequoia:      "409b329530f382767efa1982ba71e3b03b30efca6a79d59f7e0a273088530ec4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7a62928fa2833b091a70f1dbf80e09a7f744bd25a8d0c2e4a0621a3b95e470ee"
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
