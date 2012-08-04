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
	 * Set the library to write to an output stream instead of a file.
	 */
	public void setOutput(OutputStream output)
	{
		this.output = output;
	}

	protected void allocate()
	{
		// Create an instance of the SVG Generator
        svgG2D = new SVGGraphics2D(ctx, false);
        svgG2D.setSVGCanvasSize(new Dimension(250, 200));

		g2 = svgG2D;
	}

	public void beginDraw() // TODO
	{
		if (document == null)
		{
			document = new Document(new Rectangle(width, height));
			try
			{
				if (file != null)
				{
					output = new BufferedOutputStream(new FileOutputStream(file), 16384);
				}
				else if (output == null)
				{
					throw new RuntimeException("PGraphicsSVG requires a path " +
							"for the location of the output file.");
				}
//~ 				writer = PdfWriter.getInstance(document, output);
//~ 				document.open();
//~ 				content = writer.getDirectContent();
			}
			catch (Exception e)
			{
				e.printStackTrace();
				throw new RuntimeException("Problem saving the SVG file.");
			}

//~ 			g2 = content.createGraphicsShapes(width, height);
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

		// This needs to be overridden so that the endDraw() from PGraphicsJava2D
		// is not inherited (it calls loadPixels).
		// http://dev.processing.org/bugs/show_bug.cgi?id=1169
	}

	protected Graphics2D createGraphics()
	{
		return null; // TODO
	}


	public void dispose()
	{
		if (document != null)
		{
			g2.dispose();
			document.close();  // can't be done in finalize, not always called
			document = null;
		}
	}

	/**
	 * Don't open a window for this renderer, it won't be used.
	 */
	public boolean displayable()
	{
		return false;
	}

	public void save(String filename)
	{
		boolean success = false;

		try
		{
			if (!filename.toLowerCase().endsWith(".svg"))
			{
				// if no .svg extension, add it..
				filename += ".svg";
			}
			File file = new File(filename);

			//PrintWriter output = new PrintWriter(new FileOutputStream(file));
			Writer out = new OutputStreamWriter(new FileOutputStream(file), "UTF-8");
			svgG2D.stream(out, true); // true = Use inline CSS
			svgGraphics.getSvgGraphics().stream(out, true);
			success = true;
		}
		catch (IOException e)
		{
			e.printStackTrace();
			success = false;
		}
		if (!success)
		{
			throw new RuntimeException("Error while saving image.");
		}
	}

	//////////////////////////////////////////////////////////////


	public void loadPixels() {
		nope("loadPixels");
	}

	public void updatePixels() {
		nope("updatePixels");
	}

	public void updatePixels(int x, int y, int c, int d) {
		nope("updatePixels");
	}

	//

	public int get(int x, int y) {
		nope("get");
		return 0;  // not reached
	}

	public PImage get(int x, int y, int c, int d) {
		nope("get");
		return null;  // not reached
	}

	public PImage get() {
		nope("get");
		return null;  // not reached
	}

	public void set(int x, int y, int argb) {
		nope("set");
	}

	public void set(int x, int y, PImage image) {
		nope("set");
	}

	//

	public void mask(int alpha[]) {
		nope("mask");
	}

	public void mask(PImage alpha) {
		nope("mask");
	}

	//

	public void filter(int kind) {
		nope("filter");
	}

	public void filter(int kind, float param) {
		nope("filter");
	}

	//

	public void copy(int sx1, int sy1, int sx2, int sy2,
									 int dx1, int dy1, int dx2, int dy2) {
		nope("copy");
	}

	public void copy(PImage src,
									 int sx1, int sy1, int sx2, int sy2,
									 int dx1, int dy1, int dx2, int dy2) {
		nope("copy");
	}

	//

	public void blend(int sx, int sy, int dx, int dy, int mode) {
		nope("blend");
	}

	public void blend(PImage src,
										int sx, int sy, int dx, int dy, int mode) {
		nope("blend");
	}

	public void blend(int sx1, int sy1, int sx2, int sy2,
										int dx1, int dy1, int dx2, int dy2, int mode) {
		nope("blend");
	}

	public void blend(PImage src,
										int sx1, int sy1, int sx2, int sy2,
										int dx1, int dy1, int dx2, int dy2, int mode) {
		nope("blend");
	}

	//

	public void save(String filename) {
		nope("save");
	}

	//

	protected void nope(String function) {
		throw new RuntimeException("No " + function + "() for PGraphicsSVG");
	}
}
