class GlpkAT448 < Formula
  desc "Library for Linear Programming"
  homepage "https://www.gnu.org/software/glpk"
  url "https://ftpmirror.gnu.org/gnu/glpk/glpk-4.48.tar.gz"
  sha256 "abc2c8f895b20a91cdfcfc04367a0bc8677daf8b4ec3f3e86c5b71c79ac6adb1"
  revision 1

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/glpk@448-4.48_1"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:  "f48938dd76c736466cd5bb1cf7078ba80bd80f6a62c365cea831d8ebb47c72f8"
    sha256 cellar: :any,                 arm64_sonoma: "575d752cc19ebfb8f3f8bc6c125d1f7316f6a33ef21306aa05ffd78c3ef37545"
    sha256 cellar: :any,                 sequoia:      "2e0a9e0a6aca00be5534463122f89295294f1dc0b59e2c37875bd5a70b0f70fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "717470fbfb83eaf2f80d2373d23ebf934f1fc8e39f32a59ea56a99a3f1a5f5ab"
  end

  keg_only "this formula installs an older version of the GLPK libraries"

  depends_on "gmp"

  patch :DATA

  def install
    args = %W[--disable-dependency-tracking --prefix=#{prefix} --with-gmp]
    system "./configure", *args
    system "make"
    system "make", "check"
    system "make", "install"
    include.install "src/amd/amd.h"
    include.install "src/colamd/colamd.h"
  end

  test do
    (testpath/"test.c").write <<-EOF
    #include "stdio.h"
    #include "glpk.h"

    int main(int argc, const char *argv[])
    {
        printf("%s", glp_version());
        return 0;
    }
    EOF
    system ENV.cc, "-I#{include}", "test.c", "-L#{lib}", "-lglpk", "-o", "test"
    assert_equal `./test`, version.to_s
  end
end

__END__
diff --git a/src/Makefile.am b/src/Makefile.am
index cec1f74..9e20042 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -4,8 +4,7 @@ include_HEADERS = glpk.h

 lib_LTLIBRARIES = libglpk.la

-libglpk_la_LDFLAGS = -version-info 33:0:0 \
--export-symbols-regex '^(glp_|_glp_lpx_).*'
+libglpk_la_LDFLAGS = -version-info 33:0:0

 libglpk_la_SOURCES = \
 glpapi01.c \
diff --git a/src/Makefile.in b/src/Makefile.in
index 6e61555..4d112dc 100644
--- a/src/Makefile.in
+++ b/src/Makefile.in
@@ -264,8 +264,7 @@ top_builddir = @top_builddir@
 top_srcdir = @top_srcdir@
 include_HEADERS = glpk.h
 lib_LTLIBRARIES = libglpk.la
-libglpk_la_LDFLAGS = -version-info 33:0:0 \
--export-symbols-regex '^(glp_|_glp_lpx_).*'
+libglpk_la_LDFLAGS = -version-info 33:0:0

 libglpk_la_SOURCES = \
 glpapi01.c \
