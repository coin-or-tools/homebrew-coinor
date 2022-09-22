class MumpsSeq < Formula
  desc "Sequential Sparse Direct Solver"
  homepage "http://mumps-solver.org"
  url "https://graal.ens-lyon.fr/MUMPS/MUMPS_5.4.1.tar.gz"
  mirror "http://mumps.enseeiht.fr/MUMPS_5.4.1.tar.gz"
  sha256 "93034a1a9fe0876307136dcde7e98e9086e199de76f1c47da822e7d4de987fa8"
  revision 1

  bottle do
    root_url "https://github.com/coin-or-tools/homebrew-coinor/releases/download/mumps-seq-5.4.1"
    sha256 cellar: :any,                 big_sur:      "a1e71aad84f101766f17108c643b0d7757c92227a2da2f4d28cba3ffe1693a47"
    sha256 cellar: :any,                 catalina:     "c64fdabb2abc4e98c0a0cedb3ffc0104e116ba9ce978005d8e4a60a7fdc71691"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dbdeabc21c642e8e601db0398d6287e226d4f2784581295da963b3f31dfe1caa"
  end

  keg_only "conflicts with parallel builds of MUMPS"

  depends_on "gcc"
  depends_on "metis"
  depends_on "openblas" => :recommended

  fails_with :clang # because we use OpenMP

  def install
    # MUMPS >= 5.3.4 does not compile with gfortran10. Allow some errors to go through.
    # see https://listes.ens-lyon.fr/sympa/arc/mumps-users/2020-10/msg00002.html
    make_args = ["RANLIB=echo", "CDEFS=-DAdd_"]
    optf = ["OPTF=-O3"]
    gcc_major_ver = Formula["gcc"].any_installed_version.major
    optf << "-fallow-argument-mismatch" if gcc_major_ver >= 10
    make_args << optf.join(" ")

    makefile = "Makefile.G95.SEQ"
    cp "Make.inc/" + makefile, "Makefile.inc"

    lib_args = []

    metis_libs = ["-L#{Formula["metis"].opt_lib}", "-lmetis"]
    make_args += ["LMETISDIR=#{Formula["metis"].opt_lib}",
                  "IMETIS=-I#{Formula["metis"].opt_include}",
                  "LMETIS=#{metis_libs.join(" ")}"]
    lib_args += metis_libs

    orderingsf = "-Dpord"
    orderingsf << " -Dmetis"
    make_args << "ORDERINGSF=#{orderingsf}"

    make_args += ["CC=gcc -fPIC",
                  "FC=gfortran -fPIC",
                  "FL=gfortran -fPIC"]

    blas_lib = ["-L#{Formula["openblas"].opt_lib}", "-lopenblas"]
    make_args << "LIBBLAS=#{blas_lib.join(" ")}"
    make_args << "LAPACK=#{blas_lib.join(" ")}"
    lib_args += blas_lib

    ENV.deparallelize

    system "make", "all", *make_args

    # make shared lib
    so = OS.mac? ? "dylib" : "so"
    all_load = OS.mac? ? "-all_load" : "--whole-archive"
    noall_load = OS.mac? ? "-noall_load" : "--no-whole-archive"
    shopts = OS.mac? ? ["-undefined", "dynamic_lookup"] : []
    install_name = ->(libname) { OS.mac? ? ["-Wl,-install_name", "-Wl,#{lib}/#{libname}.#{so}"] : [] }
    cd "lib" do
      libpord_install_name = install_name.call("libpord")
      system "gfortran", "-fPIC", "-shared", "-Wl,#{all_load}", "libpord.a", *lib_args, \
             "-Wl,#{noall_load}", *libpord_install_name, *shopts, "-o", "libpord.#{so}"
      lib.install "libpord.#{so}"
      libmumps_common_install_name = install_name.call("libmumps_common")
      system "gfortran", "-fPIC", "-shared", "-Wl,#{all_load}", "libmumps_common.a", *lib_args, \
             "-L#{lib}", "-lpord", "-Wl,#{noall_load}", *libmumps_common_install_name, \
             *shopts, "-o", "libmumps_common.#{so}"
      lib.install "libmumps_common.#{so}"
      %w[libsmumps libdmumps libcmumps libzmumps].each do |l|
        libinstall_name = install_name.call(l)
        system "gfortran", "-fPIC", "-shared", "-Wl,#{all_load}", "#{l}.a", *lib_args, \
               "-L#{lib}", "-lpord", "-lmumps_common", "-Wl,#{noall_load}", *libinstall_name, \
               *shopts, "-o", "#{l}.#{so}"
        lib.install "#{l}.#{so}"
      end
    end
    cd "libseq" do
      libmpiseq_install_name = install_name.call("libmpiseq")
      system "gfortran", "-fPIC", "-shared", "-Wl,#{all_load}", "libmpiseq.a", *lib_args, \
             "-Wl,#{noall_load}", *libmpiseq_install_name, *shopts, "-o", "libmpiseq.#{so}"
      lib.install "libmpiseq.#{so}"
    end

    inreplace "examples/Makefile" do |s|
      s.change_make_var! "libdir", lib
    end

    libexec.install "include"
    (libexec/"include").install Dir["libseq/*.h"]
    include.install_symlink Dir[libexec/"include/*"]

    doc.install Dir["doc/*.pdf"]
    pkgshare.install "examples"

    prefix.install "Makefile.inc"  # For the record.
    File.open(prefix/"make_args.txt", "w") do |f|
      f.puts(make_args.join(" "))  # Record options passed to make.
    end
  end

  test do
    ENV.prepend_path "LD_LIBRARY_PATH", lib unless OS.mac?
    cp_r pkgshare/"examples", testpath
    opts = ["-fopenmp"]
    includes = "-I#{opt_include}"
    ENV.prepend_path "LD_LIBRARY_PATH", Formula["metis"].opt_lib unless OS.mac?
    opts << "-L#{Formula["metis"].opt_lib}" << "-lmetis"
    opts << "-lmumps_common" << "-lpord" << "-lmpiseq"
    opts << "-L#{Formula["openblas"].opt_lib}" << "-lopenblas"

    cd testpath/"examples" do
      system "gfortran", "-o", "ssimpletest", "ssimpletest.F", "-L#{opt_lib}", "-lsmumps", includes, *opts
      system "./ssimpletest < input_simpletest_real"
      system "gfortran", "-o", "dsimpletest", "dsimpletest.F", "-L#{opt_lib}", "-ldmumps", includes, *opts
      system "./dsimpletest < input_simpletest_real"
      system "gfortran", "-o", "csimpletest", "csimpletest.F", "-L#{opt_lib}", "-lcmumps", includes, *opts
      system "./csimpletest < input_simpletest_cmplx"
      system "gfortran", "-o", "zsimpletest", "zsimpletest.F", "-L#{opt_lib}", "-lzmumps", includes, *opts
      system "./zsimpletest < input_simpletest_cmplx"
      if OS.mac?
        # fails on linux: gcc-5 not found
        system ENV.cc, "-c", "c_example.c", includes
        system "gfortran", "-o", "c_example", "c_example.o", "-L#{opt_lib}", "-ldmumps", *opts
        system "./c_example", *opts
      end
    end
  end
end
