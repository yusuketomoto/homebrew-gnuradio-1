
require 'formula'

class Gqrx < Formula
  homepage 'https://github.com/csete/gqrx'
  head 'https://github.com/csete/gqrx.git'

  depends_on 'cmake' => :build
  depends_on 'pkg-config' => :build
  depends_on 'qt'
  depends_on 'boost'
  depends_on 'gnuradio'
  depends_on 'gr-osmosdr'

  def patches
    #patch to compile to binary, comment out pulse audio and link boost correctly
    DATA
  end

  def install
    args = "PREFIX=#{prefix}"
    mkdir "build" do
      system "qmake",  *args, ".."
      system "make"
    end
    Dir.glob("build/*.app") { |app| mv app, prefix }
  end
end
__END__

diff --git a/gqrx.pro b/gqrx.pro
index b1e7687..83f238e 100644
--- a/gqrx.pro
+++ b/gqrx.pro
@@ -220,6 +220,7 @@ unix:!macx {
 
 macx {
     LIBS += -lboost_system-mt -lboost_program_options-mt
+    QMAKE_LFLAGS += -L/usr/local/lib
 }