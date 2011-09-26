//Dark Side of the Moon Album Cover
// https://forum.processing.org/topic/can-i-attach-a-point-of-a-line-to-a-side-of-a-shape
void setup() {
  size(1280, 720);
  smooth();
}

int anchorX = 500, anchorY = 440;
float a = -1.857, b = 1654.286;
float r = 0.577;
int tX = 640, tY = 180;

void draw() {

  background(0);

  //outer triangle
  noStroke();
  fill(194, 250, 247);
//  triangle(tX, tY, anchorX, anchorY, 780, 440);
  triangle(mouseX, mouseY, anchorX, anchorY, 780, 440);
  float lineLength = sqrt((anchorX - mouseX)^2 + (anchorY - mouseY)^2);

  //inner triangle
  noStroke();
  fill(0);
  triangle(640, 200, 520, 430, 760, 430);

  //alpha triangle
  noFill();
  stroke(142, 247, 241, 191);
  strokeWeight(10);
  triangle(640, 200, 520, 430, 760, 430);

  //light beam
  float ix = anchorX + r * (mouseX - anchorX);
  float iy = anchorY + r * (mouseY - anchorY);
  stroke(255);
  strokeWeight(2);
//  line(0, 400, 581, 290);
//  fill(#FF0000); noStroke(); ellipse(581, 290, 2, 2);
  line(0, 400, ix, iy);
  fill(#FF0000); noStroke(); ellipse(ix, iy, 2, 2);

  //light beam array (beginning)
  noStroke();
  fill(245, 245, 245, 191);
  triangle(579, 290, 640, 270, 640, 300);

  //light beam array (end)
  noStroke();
  fill(245, 245, 245, 120);
  quad(640, 270, 682, 259, 710, 310, 640, 300);  

  //rainbow
  //purple ray
  noStroke();
  fill(167, 110, 188);
  quad(705, 300, 1280, 400, 1280, 420, 710, 310);
  //blue ray
  fill(79, 196, 252);
  quad(700, 290, 1280, 380, 1280, 400, 705, 300);
  //green ray
  fill(119, 198, 86);
  quad(696, 283, 1280, 360, 1280, 380, 700, 290);
  //yellow ray
  fill(254, 255, 18);
  quad(692, 275, 1280, 340, 1280, 360, 696, 283);
  //orange ray
  fill(232, 160, 14);
  quad(688, 268, 1280, 320, 1280, 340, 692, 275);
  //red ray
  fill(255, 9, 0);
  quad(683, 259, 1280, 300, 1280, 320, 688, 268);
}

