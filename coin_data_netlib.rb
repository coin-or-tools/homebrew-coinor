class CoinDataNetlib < Formula
  desc "Netlib LP models"
  homepage "https://github.com/coin-or-tools/Data-Netlib"
  url "https://github.com/coin-or-tools/Data-Netlib/archive/refs/tags/releases/1.2.11.tar.gz"
  sha256 "68876fbd33f0f99d4ccf1f02fe203947fe758a42eac5d5e795e2fca051735791"

  head "https://github.com/coin-or-tools/Data-Netlib.git"

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/coin_data_netlib-1.2.11"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c5041a0d6622bc6a97b2033f9b76666635535b290612345e208b0a422a72ba0d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c6cfa10fd81ff01d6e23ce7a17bc1f4cbc2aa0862241bcfb0839315ad0a3542a"
    sha256 cellar: :any_skip_relocation, sequoia:      "a9b06e73e7b53164286d16eecdbf37b3082e48fc698af0cf5310523a6f1b99ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "983f4faf3a6c30c7a635c0e0666401b21d84bda1d52bbc19c10cf211f8e63a9a"
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
