// https://forum.processing.org/topic/load-external-pde

interface Shape
{
  void draw(int[] params); // Ensure all classes implementing the interface will have this method
}
class Rect implements Shape
{
  void draw(int[] params)
  {
    rect(params[0], params[1], params[2], params[3]);
  }
}
class Ellipse implements Shape
{
  void draw(int[] params)
  {
    ellipse(params[0], params[1], params[2], params[3]);
  }
}
// The catalog of shapes
HashMap<String, Shape> shapes = new HashMap<String, Shape>();
void setup()
{
  size(400, 400);
  noLoop();
  shapes.put("rect", new Rect());
  shapes.put("ellipse", new Ellipse());
}
// The drawing instructions, can be read from a file
String[] drawings =
{
  "ellipse(10,20,55,55);",
  "rect(100,30,55,55);",
  "ellipse(250,310,55,55);",
  "fill(55,110,220);",
  "rect(120,130,55,55);",
};
void draw()
{
  background(255);
  for (String line : drawings)
  {
    line = line.replaceAll("\\);", ""); // Remove tail
    String[] parts = split(line, "(");
    String shapeName = parts[0];
    println(parts[1]);
    String[] paramsStr = split(parts[1], ",");
    int[] paramsInt = int(paramsStr);
    println(paramsInt);
    Shape shape = shapes.get(shapeName);
    shape.draw(paramsInt);
  }
}

