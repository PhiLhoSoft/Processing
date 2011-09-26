// https://forum.processing.org/topic/i-want-to-do-the-mileometer-calculation-with-on-a-mouse

int box_height = 20;
int box_width = 20;
int base_color = 50;
int y_color = 200;
int row_nb, col_nb;
float max_dist, radius;

void setup() {
  size(800, 800);
  colorMode(RGB);
  background(20, 1, 55);
  noStroke();
  smooth();
  frameRate(16);
  
  row_nb = height / box_height;
  col_nb = width / box_width;
  max_dist = sqrt(width * width + height * height);
  println(max_dist);
  radius = max_dist / 20;
  
}

void draw() {
  background(0);
  for (int c = 0; c < col_nb; c++) {
    for (int r = 0; r < row_nb; r++) {
      float e = random(1);
      float distance = dist(c * box_width, r * box_height, mouseX, mouseY) / max_dist;
      if (distance < 0.2 && e < 0.5) {
        fill(base_color + random(8, y_color / 2) + 2.5 * y_color * (0.2 - distance), 10, 40);
        ellipse(c * box_width, r * box_height, box_width, box_height);
      }
    }
  }
} 

