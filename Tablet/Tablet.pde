/**
Experiment with JPen.
JPen - Java Pen Tablet Access Library <http://jpen.wiki.sourceforge.net/>

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2008/10/18 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/

import jpen.event.*;
import jpen.*;

void setup()
{
  size(700, 700);

  PenManager pm = new PenManager(this);
  pm.pen.addListener(new ProcessingPen());
  smooth();
  noStroke();
  background(#FFFFFF);
}

void draw()
{
}

// Most of the code here is taken from the DrawingSurface demo code.
public class ProcessingPen extends PenAdapter
{
  boolean bIsDown;
  float prevXPos = -1, prevYPos = -1;

  public void penButtonEvent(PButtonEvent evt)
  {
    // See if the pen is down
    bIsDown = evt.pen.hasPressedButtons();
  }

  public void penLevelEvent(PLevelEvent evt)
  {
    // Ignore events which are not a move
    if (!evt.isMovement())
      return;

    // Get kind of event: does it come from mouse (CURSOR), STYLUS or ERASER?
    PKind type = evt.pen.getKind();
    // Discard events from mouse
    if (type == PKind.valueOf(PKind.Type.CURSOR))
      return;

    // set the brush's size, and opacity relative to the pressure
    float brushSize = evt.pen.getLevelValue(PLevel.Type.PRESSURE) * 10;
    float opacity = 255 * evt.pen.getLevelValue(PLevel.Type.PRESSURE);

    // Get the current cursor location
    float xPos = evt.pen.getLevelValue(PLevel.Type.X);
    float yPos = evt.pen.getLevelValue(PLevel.Type.Y);
    if (prevXPos == -1)
    {
      prevXPos = xPos;
      prevYPos = yPos;
    }
    if (bIsDown)    // If the pen is down, draw
    {
      /* If the stylus is being pressed down, we want to draw a black
         line onto the screen. If it's the eraser, we want to create
         a white line, effectively "erasing" the black line
      */
      if (type == PKind.valueOf(PKind.Type.STYLUS))
      {
        stroke(255 - opacity);
      }
      else if (type == PKind.valueOf(PKind.Type.ERASER))
      {
        stroke(opacity);
      }

      // Draw a line between the current and previous locations
      strokeWeight(brushSize);
      line(prevXPos, prevYPos, xPos, yPos);
      prevXPos = xPos;
      prevYPos = yPos;
    }
  }
}