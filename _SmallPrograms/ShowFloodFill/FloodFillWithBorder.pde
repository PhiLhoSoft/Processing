public class FloodFillWithBorder extends FloodFill
{
  private color borderColor; // Color of border

  public FloodFillWithBorder()
  {
    super();
  }

  public FloodFillWithBorder(PImage imageToProcess)
  {
    super(imageToProcess);
  }

  public void DoFill(int startX, int startY, color fc, color bc)
  {
    // don't run if border color is the same as background one
    if (bc == backColor)
      return;
    borderColor = bc;
    DoFill(startX, startY, fc);
  }

  protected void FillScanLine(int x, int y, int dir)
  {
    // compute current index in pixel buffer array
    int idx = x + y * iw;
    boolean inColorRunAbove = false;
    boolean inColorRunBelow = false;

    // fill until boundary in current scanline...
    // checking neighbouring pixel rows
    while (x >= 0 && x < iw && imagePixels[idx] == backColor)
    {
      // If we are at a color boundary (in the horizontal axis)
      if (x > 0 && dir < 0 && imagePixels[idx - 1] != backColor ||
          x < iw - 1 && dir > 0 && imagePixels[idx + 1] != backColor)
      {
        // We paint the pixel with the border color
        imagePixels[idx] = borderColor;
      }
      else
      {
        imagePixels[idx] = fillColor;
      }
      if (y > 0) // Not on top line
      {
        if (imagePixels[idx - iw] == backColor)
        {
          if (!inColorRunAbove)
          {
            // The above pixel needs to be flooded too, we memorize the fact.
            // Only once per run of pixels of back color (hence the inColorRunAbove test)
            stack.add(new PVector(x, y-1));
            inColorRunAbove = true;
          }
        }
        else // End of color run (or none)
        {
          inColorRunAbove = false;
          // If the above line is neither of fill color (we are on boundary)
          // nor of border color (it is an already painted border)
          if (imagePixels[idx - iw] != fillColor && imagePixels[idx - iw] != borderColor)
          {
            // We are on a boundary on the vertical axis, paint it
            imagePixels[idx] = borderColor;
          }
        }
      }
      if (y < ih - 1) // Not on bottom line
      {
        if (imagePixels[idx + iw] == backColor)
        {
          if (!inColorRunBelow)
          {
            // Idem with pixel below, remember to process there
            stack.add(new PVector(x, y + 1));
            inColorRunBelow = true;
          }
        }
        else // End of color run (or none)
        {
          inColorRunBelow = false;
          // Same as above with below line
          if (imagePixels[idx + iw] != fillColor && imagePixels[idx + iw] != borderColor)
          {
            imagePixels[idx] = borderColor;
          }
        }
      }
      // Continue in given direction
      x += dir;
      idx += dir;
    }
  }
}

