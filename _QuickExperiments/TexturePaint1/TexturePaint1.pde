//~ import java.awt.geom.Polygon;
import java.awt.TexturePaint;

PImage smallImage;
Graphics2D g2;
TexturePaint tp;
Polygon poly;

void setup()
{
  size(500, 500);
  smallImage = loadImage("greenfoil.png");
  BufferedImage bufimg = new BufferedImage(
      smallImage.width, smallImage.height,
      smallImage.format == ARGB ?
          BufferedImage.TYPE_INT_ARGB :
          BufferedImage.TYPE_INT_RGB);
  bufimg.setRGB(0, 0, smallImage.width, smallImage.height,
      smallImage.pixels, 0, smallImage.width);
  Rectangle r = new Rectangle(0, 0, smallImage.width, smallImage.height);
  TexturePaint tp = new TexturePaint(bufimg, r);

  poly = new Polygon();
  poly.addPoint(50, 80);
  poly.addPoint(200, 180);
  poly.addPoint(190, 360);
}

void draw()
{
  background(230);
  fill(0);
  stroke(0);

  g2 = ((PGraphicsJava2D) g).g2;
//  SetColor(#FF0000); // Update g2
  strokeWeight(5);
  g2.setPaint(tp);
  g2.fillPolygon(poly);
  g2.drawPolygon(poly);
}


HashMap colorList = new HashMap();
Color GetColor(color c)
{
  Integer ic = Integer.valueOf(c);  // New to 1.5! Cache values
  Color k = (Color) colorList.get(ic);
  if (k == null)
  {
    k = new Color(ic);
    colorList.put(ic, k);
  }
  return k;
}
void SetColor(color c)
{
  Color k = GetColor(c);
  g2.setPaint(k);
}

