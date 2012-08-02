import gifAnimation.Gif;

String[] animations =
{
  "H:/PhiLhoSoft/Processing/libraries/gifAnimation/examples/gifDisplay/data/lavalamp.gif",
  "G:/Images/Animations/aniswirl.gif",
  "G:/Images/Animations/copcar.gif"
};

Gif loopingGif;
int gifIndex;

public void setup()
{
  size(600, 200);
  smooth();
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
