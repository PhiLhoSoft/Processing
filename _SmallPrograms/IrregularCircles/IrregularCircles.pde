PGraphics frameToSave;
boolean bSaveToFile = true;

void setup()
{
  size(500, 500);
  int hw = width/2, hh = height/2;
  noLoop();

  if (bSaveToFile)
  {
    frameToSave = createGraphics(width, height, JAVA2D);
    frameToSave.beginDraw();
    frameToSave.noFill();
  }
  background(222);
  translate(hw, hh);
  frameToSave.translate(hw, hh);
  SetParams(0x8800EE00, 0xAA00CC00, 1);
  DrawIrregularCircle(235, 245, PI/877, PI/617);
  SetParams(0x880000EE, 0xAA0000CC, 3);
  DrawIrregularCircle(200, 230, PI/43, PI/31);
  SetParams(0x88EE0000, 0xAACC0000, 5);
  DrawIrregularCircle(100, 200, PI/17, PI/11);
  if (bSaveToFile)
  {
    frameToSave.endDraw();
    frameToSave.save("NiceImage.png");
  }
}

void SetParams(color fColor, color sColor, int sw)
{
  fill(fColor);
  stroke(sColor);
  strokeWeight(sw);
  if (bSaveToFile)
  {
    // No fill, to show transparency
    frameToSave.stroke(sColor);
    frameToSave.strokeWeight(sw * 2);
  }
}
void DrawIrregularCircle(
    int radiusMin, int radiusMax,
    float angleIncrementMin, float angleIncrementMax
)
{
  float angle = 0;
  beginShape();
  if (bSaveToFile) frameToSave.beginShape();
  do
  {
    angle += random(angleIncrementMin, angleIncrementMax);
    float radius = random(radiusMin, radiusMax);
    float x = radius * cos(angle);
    float y = radius * sin(angle);
    vertex(x, y);
    if (bSaveToFile) frameToSave.vertex(x, y);
  } while (angle < TWO_PI);
  endShape(CLOSE);
  if (bSaveToFile) frameToSave.endShape(CLOSE);
}
