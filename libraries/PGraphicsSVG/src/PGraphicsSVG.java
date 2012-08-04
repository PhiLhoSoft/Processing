package org.philhosoft;

import java.awt.Graphics2D;
//~ import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;

import org.apache.batik.svggen.SVGGraphics2D;
import org.apache.batik.svggen.SVGGeneratorContext;
import org.apache.batik.svggen.ImageHandler;
import org.apache.batik.svggen.GenericImageHandler;
import org.apache.batik.svggen.CachedImageHandlerBase64Encoder;
import org.apache.batik.svggen.ImageHandlerPNGEncoder;
import org.apache.batik.svggen.ImageHandlerJPEGEncoder;
import org.apache.batik.dom.GenericDOMImplementation;

import org.w3c.dom.Document;
import org.w3c.dom.DOMImplementation;

import processing.core.PApplet;
import processing.core.PGraphicsJava2D;

/*
Inspired by the original SVGOut by Christian Riekoff <http://www.texone.org/prosvg/> (dead link!),
and by the update by Konstantin Levinski <https://sites.google.com/site/kdlprosvg/>.

Entirely rewritten to conform to modern (1.5) Processing PGraphics and in particular
to use the same structure than PGraphicsPDF, since they are very similar:
Both rely on a library (iText for PDF, Batik for SVG) that reuse the Java2D API, allowing
to write vector files from regular Java programs with little changes.
This leads to a simple and short implementation, allowing lot of flexibility.

Now uses Batik 1.7 jars.
Experimentally defining the minimal subset needed to generate static SVG files.
*/
public class PGraphicsSVG extends PGraphicsJava2D
{
	/** File being written, if it's a file. */
	protected File file;
	/** OutputStream being written to, if using an OutputStream, eg. in save to Web. */
	protected OutputStream output;

	private SVGGraphics2D svgG2D;

	private boolean bUseInlineCSS = true; // We want to use CSS style attributes

	public enum FileFormat
	{
		INTERNAL,
		EXTERNAL_PNG,
		EXTERNAL_JPEG,
	}
	private FileFormat fileFormat = EXTERNAL_PNG;

	public PGraphicsSVG()
	{
		// SVG always likes native fonts. Always.
		hint(ENABLE_NATIVE_FONTS);
	}

	public void setPath(String path)
	{
		// From PGraphics
		this.path = path;
		if (path != null)
		{
			if (!path.toLowerCase().endsWith(".svg"))
			{
				// if no .svg extension, add it..
				path += ".svg";
			}
			file = new File(path);
			if (!file.isAbsolute()) file = null;
		}
		if (file == null)
		{
			throw new RuntimeException("PGraphicsSVG requires an absolute path " +
					"for the location of the output file.");
		}
	}

	/**
	 * @param b  if true (default), the generated CSS will use CSS to define properties,
	 *        otherwise, the properties will be defined by XML attributes.
	 */
	public void setUseInlineCSS(boolean b)
	{
		bUseInlineCSS = b;
	}

	/**
	 * @param ff  one of the FileFormat: INTERNAL to embed the image in Base64 format in the SVG file
	 *        (can make a big file!), EXTERNAL_PNG to save them as PNG external file,
	 *        EXTERNAL_JPEG to save them as Jpeg external file.
	 */
	public void setFileFormat(FileFormat ff)
	{
		fileFormat = ff;
	}

	/**
	 * Set the library to write to an output stream instead of a file.
	 */
	public void setOutput(OutputStream output)
	{
		this.output = output;
	}

	public void beginDraw() // TODO
	{
		try
		{
			if (file != null)
			{
				output = new OutputStreamWriter(new FileOutputStream(file), "UTF-8");
			}
			else if (output == null)
			{
				throw new RuntimeException("PGraphicsSVG requires a path " +
						"for the location of the output file.");
			}
		}
		catch (IOException e)
		{
			e.printStackTrace();
			throw new RuntimeException("Problem saving the SVG file.");
		}

		super.beginDraw();

		// Also need to push the matrix since the matrix doesn't reset on each run
		// http://dev.processing.org/bugs/show_bug.cgi?id=1227
		pushMatrix();
	}

	public void endDraw()
	{
		// Also need to pop the matrix since the matrix doesn't reset on each run
		// http://dev.processing.org/bugs/show_bug.cgi?id=1227
		popMatrix();

		saveFile();
	}

	/**
	 * Change the textMode() to either SHAPE or MODEL.
	 * <br/>
	 * This resets all renderer settings, and therefore must
	 * be called <em>before</em> any other commands that set the fill()
	 * or the textFont() or anything. Unlike other renderers,
	 * use textMode() directly after the size() command.
	 */
	public void textMode(int mode)
	{
		if (mode == SCREEN)
			// Quick exit!
			throw new RuntimeException("textMode(SCREEN) not supported with SVG");
		if (mode != SHAPE && mode != MODEL)
			throw new RuntimeException("textMode(" + mode + ") does not exist");

		if (textMode == mode) // Ignore non changes
			return;

		textMode = mode;

		dispose();
		allocate();
	}

