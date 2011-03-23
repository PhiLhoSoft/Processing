//import processing.pdf.*;

PImage posMask;

PFont font;

ArrayList<TextArea> textAreas = new ArrayList<TextArea>();
ArrayList<Name> names = new ArrayList<Name>();

color rood = color(255, 0, 0);
color groen = color(0, 255, 0);
color blauw = color(0, 0, 255);
color wit = color(255);

float lineHeight;
float yShift;

int minNameWidth = MAX_INT;

// . . . . . . . . . . . . . .

void setup() {
  size(1600, 674);
  posMask = loadImage("position_mask2.gif");

  // String[] fontList = PGraphicsPDF.listFonts();
  // println(fontList);
  font = createFont("Myriad Pro", 7);
  textFont(font);

  // fill name array
  String[] lines = loadStrings("namenLijs_big_RandomOrder.txt");

  for (int i = 0; i < lines.length; i++) {
    names.add(new Name(lines[i], i));
    int tw = int(textWidth(lines[i]));
    if (tw < minNameWidth) minNameWidth = tw;
  }
  println("minNameWidth: "+ minNameWidth);

  lineHeight = textAscent() + textDescent();
  yShift = lineHeight+3;
  println("yShift: " + yShift);

  image(posMask, 0, 0);
  detectAreas(posMask, 100, int(224-lineHeight));
  detectAreas(posMask, 271, int(395-lineHeight));
  detectAreas(posMask, 441, int(565-lineHeight));
  println("detectAreas done");

  Collections.sort(textAreas);
  Collections.sort(names);

  // assign name to target
  int targetCount = 0;
  for (Name name : names) {
    while (targetCount < textAreas.size()) {
      if (textAreas.get(targetCount).textAreaWidth >= name.nameWidth) {
        name.targetID = targetCount++;
        break;
      }
      targetCount++;
    }
  }

  //Collections.shuffle(Arrays.asList(textAreas));
}

// . . . . . . . . . . . . . .

void draw() {
  for (TextArea textArea : textAreas) {
    textArea.display();
  }

  // beginRecord(PDF, "frame" + frameCount + ".pdf");
  // call after beginRecord to avoid a error
  textFont(font);
  fill(0);

  for (Name name : names) {
    name.x = textAreas.get(name.targetID).x;
    name.y = textAreas.get(name.targetID).y;
    name.display();
  }

  //endRecord();
  //println(frameCount + " being created");
  //exit();
  noLoop();
}

// . . . . . . . . . . . . . .


void detectAreas(PImage img, int startY, int stopY) {

  int count = startY * img.width;
  TextArea ta = null;

  int textAreaID = 0;
  for (int y = startY; y < stopY; y += yShift) {
    int x = 0;

    while (x < img.width) {
      color c = 0;
      if (img.pixels[count] == groen) {
        ta = new TextArea(x, y, "RIGHT", textAreaID, false, true);
        c = groen;
      }
      else if (img.pixels[count] == wit) {
        ta = new TextArea(x, y, "JUSTIFY", textAreaID, true, true);
        c = wit;
      }
      else if(img.pixels[count] == blauw) {
        ta = new TextArea(x, y, "LEFT", textAreaID, true, false);
        c = blauw;
      }
      x++;
      count++;
      if (c != 0) {
        while (x < img.width && img.pixels[count] == c) {
          x++;
          count++;
        }
        ta.setEndPoint(x-1);
        if (ta.textAreaWidth >= minNameWidth) {
          textAreas.add(ta);
          textAreaID++;
        }
      }
    }
    count += (yShift-1) * width;
  }
}


// . . . . . . . . . . . . . .

void mousePressed() {
  println(get(mouseX, mouseY));
  println("mouseX: "+mouseX + " " + "mouseY: "+mouseY);
  if(get(mouseX, mouseY) == rood) {
    println("rood");
  }
  if(get(mouseX, mouseY) == groen) {
    println("groen");
  }
  if(get(mouseX, mouseY) == blauw) {
    println("blauw");
  }
  if(get(mouseX, mouseY) == wit) {
    println("wit");
  }
}

// . . . . . . . . . . . . . .


