import javax.swing.JOptionPane;

String message = "Dream Land";

Grid grid;

int MARGIN = 10;

Cell draggedCell;
int dragX, dragY;
boolean dragging;

void setup()
{
  size(800, 800);
  smooth();
  textAlign(CENTER, CENTER);
  textSize(24);
  
  grid = new Grid(message);
}

void draw()
{
  background(255);
  
  grid.draw();
  
  if (dragging)
  {
    int col = grid.getPos(mouseX);
    int row = grid.getPos(mouseY);
    draggedCell.draw(mouseX - dragX, mouseY - dragY);
  }
}

void mousePressed()
{
  Cell cell = grid.getCell(mouseX, mouseY);
  if (cell == null)
    return; // Invalid, ignore it
    
  if (mouseButton == LEFT)
  {
    if (!dragging)
    {
      dragging = true;
      int col = grid.getPos(mouseX);
      int row = grid.getPos(mouseY);
      dragX = mouseX - grid.getCoord(col);
      dragY = mouseY - grid.getCoord(row);
      draggedCell = cell;
    }
  }
  else // Right click
  {
    if (cell.readOnly)
      return; // No input in the read-only cells
      
    noLoop();
    String input = JOptionPane.showInputDialog("Enter a letter");
    if (input != null && input.length() > 0) // Not cancelled and at least one letter
    {
      char c = input.charAt(0);
      cell.setLetter(c);
    }
    loop();
  }
}

void mouseReleased()
{
  dragging = false;
  // Find where the cell has been dropped
  Cell cell = grid.getCell(mouseX, mouseY);
  if (cell == null)
    return; // Invalid, ignore it

  if (cell.readOnly)
    return; // Cannot be changed, ignore the drop
    
  cell.setLetter(draggedCell.letter.charAt(0));
}

