String tk = Character.toString((char) 0x40);
String eol = Character.toString((char) 0x0A);
char[] closingA = { 0x22, 0x20, 0x2B, 0x20, 0x6E, 0x20, 0x2B, 0x0A, 0x22 };
String closing = new String(closingA);
char q = 34, sc = 59, n = 10;
String p =
"String tk = Character.toString((char) 0x40);" + n +
"String eol = Character.toString((char) 0x0A);" + n +
"char[] closingA = { 0x22, 0x20, 0x2B, 0x20, 0x6E, 0x20, 0x2B, 0x0A, 0x22 };" + n +
"String closing = new String(closingA);" + n +
"char q = 34, sc = 59, n = 10;" + n +
"String p =" + n +
"@" + n +
"String fp = q + p.replaceAll(eol, closing) + q + sc;" + n +
"println(p.replace(tk, fp));" + n +
"exit();" + n +
"";
String fp = q + p.replaceAll(eol, closing) + q + sc;
println(p.replace(tk, fp));
exit();
