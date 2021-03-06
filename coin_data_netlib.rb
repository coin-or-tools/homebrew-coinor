class CoinDataNetlib < Formula
  desc "Netlib LP models"
  homepage "https://github.com/coin-or-tools/Data-Netlib"
  url "https://github.com/coin-or-tools/Data-Netlib/archive/releases/1.2.9.tar.gz"
  sha256 "cfc9f4ca02db25458cce66f2b9128daf623cb9204ef41e980fc42dedeb0f76d0"
  head "https://github.com/coin-or-tools/Data-Netlib/tree/releases/1.2.9"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}",
           "--datadir=#{pkgshare}"
    system "make", "install"
  end
end
