/**
Maze generation.
Trying to have a robust, multi-algorithm data structure, a flexible way to display the maze,
and pluggable algorithms.

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2010/12/11 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicense.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2010 Philippe Lhoste / PhiLhoSoft
*/
// Maze Generation

final int MAZE_WIDTH = 50;
final int MAZE_HEIGHT = 75;
final int CELL_SIZE = 20;
final int WALL_WIDTH = 3;

GrapicalMaze maze;

void setup()
{
  size(600, 600);
  smooth();
  maze = new GrapicalMaze(MAZE_WIDTH, MAZE_HEIGHT);
  maze.setCellSize(CELL_SIZE);
  maze.setWallWidth(WALL_WIDTH);
}

void draw()
{
  background(255);
  maze.display();
}
