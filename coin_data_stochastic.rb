require 'formula'

class CoinDataStochastic < Formula
  homepage 'http://www.coin-or.org/download/pkgsource/Data'
  url 'http://www.coin-or.org/download/source/Data/Stochastic-1.1.5.tgz'
  sha1 'bf765b006df3338208a3b87d227609adf67a7ca3'

  def install
    system './configure', '--disable-debug',
                          '--disable-dependency-tracking',
                          '--disable-silent-rules',
                          "--prefix=#{prefix}"
    system 'make', 'install'
  end
end
