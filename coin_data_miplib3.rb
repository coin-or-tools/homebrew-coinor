require 'formula'

class CoinDataMiplib3 < Formula
  homepage 'http://www.coin-or.org/download/pkgsource/Data'
  url 'http://www.coin-or.org/download/source/Data/miplib3-1.2.6.tgz'
  sha1 'b02d0832046e6d1d04fc87d93c430a33dae0a1bd'

  def install
    system './configure', '--disable-debug',
                          '--disable-dependency-tracking',
                          '--disable-silent-rules',
                          "--prefix=#{prefix}"
    system 'make', 'install'
  end
end
