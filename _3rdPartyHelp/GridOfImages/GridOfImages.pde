final int CELL_NB_H = 3;
final int CELL_NB_V = 2;
final int CELL_NB_TOTAL = CELL_NB_H * CELL_NB_V;
float cellWidth, cellHeight;

Export[] all = new Export[CELL_NB_TOTAL];
int currentImage, imageNb;

void setup() {
  size(600, 400);
  cellWidth = width / CELL_NB_H;
  cellHeight = height / CELL_NB_V;
  background(255);
  imageMode(CENTER);

  getImageList();
  addClassInstance();
}

PImage[] images;
void getImageList() {
  File imageDir = new File("G:/Images");
  String[] imageNames = imageDir.list(
    new FilenameFilter() {
      public boolean accept(File dir, String name) {
        return name.endsWith(".png") || name.endsWith(".jpg");
      }
    }
  );
  images = new PImage[imageNames.length];
  for (int i = 0; i < imageNames.length; i++) {
    images[i] = loadImage(imageDir + "/" + imageNames[i]);
  }
}

void addClassInstance() {
  Export neimage = new Export(imageNb);
  currentImage = imageNb;
  all[imageNb++] = neimage;
  imageNb %= CELL_NB_TOTAL;
}

void draw() {
  // Draw the grid
  float x = 0;
  while (x < width) {
    float y = 0;
    while (y < height) {
      fill(255);
      rect(x, y, cellWidth, cellHeight);
      y += cellHeight;
    }
    x += cellWidth;
  }
  for (Export b : all) {
    if (b != null) {
      b.draw();
    }
  }
  Export current = all[currentImage];
  if (current.isMax()) {
    addClassInstance();
  }
}

class Export {
  PImage eimage;
  float x, y;
  int i = 0;
  float w = 15;
  float h = 15;

  // Constructor: no need for an init() function
  Export(int n) {
    int number = int(random(images.length));
    eimage = images[number];
    x = cellWidth * (n % CELL_NB_H) + cellWidth / 2;
    y = cellHeight * (n / CELL_NB_H) + cellHeight / 2;
  }

  void draw() {

    if (!isMax()) {
      image(eimage, x, y, w + i, h + i);
      i++;
    }
    else {
      image(eimage, x, y, cellWidth, cellHeight);
    }
  }

  boolean isMax() {
    return w + i > cellWidth;
  }
}

