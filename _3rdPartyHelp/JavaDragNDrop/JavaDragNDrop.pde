// https://forum.processing.org/topic/is-it-possible-to-do-drag-and-drop-files-to-a-p5-sketch
// by harry

// Basic drop event listening/handling example.
// Run the sketch and drop various things on its canvas:
// files/folders, images, rendered html, plain text, etc.

void setup() {
  size(700, 400);
  textSize(16); 
  textLeading(18);
  frame.setTitle("Drop something here...");
}

void draw() {
}

// Called when the user drops something on the canvas.
void dropped(Drop drop) {
  // Set the drop location as the frame title
  int x = drop.x;
  int y = drop.y;
  frame.setTitle(
  String.format("Last drop location: x=%d, y=%d", x, y));

  background(50);
  StringBuffer info = new StringBuffer();

  // Is the dropped object text? (For some non-text objects,
  // drop.text() returns the associated path)
  String plain = drop.text();
  if (plain != null)
    info.append("FOUND PLAIN TEXT:\n")
      // grab a preview eg. the 200 first chars
      .append(str_preview(plain, 200))
        .append("\n\n");

  // Is it "rich text"? Eg. dropped from a rendered html or rtf window.
  String rich = drop.richtext();
  if (rich != null)
    info.append("FOUND RICH TEXT:\n")
      .append(str_preview(rich, 200))
        .append("\n\n");

  // Pixel data or file(s) that could be loaded as PImage(s)?
  PImage[] images = drop.images();
  if (images != null) {
    // Display the number of images successfully loaded,
    // use the first image as background
    info.append("FOUND " + images.length + " IMAGES\n\n");
    image(images[0], 0, 0, width, height);
    fill(50, 190); // make it look semi-transparent
    rect(0, 0, width, height);
  }

  // File(s)/folder(s)? Eg. dropped from the OS file explorer.
  String[] paths = drop.paths();
  if (paths != null) {
    info.append("FOUND PATHS/URLS:\n");
    for (String i : paths)
      info.append(i).append('\n');
    info.append('\n');
  }

  fill(255);
  text(info.toString(), 20, 20, width-40, height-40);
}

// Strips leading whitespace, returns the n first characters of s
String str_preview(String s, int n) {
  s = s.trim();
  return s.substring(0, min(n, s.length()));
}


