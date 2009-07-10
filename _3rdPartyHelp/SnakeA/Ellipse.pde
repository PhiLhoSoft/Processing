class Ellipse
{
  int x; int y; int l; 
  Ellipse(int _x, int _y)
  {
    x=_x; y=_y; l=10;
  }
  Ellipse(int _x, int _y, int _l)
  {
    x=_x; y=_y; l=_l;
  }
  void createEllipse()
  {
    ellipse(x,y,l,l);
  }
  void createEllipse(int a,int b)
  {
    ellipse(a,b,l,l);
  }
  
  void moveUp()
  {
    y-=l;
    if(y<0) y=height;
  }
  void moveDown()
  {
    y+=l;
    if(y>height) y=0;
  }
  void moveRight()
  {
    x+=l;
    if(x>width) x=0;
  }
  void moveLeft()
  {
    x-=l;
    if(x<0) x=width;
  }
  int getX()
  {
    return x;
  }
  int getY()
  {
    return y;
  }
  int getL()
  {
    return l;
  }
}

