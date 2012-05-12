// https://forum.processing.org/topic/draw-a-line-that-links-pixels-with-same-color
 
PImage img;

void setup() {
  size(400, 400);
  
  color pointColor = color(255, 0, 0);
  
  // Here, you would have a loadImage() instead
  img = createImage(width, height, RGB);
  // Fill the image with white
  Arrays.fill(img.pixels, #FFFFFF);
  drawPoints(pointColor);
  collectPoints(pointColor);
}
 
void draw() {
  image(img, 0, 0);
  if (mousePressed) drawConnectors(color(0));
}
 
void drawPoints(color c) {
  img.set(200, 35, c);
  img.set(300, 377, c);
  img.set(120, 25, c);
  img.set(5, 223, c);
  img.set(76, 286, c);
}
 
ArrayList<PVector> points = new ArrayList<PVector>();
void collectPoints(color toConnect) {
  for (int i = 0; i < img.pixels.length; i++) {
    if (img.pixels[i] == toConnect) {
      points.add(new PVector(i % width, floor(i / width)));
    }
  }
}
 
void drawConnectors(color connectorColor) {
  stroke(connectorColor);
  
  int pointNb = points.size();
  for (int i = 0; i < pointNb; i++) {
    for (int j = 0; j < pointNb; j++) {
      if (i != j) {
        PVector pi = points.get(i);
        PVector pj = points.get(j);
        line(pi.x, pi.y, pj.x, pj.y);
      }
    }
  }
}

