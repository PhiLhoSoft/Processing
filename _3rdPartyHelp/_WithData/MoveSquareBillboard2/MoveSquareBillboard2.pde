String Legend = "Hello";
PFont Font;

int N = Legend.length();
int W = 40 * (2 * N + 1),
    H = W/2;
color Red = color(255, 0, 0),
      Yellow = color(255, 255, 0);
      
int Side = 40;
int Y = (H - Side)/2;

Square[] Sqs = new Square[N];


void setup() 
{
  size(W, H);
  background(Yellow);
  Font = loadFont("Cambria-BoldItalic-48.vlw");
  textFont(Font,40);
    for(int i = 0; i < N; i++) {
      Square S = new Square(((3 + 4 * i) * Side)/2, H/2, Side);
      S.FillCol = Red;
      S.Legend = "" + this.Legend.charAt(i);
        S.Draw();
        Sqs[i] = S;
    }     
}

 
void draw() 
{ 
  if (mousePressed == true) {
  background(Yellow);
    for(int i = 0; i < N; i++) {
      Square S = Sqs[i];   
      S.Move();    
      S.Draw();
      for (int j = 0; j < N; j++) {
        if (i == j) continue; // Skip itself
        if (S.IsHitting(Sqs[j]))
          S.ReverseMove();
          // No need to reverse the other as it will be tested too
      }
    }
  }
}







