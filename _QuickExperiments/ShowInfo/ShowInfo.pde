String p = System.getProperty("java.version") + " | " +
System.getProperty("java.home") + " | " +
System.getProperty("java.vendor") + " | " +
System.getProperty("java.vendor.url");
println(p);
String cp = System.getProperty("java.class.path");
println(cp);
String ed = System.getProperty("java.ext.dirs");
println(ed);
println(sketchPath);
try {
println(java.net.URLEncoder.encode("http://stackoverflow.com/questions/292362/url ⌘⍺ decoding#293028", "UTF-8"));
} catch (UnsupportedEncodingException e) {}
exit();
