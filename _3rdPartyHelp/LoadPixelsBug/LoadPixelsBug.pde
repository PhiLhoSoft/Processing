
PGraphics overlay, light;
float theta;

void setup() {
  size(200, 200);
  // Initialize the overlay
  overlay = createGraphics(200, 200, JAVA2D);
  // Initialize the light
  light = createGraphics(200, 200, JAVA2D);
}

void draw() {
  background(255, 0, 0);
  
  // Render the light to a buffer
  theta += radians(2);
  light.beginDraw();
  light.background(0);
  light.fill(255);
  light.arc(100f, 100f, 200f, 200f, theta, theta + PI/4);
  light.endDraw();
  
  // Transfer the light pixel information to the overlay
  light.loadPixels();
  overlay.loadPixels();
  for (int i = 0; i < overlay.width * overlay.height; i++) {
    overlay.pixels[i] = light.pixels[i];
  }
  overlay.updatePixels();

  image(overlay, 0, 0);
  
  // Uncomment to see the light move
  //image(light, 0, 0);
}


