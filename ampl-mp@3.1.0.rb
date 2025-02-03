class AmplMpAT310 < Formula
  desc "Open-source library for mathematical programming"
  homepage "https://ampl.com/"
  url "https://github.com/ampl/mp/archive/refs/tags/3.1.0.tar.gz"
  sha256 "587c1a88f4c8f57bef95b58a8586956145417c8039f59b1758365ccc5a309ae9"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => :build
  depends_on "gcc@9"

  patch :DATA
  
  def install
    args = %W[
      -DAMPL_LIBRARY_DIR=#{libexec}/bin
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_TESTS=OFF
      -DCMAKE_INSTALL_RPATH=#{rpath};#{rpath(source: libexec/"bin")}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <stdlib.h>
      #include "mp/ampls-c-api.h"

      int main() {
          AMPLS_MP_Solver* solver = (AMPLS_MP_Solver*)malloc(sizeof(AMPLS_MP_Solver));
          free(solver);
          return 0;
      }
    C
    
    system ENV.cc, "test.c", "-I#{include}/mp", "-L#{lib}", "-lmp", "-o", "test"
    system "./test"
  end
end

__END__
--- a/include/mp/format.h
+++ b/include/mp/format.h
@@ -1747,21 +1747,21 @@
     typedef typename BasicWriter<Char>::CharPtr CharPtr;
     Char fill = internal::CharTraits<Char>::cast(spec_.fill());
     CharPtr out = CharPtr();
-    const unsigned CHAR_WIDTH = 1;
-    if (spec_.width_ > CHAR_WIDTH) {
+    const unsigned C_WIDTH = 1;
+    if (spec_.width_ > C_WIDTH) {
       out = writer_.grow_buffer(spec_.width_);
       if (spec_.align_ == ALIGN_RIGHT) {
-        std::uninitialized_fill_n(out, spec_.width_ - CHAR_WIDTH, fill);
-        out += spec_.width_ - CHAR_WIDTH;
+        std::uninitialized_fill_n(out, spec_.width_ - C_WIDTH, fill);
+        out += spec_.width_ - C_WIDTH;
       } else if (spec_.align_ == ALIGN_CENTER) {
         out = writer_.fill_padding(out, spec_.width_,
-                                   internal::check(CHAR_WIDTH), fill);
+                                   internal::check(C_WIDTH), fill);
       } else {
-        std::uninitialized_fill_n(out + CHAR_WIDTH,
-                                  spec_.width_ - CHAR_WIDTH, fill);
+        std::uninitialized_fill_n(out + C_WIDTH,
+                                  spec_.width_ - C_WIDTH, fill);
       }
     } else {
-      out = writer_.grow_buffer(CHAR_WIDTH);
+      out = writer_.grow_buffer(C_WIDTH);
     }
     *out = internal::CharTraits<Char>::cast(value);
   }
