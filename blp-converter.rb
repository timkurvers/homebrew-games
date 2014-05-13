require 'formula'

class BlpConverter < Formula
  homepage 'https://github.com/Kanma/BLPConverter'
  head     'https://github.com/Kanma/BLPConverter.git'

  depends_on 'cmake' => :build

  def install
    system 'cmake', 'CMakeLists.txt', '-DWITH_LIBRARY=ON', *std_cmake_args
    system 'make install'
  end

  test do
    (testpath/'test.cpp').write <<-EOS.undent
      #include <stdio.h>
      #include <blp.h>

      int main(int argc, char *argv[]) {
        return 0;
      }
    EOS
    system ENV.cc, '-o', 'test', 'test.cpp', '-v'
    system './test', '-v'

    system 'BLPConverter', '--help'
  end
end
