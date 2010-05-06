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

/**
 * Interface for handling shapes.
 */
public interface PShape {

  /** Generic, only draws its child objects. */
  static public final int GROUP = 0;
  /** A line, ellipse, arc, image, etc. */
  static public final int PRIMITIVE = 1;
  /** A series of vertex, curveVertex, and bezierVertex calls. */
  static public final int PATH = 2;
  /** Collections of vertices created with beginShape(). */
  static public final int GEOMETRY = 3;

  static public final int VERTEX = 0;
  static public final int BEZIER_VERTEX = 1;
  static public final int CURVE_VERTEX = 2;
  static public final int BREAK = 3;

  public boolean isVisible();
  public float getWidth();
  public float getHeight();
  public void draw(PGraphics g);
/*
  public void setName(String name);
  public String getName();
  public void setVisible(boolean visible);
  public void disableStyle();
  public void enableStyle();
  public int getChildCount();
  public PShape getChild(int index);
  public PShape getChild(String target);
  public PShape findChild(String target);
  public void addChild(PShape who);
  public void translate(float tx, float ty);
  public void translate(float tx, float ty, float tz);
  public void rotateX(float angle);
  public void rotateY(float angle);
  public void rotateZ(float angle);
  public void rotate(float angle);
  public void rotate(float angle, float v0, float v1, float v2);
  public void scale(float s);
  public void scale(float x, float y);
  public void scale(float x, float y, float z);
  public void resetMatrix();
  public void applyMatrix(PMatrix source);
  public void applyMatrix(PMatrix2D source);
  public void applyMatrix(float n00, float n01, float n02,
                          float n10, float n11, float n12);
  public void apply(PMatrix3D source);
  public void applyMatrix(float n00, float n01, float n02, float n03,
                          float n10, float n11, float n12, float n13,
                          float n20, float n21, float n22, float n23,
                          float n30, float n31, float n32, float n33);
*/
}
