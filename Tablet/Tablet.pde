/**
Experiment with JPen.
JPen - Java Pen Tablet Access Library <http://jpen.wiki.sourceforge.net/>

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.01.000 -- 2009/09/04 (PL) -- Testing again (with Processing 1.0), minor fixes,
             more events and values.
 1.00.000 -- 2008/10/18 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008-2009 Philippe Lhoste / PhiLhoSoft
*/

import jpen.event.*;
import jpen.*;

void setup()
{
  size(800, 800);

  PenManager pm = new PenManager(this);
  pm.pen.addListener(new ProcessingPen());
  smooth();
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
    /* Or check with a finer granularity.
    // Pen pressed is LEFT for me (Bamboo).
    if (evt.pen.getButtonValue(PButton.Type.LEFT))
      println("LEFT");
    if (evt.pen.getButtonValue(PButton.Type.CENTER))
      println("CENTER");
    // Pen button pressed is RIGHT
    if (evt.pen.getButtonValue(PButton.Type.RIGHT))
      println("RIGHT");
    //*/
  }

  public void penLevelEvent(PLevelEvent evt)
  {
    // Get kind of event: does it come from mouse (CURSOR), STYLUS or ERASER?
    PKind type = evt.pen.getKind();
    // Discard events from mouse
    if (type == PKind.valueOf(PKind.Type.CURSOR))
      return;

    // Get the current cursor location
    float xPos = evt.pen.getLevelValue(PLevel.Type.X);
    float yPos = evt.pen.getLevelValue(PLevel.Type.Y);

    // Set the brush's size, and darkness relative to the pressure
    float pressure = evt.pen.getLevelValue(PLevel.Type.PRESSURE);
    float brushSize = pressure * 10;
    float darkness = 255 * pressure;

    // Get the tilt values (not with a Bamboo... so untested!)
    float xTilt = evt.pen.getLevelValue(PLevel.Type.TILT_X);
    float yTilt = evt.pen.getLevelValue(PLevel.Type.TILT_Y);
    // Transform them to azimuthX and altitude, two angles with the projection of the pen against the X-Y plane
    // azimuthX is the angle (clockwise direction) between this projection and the X axis. Range: -pi/2 to 3*pi/2.
    // altitude is the angle between this projection and the pen itself. Range: 0 to pi/2.
    // Might be more pratical to use than raw x/y tilt values.
    double[] aa = { 0.0, 0.0 };
    PLevel.Type.evalAzimuthXAndAltitude(aa, xTilt, yTilt);
    // or just PLevel.Type.evalAzimuthXAndAltitude(aa, evt.pen);
    double azimuthX = aa[0];
    double altitude = aa[1];

    /* If the stylus is being pressed down, we want to draw a black
       line onto the screen. If it's the eraser, we want to create
       a white line, effectively "erasing" the black line
    */
    if (type == PKind.valueOf(PKind.Type.STYLUS))
    {
      color c = color(0, 0, 255 - darkness);
      stroke(c);
    }
    else if (type == PKind.valueOf(PKind.Type.ERASER))
    {
      stroke(255, darkness);
    }
    else
    {
      return; // IGNORE or CUSTOM...
    }

    if (!evt.isMovement())
    {
      // Not a movement, just draw a dot
      ellipse(xPos, yPos, brushSize, brushSize);
      return;
    }

    if (!bIsDown)
    {
      // Pen up, stop current line and down't draw anywthing
      prevXPos = -1;
      return;
    }

    if (prevXPos == -1)
    {
      prevXPos = xPos;
      prevYPos = yPos;
    }

    // Draw a line between the current and previous locations
    strokeWeight(brushSize);
    line(prevXPos, prevYPos, xPos, yPos);
    prevXPos = xPos;
    prevYPos = yPos;
  }

  // When user moves on the big round scroll button
  void penScrollEvent(PScrollEvent evt)
  {
    PScroll.Type type = evt.scroll.getType();
    int value = evt.scroll.value;
    if (type == PScroll.Type.DOWN)
    {
      println("Scrolling down " + value);
    }
    else if (type == PScroll.Type.UP)
    {
      println("Scrolling up " + value);
    }
    else if (type == PScroll.Type.CUSTOM)
    {
      println("Scrolling custom (?) " + value);
    }
  }

  // What is it?
  void penKindEvent(PScrollEvent evt)
  {
    println("Kind Event: " + evt);
  }
}

