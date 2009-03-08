size(800, 200, P2D); // With Java2D, no need for all this
 
char[] charset = new char[0xD7A3 - 0xAC00 + 1];
StringBuilder strB = new StringBuilder();
for (int i = 0, code = 0xAC00; code <= 0xD7A3; i++, code++)  
{
  charset[i] = Character.toChars(code)[0];
  if (i % 256 == 0)
  {
    strB.append(charset[i]);
  }
}
println("Creating font");
PFont   myFont = createFont("Arial Unicode MS", 24, true, charset);
 
background(0);
fill(255);
textFont(myFont);
text(strB.toString(), 10, 100); 


