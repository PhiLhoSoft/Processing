REM Adjust path to your installation directory
set PROCESSING_HOME=C:\Java\Processing-1.5.1
set P=../library/batik
REM Using Batik 1.7. Minimal set of jar files. After batik-awt-util, files probably needed only for run.
javac -cp %P%-dom.jar;%P%-svggen.jar;%P%-awt-util.jar;%P%-util.jar;%P%-ext.jar;%P%-xml.jar;%PROCESSING_HOME%\lib\core.jar PGraphicsSVG.java

