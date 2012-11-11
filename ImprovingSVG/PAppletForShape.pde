  public PShape loadPLShape(String filename) {
    if (filename.toLowerCase().endsWith(".svg")) {
println("\n=== SVG File: " + filename + "\n");
// For some reason, it no longer works in 1.5.1? Not important as most changes of PLShapeSVG
// are now in the core of Processing...
//      PShape shape = new processing.core.PLShapeSVG(this, filename);
      PShape shape = new PShapeSVG(this, filename);
      return shape;
    }
    return null;
  }
/*
  public void shape(PLShape shape) {
    g.shape(shape);
  }

  public void shape(PLShape shape, float x, float y) {
    g.shape(shape, x, y);
  }

  public void shape(PLShape shape, float x, float y, float c, float d) {
    g.shape(shape, x, y, c, d);
  }
*/

