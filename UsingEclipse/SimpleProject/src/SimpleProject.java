//import java.io.File;

import processing.core.PApplet;
import processing.core.PImage;

import processing.opengl.*;

// Here, import processing.pdf.*; isn't needed

@SuppressWarnings("serial") // The warning isn't important here
public class SimpleProject extends PApplet
{
	private PImage bg;
	// Reuse code in the PDF library page
	@Override
	public void setup()
	{
		// Better give full path, or use selectOutput()
//		size(400, 400, PDF, sketchPath + "/../output/filename.pdf");
//		size(1366, 768);
		size(350, 403, OPENGL);

		println(sketchPath);
//		bg = loadImage("../data/smileBkg.png");
		bg = loadImage("../data/DarthVaderHelmet.jpg");
	}

	@Override // Good to use: if you make a typo, you will get an error!
	public void draw()
	{
//		background(bg);
		image(bg, 0, 0);

		// Draw something good here
		line(0, 0, width/2, height);

		// Exit the program
//		println("Finished.");
//		exit();
	}
}
