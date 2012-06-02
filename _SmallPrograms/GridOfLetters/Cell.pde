class Cell
{
  char letter;
  boolean readOnly;
  
  Cell(char c)
  {
    letter = c;
    readOnly = false;
  }
  
  Cell(char c, boolean ro)
  {
    letter = c;
    readOnly = ro;
  }
  
  void draw()
  {
  }
}

