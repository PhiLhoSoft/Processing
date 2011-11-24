//import java.io.File;

import processing.core.PApplet;

// Here, import processing.pdf.*; isn't needed

@SuppressWarnings("serial") // The warning isn't important here
public class SimpleProject extends PApplet
{
	// Reuse code in the PDF library page
	@Override
	public void setup()
	{
		// Better give full path, or use selectOutput()
		size(400, 400, PDF, sketchPath + "/../output/filename.pdf");

		println(sketchPath);
//		File f = new File("bar");
	}

	@Override // Good to use: if you make a typo, you will get an error!
	public void draw()
	{
		// Draw something good here
		line(0, 0, width/2, height);

		// Exit the program
		println("Finished.");
		exit();
	}
}
