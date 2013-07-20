import gifAnimation.Gif;

String[] animations =
{
  "lavalamp.gif",
  "aniswirl.gif",
  "copcar.gif"
};

Gif loopingGif;
int gifIndex;

public void setup()
{
  size(600, 200);
  smooth();
  Test test = new Test(this, "aniswirl.gif");
}

public void draw()
{
  background(255);

  ellipse(mouseX, mouseY, 50.0F, 50.0F);
  if (loopingGif != null)
  {
    image(loopingGif, 10.0F, height / 2 - loopingGif.height / 2);
  }
}

public void mouseClicked()
{
  if (gifIndex == animations.length) gifIndex = 0;
  loopingGif = new Gif(this, animations[gifIndex]);
  loopingGif.loop();
  gifIndex += 1;
}
