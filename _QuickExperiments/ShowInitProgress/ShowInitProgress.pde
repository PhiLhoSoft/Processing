// https://forum.processing.org/topic/display-something-during-initial-loading

int idx = 0;
int[] indices;
int startPhase = 0;
 
void setup()
{
  size(200, 200);
}
 
void draw()
{
  switch (startPhase)
  {
  case 0: // Start the setup
    println(startPhase);
//    setUpSketch();
    thread("setUpSketch");
    startPhase++;
    return;
  case 1: // During the setup
//    println(startPhase);
    showLoading();
    return;
  }
//  println("-  " + startPhase);
  
  if (idx >= width * height)
  {
    println("Done!");
    noLoop();
    return;
  }
  
  loadPixels();
  pixels[indices[idx++]] = 0xFF000000 + idx * 64; //#000000;
  updatePixels();
}
 
void setUpSketch()
{
  println("Starting init");
  indices = new int[width * height];
  // Generate a list of random indices
  for (int i = 1; i < indices.length; i++)
  {
    int j = int(random(0, i+1));
    indices[i] = indices[j];
    indices[j] = i;
  }
  delay(5000); // Lengthly initialization here: load stuff, compute things, etc.
  println("Init ended");
  background(255);
  startPhase++;
}
 
int loadingX = 20;
void showLoading()
{
  background(255);
  fill(0);
  text("Please wait, loading...", 20, height / 2);
  fill(#0000AA);
  ellipse(loadingX, 2 * height / 3, 20, 20);
  loadingX += 2;
  if (loadingX > width - 20)
  {
    loadingX = 20;
  }
}

