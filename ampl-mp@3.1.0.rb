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

  resource "miniampl" do
    url "https://github.com/dpo/miniampl/archive/refs/tags/v1.0.tar.gz"
    sha256 "b836dbf1208426f4bd93d6d79d632c6f5619054279ac33453825e036a915c675"
  end

  # Removes Google Benchmark - as already done so upstream
  # All it did was conflict with the google-benchmark formula
  patch do
    url "https://github.com/ampl/mp/commit/96e332bb8cb7ba925e3ac947d6df515496027eed.patch?full_index=1"
    sha256 "1a4ef4cd1f4e8b959c20518f8f00994ef577e74e05824b2d1b241b1c3c1f84eb"
  end

  # Install missing header files, remove in > 3.1.0
  # https://github.com/ampl/mp/issues/110
  patch do
    url "https://github.com/ampl/mp/commit/8183be3e486d38d281e0c5a02a1ea4239695035e.patch?full_index=1"
    sha256 "6b37201f1d0d6dba591e7e1b81fb16d2694d118605c92c422dcdaaedb463c367"
  end
  # Backport fmt header update. Remove in the next release
  # https://github.com/ampl/mp/issues/108

  patch do
    url "https://github.com/ampl/mp/commit/1f39801af085656e4bf72250356a3a70d5d98e73.patch?full_index=1"
    sha256 "b0e0185f24caba54cb38b65a638ebda6eb4db3e8c74d71ca79f072b8337e8e2c"
  end

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
    resource("miniampl").stage do
      testpath.install "src/miniampl.c", Dir["examples/wb.*"]
    end
    system ENV.cc, "miniampl.c", "-std=c99", "-I#{include}/asl", "-L#{lib}", "-lasl", "-lmp"
    output = shell_output("./a.out wb showname=1 showgrad=1")
    assert_match "Objective name: objective", output
  end
end

