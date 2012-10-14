// http://sacharya.com/find-the-jar-file-given-a-class-name/
Class<?> context = processing.app.Base.class;
URL location = context.getResource('/' + context.getName().replace(".", "/") + ".class");
String jarPath = location.getPath();
println(jarPath);
String path = jarPath.substring("file:".length(), jarPath.lastIndexOf("!"));
if (path.substring(2, 3).equals(":")) // Windows
{
  path = path.substring(1);
}
println(path);
int pos = path.lastIndexOf("pde.jar");
if (pos == -1) { println("Not found"); exit(); }
String versionPath = path.substring(0, pos) + "version.txt";
String[] lines = loadStrings(versionPath);
println(lines[0]);
exit();

