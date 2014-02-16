require 'formula'

class CoinDataNetlib < Formula
  homepage 'http://www.coin-or.org/download/pkgsource/Data'
  url 'http://www.coin-or.org/download/source/Data/Netlib-1.2.6.tgz'
  sha1 'e3cdeae6418dde4464fcbd557af07b4c00c24dc5'

  def install
    system './configure', '--disable-debug',
                          '--disable-dependency-tracking',
                          '--disable-silent-rules',
                          "--prefix=#{prefix}"
    system 'make', 'install'
  end
end
