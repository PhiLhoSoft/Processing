int drawingPhase;
String message;

void setup()
{
  size(600, 400);
  background(#ABCDEF);
  PFont font = loadFont("AmericanTypewriter-24.vlw");
  textFont(font, 48);
  textAlign(CENTER);
  DrawingSequencer seq = new DrawingSequencer();
  seq.run();
}

void draw()
{
//  noLoop();
if (drawingPhase == 0) return;
  println("Redrawing " + drawingPhase);
  if (drawingPhase % 2 == 1)
  {
    background(#ABCDEF); fill(#FEDCBA);
    text(message, width / 2, height / 2);
  }
  else
  {
    background(0);
  }
  switch (drawingPhase)
  {
  case 2:
    for (int i = 0; i < 10; i++)
    {
      fill(0x55, i * 25, 0xFF);
      rect(i * 20, i * 20, i * 17, i * 23);
    }
    break;
  case 4:
    for (int i = 0; i < 10; i++)
    {
      fill(0x55, i * 25, 0xFF);
      rect(i * 20, i * 20, i * 17, i * 23);
    }
    break;
  }
}

//~ class DrawingSequencer implements Runnable
class DrawingSequencer extends Thread
{
  DrawingSequencer()
  {
    super("DrawingSequencer");
  }
  void run()
  {
    message = "Rectangles";
    drawingPhase++;
    redraw();
    Delay(5);

    drawingPhase++;
    redraw();
    Delay(10);

    message = "Ellipses";
    drawingPhase++;
    redraw();
    Delay(5);

    drawingPhase++;
    redraw();
    Delay(150);

    message = "END";
    drawingPhase++;
    redraw();
    Delay(10);

  //  exit();
  }
  void Delay(int dur)
  {
    println("Waiting " + dur);
    try
    {
      Thread.sleep(dur * 1000);
    }
    catch (InterruptedException e) { }
  }
}


