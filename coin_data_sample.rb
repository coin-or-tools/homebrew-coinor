require 'formula'

class CoinDataSample < Formula
  homepage 'http://www.coin-or.org/download/pkgsource/Data'
  url 'http://www.coin-or.org/download/pkgsource/Data/Sample-1.1.0.tgz'
  sha1 'd1a029025dec178b99ed8b592742a7cade3c72d8'

  def install
    system './configure', '--disable-debug',
                          '--disable-dependency-tracking',
                          '--disable-silent-rules',
                          "--prefix=#{prefix}"
    system 'make', 'install'
  end
end
