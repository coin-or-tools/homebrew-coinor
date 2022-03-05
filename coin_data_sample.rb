class CoinDataSample < Formula
  desc "Sample models"
  homepage "https://github.com/coin-or-tools/Data-Sample"
  url "https://github.com/coin-or-tools/Data-Sample/archive/refs/tags/releases/1.2.12.tar.gz"
  sha256 "e9e67c04adfbd85523890b346326b106075df615e922c229277e138dbcb77e64"

  head "https://github.com/coin-or-tools/Data-Sample.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_sample-1.2.12"
    sha256 cellar: :any_skip_relocation, big_sur:      "26c9b55072710e84714f0af050cec53e863f3b8cfed67ed2233b2630c8998fab"
    sha256 cellar: :any_skip_relocation, catalina:     "eef9ed62cea280a7ae01ad6439f262e06295223239d040a5e3a99f453f9b51a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bdda762446f81a97fd5cac3b48d234cfbaddc510560ea784335ef0d626fe1b73"
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
