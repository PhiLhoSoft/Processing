  public PLShape loadPLShape(String filename) {
    if (filename.toLowerCase().endsWith(".svg")) {
      PLShape shape = new PLShapeSVG(this, filename);
      return shape.getShape();
    }
    return null;
  }

  public void shape(PLShape shape) {
    g.shape(shape);
  }

  public void shape(PLShape shape, float x, float y) {
    g.shape(shape, x, y);
  }

  public void shape(PLShape shape, float x, float y, float c, float d) {
    g.shape(shape, x, y, c, d);
  }
