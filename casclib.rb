require 'formula'

class Casclib < Formula
  homepage "http://www.zezula.net/en/casc/main.html"
  head "https://github.com/timkurvers/CascLib.git", branch: "normalize/cmake-lists"

  depends_on "cmake" => :build

  patch :DATA

  def install
    system "cmake", "CMakeLists.txt", "-DWITH_STATIC=YES", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <stdio.h>
      #include <CascLib.h>

      int main(int argc, char *argv[]) {
        printf("%s", CASCLIB_VERSION_STRING);
        return 0;
      }
    EOS
    system ENV.cc, "-o", "test", "test.c"
    system "./test", "-v"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 01e042c..76ccd23 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -105,7 +105,6 @@ if(WITH_STATIC)
 endif()

 if(APPLE)
-    set_target_properties(casc PROPERTIES FRAMEWORK true)
     set_target_properties(casc PROPERTIES PUBLIC_HEADER "src/CascLib.h src/CascPort.h")
     set_target_properties(casc PROPERTIES LINK_FLAGS "-framework Carbon")
 endif()
