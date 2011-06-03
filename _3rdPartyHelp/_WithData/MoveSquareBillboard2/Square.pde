class Square {
  int X,
      Y,
      mX;
  int Side;
  color FillCol;
  color FontCol;
  String Legend; 
  
  Square(int X, int Y, int Side) {
    this.X = X;
    this.Y = Y;
    this.Side = Side;
    if (random(2) > 1) {
      mX = 1;
    }
    else {
      mX = -1;
    }
  }
  
void Draw() {
    rectMode(CENTER);
    fill(FillCol);
    rect(X, Y, Side, Side);
    fill(FontCol);
    textAlign(CENTER);
    text(Legend, X, Y + Side/3);
  }

void Move() {
  X += mX;
  if (X - Side/2 <= 0 || X + Side/2 >= W) {
    ReverseMove();
  }
}

boolean IsHitting(Square S) {
  return X - Side/2 >= S.X + S.Side/2 ||
      X + Side/2 <= S.X - S.Side/2;
}
    
void ReverseMove() { mX = -mX; }
}
