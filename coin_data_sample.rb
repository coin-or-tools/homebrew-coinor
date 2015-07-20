class CoinDataSample < Formula
  desc "Sample models"
  homepage "http://www.coin-or.org/download/pkgsource/Data"
  url "http://www.coin-or.org/download/pkgsource/Data/Sample-1.2.10.tgz"
  sha256 "ff80d1b9d28b87adf2e4b5e9897ff85a95a5b66eabd08cca8add871b2f6079b5"

  def install
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}"
    system "make", "install"
  end
end
