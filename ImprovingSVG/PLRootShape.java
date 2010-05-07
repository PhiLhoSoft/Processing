/* -*- mode: java; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
  Part of the Processing project - http://processing.org

  Copyright (c) 2006-10 Ben Fry and Casey Reas

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General
  Public License along with this library; if not, write to the
  Free Software Foundation, Inc., 59 Temple Place, Suite 330,
  Boston, MA  02111-1307  USA
*/

package processing.core;

import java.util.HashMap;

import processing.core.PApplet;


/**
 * Datatype for storing the root part of complex shapes.
 * Processing can currently load and display SVG (Scalable Vector Graphics) shapes.
 * Before a shape is used, it must be loaded with the <b>loadShape()</b> function.
 * The <b>shape()</b> function is used to draw the shape to the display window.
 * The <b>PShape</b> object contain a group of methods, linked below, that can operate on the shape data.
 * <br><br>The <b>loadShape()</b> method supports SVG files created with Inkscape and Adobe Illustrator.
 * It is not a full SVG implementation, but offers some straightforward support for handling vector data.
 * =advanced
 *
 * @webref LRootShape
 * @usage Web &amp; Application
 * @see PApplet#shape(PShape)
 * @see PApplet#loadShape(String)
 * @see PApplet#shapeMode(int)
 * @instanceName sh any variable of type PShape
 */
public class PLLRootShape implements PShape, PConstants {

  protected String name;
  // The list of IDs and the associated shapes
  protected HashMap<String, PLShape> nameTable;

  /**
   * The width of the PLRootShape document.
   * @webref
   * @brief  	Shape document width
   */
  public float width;
  /**
   * The width of the PLRootShape document.
   * @webref
   * @brief  	Shape document height
   */
  public float height;

  // set to false if the object is hidden in the layers palette
  protected boolean visible = true;

  protected int childCount;
  protected PLRootShape[] children;

  public PLRootShape() {
    this(GROUP);
  }


  public PLRootShape(int family) {
    this.family = family;
    stroke = new PPaint();
    fill = new PPaint();
  }
/*
  CompShape shape;
  public PShape getShape() {
    if (shape == null) {
      shape = new CompShape(this);
    }
    return shape;
  }
*/
  public void setName(String name) {
    this.name = name;
  }

  public String getName() {
    return name;
  }

  /**
   * Returns a boolean value "true" if the image is set to be visible, "false" if not. This is modified with the <b>setVisible()</b> parameter.
   * <br><br>The visibility of a shape is usually controlled by whatever program created the SVG file.
   * For instance, this parameter is controlled by showing or hiding the shape in the layers palette in Adobe Illustrator.
   *
   * @webref
   * @brief Returns a boolean value "true" if the image is set to be visible, "false" if not
   */
  public boolean isVisible() {
    return visible;
  }

  /**
   * Sets the shape to be visible or invisible. This is determined by the value of the <b>visible</b> parameter.
   * <br><br>The visibility of a shape is usually controlled by whatever program created the SVG file.
   * For instance, this parameter is controlled by showing or hiding the shape in the layers palette in Adobe Illustrator.
   * @param visible "false" makes the shape invisible and "true" makes it visible
   * @webref
   * @brief Sets the shape to be visible or invisible
   */
  public void setVisible(boolean visible) {
    this.visible = visible;
  }

  /**
   * Get the width of the drawing area (not necessarily the shape boundary).
   */
  public float getWidth() {
    //checkBounds();
    return width;
  }

  /**
   * Get the height of the drawing area (not necessarily the shape boundary).
   */
  public float getHeight() {
    //checkBounds();
    return height;
  }


  /**
   * Called by the following (the shape() command adds the g)
   * PShape s = loadShapes("blah.svg");
   * shape(s);
   */
  public void draw(PGraphics g) {
    if (visible) {
      pre(g);
      drawImpl(g);
      post(g);
    }
  }
}