	// Called by PGraphics.setSize()
	protected void allocate()
	{
		g2 = createGraphics();
	}

	protected Graphics2D createGraphics()
	{
        // Get a DOMImplementation.
        DOMImplementation domImpl = GenericDOMImplementation.getDOMImplementation();

        // Create an instance of org.w3c.dom.Document.
        Document document = domImpl.createDocument("http://www.w3.org/2000/svg", "svg", null);

        // Create an instance of the SVG Generator.
        SVGGeneratorContext ctx = SVGGeneratorContext.createDefault(document);

        // General file comment
        ctx.setComment(" Generated by Processing with the PGraphicsSVG library ");

		// Text options
		if (textMode == SHAPE)
		{
			// Save the shape of each letter in the SVG file
			ctx.setEmbeddedFontsOn(true);
		}
		else if (textMode == MODEL)
		{
			// Just use the system's font, if installed
			ctx.setEmbeddedFontsOn(false);
		}
		else
		{
			throw new RuntimeException("textMode " + mode + " does not exist");
		}

        // Image options
		switch (fileFormat)
		{
			case INTERNAL:
			{
				// Reuse our embedded base64-encoded image data.
				GenericImageHandler ihandler = new CachedImageHandlerBase64Encoder();
				ctx.setGenericImageHandler(ihandler);
				break;
			}
			case EXTERNAL_PNG:
			{
				// Don't embed images, save to the pointed directory
				ImageHandler ihandler = new ImageHandlerPNGEncoder("", null); // "res/images"
				ctx.setImageHandler(ihandler);
				break;
			}
			case EXTERNAL_JPEG:
			{
				// Don't embed images, save to the pointed directory
				ImageHandler ihandler = new ImageHandlerJPEGEncoder("", null); // "res/images"
				ctx.setImageHandler(ihandler);
				break;
			}
			default:
				assert false : "Update this switch with the FileFormat enum!";
		}

		// Create an instance of the SVG Generator
        svgG2D = new SVGGraphics2D(ctx, false);
        svgG2D.setSVGCanvasSize(new Dimension(width, height));
		return svgG2D;
	}

	public void dispose()
	{
		g2.dispose();
	}

	/**
	 * Don't open a window for this renderer, it won't be used.
	 */
	public boolean displayable()
	{
		return false;
	}

	protected void saveFile()
	{
		boolean success = false;

		Writer out = null;
		try
		{
			svgG2D.stream(output, bUseInlineCSS);
			success = true;
		}
		catch (IOException e)
		{
			e.printStackTrace();
			success = false;
		}
		finally
		{
			if (output != null)
			{
				try
				{
					output.close();
				}
				catch (IOException e)
				{
					e.printStackTrace();
					success = false;
				}
			}
		}
		if (!success)
		{
			throw new RuntimeException("Error while saving SVG image.");
		}
	}

	//////////////////////////////////////////////////////////////


	public void loadPixels() { nope("loadPixels"); }
	public void updatePixels() { nope("updatePixels"); }
	public void updatePixels(int x, int y, int c, int d) { nope("updatePixels"); }
	//
	public int get(int x, int y) { nope("get"); return 0; }
	public PImage get(int x, int y, int c, int d) { nope("get"); return null; }
	public PImage get() { nope("get"); return null; }
	public void set(int x, int y, int argb) { nope("set"); }
	public void set(int x, int y, PImage image) { nope("set"); }
	//
	public void mask(int alpha[]) { nope("mask"); }
	public void mask(PImage alpha) { nope("mask"); }
	//
	public void filter(int kind) { nope("filter"); }
	public void filter(int kind, float param) { nope("filter"); }
	//
	public void copy(int sx1, int sy1, int sx2, int sy2, int dx1, int dy1, int dx2, int dy2) { nope("copy"); }
	public void copy(PImage src, int sx1, int sy1, int sx2, int sy2, int dx1, int dy1, int dx2, int dy2) { nope("copy"); }
	//
	public void blend(int sx, int sy, int dx, int dy, int mode) { nope("blend"); }
	public void blend(PImage src, int sx, int sy, int dx, int dy, int mode) { nope("blend"); }
	public void blend(int sx1, int sy1, int sx2, int sy2, int dx1, int dy1, int dx2, int dy2, int mode) { nope("blend"); }
	public void blend(PImage src, int sx1, int sy1, int sx2, int sy2, int dx1, int dy1, int dx2, int dy2, int mode) { nope("blend"); }
	//
//~ 	public void save(String filename) { nope("save"); }
	//
	protected void nope(String function)
	{
		throw new RuntimeException("No " + function + "() for PGraphicsSVG");
	}
}
