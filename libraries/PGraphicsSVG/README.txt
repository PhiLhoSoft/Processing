PGraphicsSVG 1.1

PGraphicsSVG is to SVG what PGraphicsPDF is to PDF: a vector renderer for Processing sketches,
allowing to save the drawings of a sketch to a SVG file,  via the Apache Batik library (included).

This renderer extends the PGraphicsJava2D renderer, so (almost) any sketch using this (default) renderer
can render to SVG, with some limitations.
It doesn't handle animations, rendering only a static image.
But saveFrame() can be used to generate several SVG files.
Unlike PGraphicsPDF, it doesn't handle multiple pages.
And the Pausing While Recording (pause-resume) sketch of the PDF library
cannot be done with PGraphicsSVG because of a different way of handling recording events.
But see the SavingChoice sketch in the example for a way to save an image out of animation.

The documentation (beside this README) is currently lacking, but the provided examples
should guide you how to use the library.

Limitations: the pixel manipulations are not allowed (but can be done on a classical PGraphics,
they will be saved as image by the library).
The following functions cannot be used with PGraphicsSVG:
loadPixels
updatePixels
get
get
set
mask
filter
blend
copy

--

By Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com

Home page of the library:
http://bazaar.launchpad.net/~philho/+junk/Processing/files/head:/libraries/PGraphicsSVG/
The binary distribution of the library is currently located at:


Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2012 Philippe Lhoste / PhiLhoSoft

Scalable Vector Graphics (SVG)
http://www.w3.org/Graphics/SVG/

This version of PGraphicsSVG uses Apache Batik 1.7.
http://xmlgraphics.apache.org/batik/

It is to be used with Processing 1.5+
http://Processing.org

--

Note: there is a bug* in Batik 1.7, binary dated 2008-01-09.
It has been fixed in the SVN trunk but not released in the binary version yet.
Text size defined in inline CSS is written without unit,
making its size to be ignored by some renderers (Firefox and Opera).
A suggested workaround is to disable inline CSS (setUseInlineCSS(false)).
Another one is to hand-edit (or use automated replace in) the generated SVG to add the missing unit.
A regular expression like: /font-size:(\d+);/ -> /font-size:\1px;/ can do the job.

* https://issues.apache.org/bugzilla/show_bug.cgi?id=50100

If Apache ever release a new binary, or if you manage to compile a SVN snapshot yourself
(I will try it someday...), you can just replace the jars provided with this library by the new ones.


In some sketches (calling endRecord()) in Processing 1.5.1, you can see the message:
"isRecording(), or this particular variation of it, is not available with this renderer."
It is because Processing calls endRecord() on the main renderer as well as our recorder.
It is just a harmless warning that can be ignored.

--

The examples

Hearts illustrates that we can make a sketch dedicated to exporting a SVG file: its primary drawing surface
is a PGraphicsSVG and calling exit() saves the drawing.

AutoCrop shows how to draw on screen as well as recording the drawing. Here, endRecord() is used
to save the file, as exit() would hide the result.
It illustrates that the drawing surface crops the drawings.

ImageTransform shows we don't even need to define draw(), since we don't animate the sketch.
It also illustrates image manipulations, and how they are saved. Note that some transformations
(translate, scale, rotate) can be applied without creating a new image. Images manipulations at pixel level
(filter, blend, mask, etc.) must be done in a regular PGraphics and will result in a new bitmap image
saved beside the SVG file (default) or as Base64 encoding in the SVG file itself (see TrySettings).

SavingChoice shows how to save a chosen frame from an animation.
This implies to reset the previous recordings on each new frame.

TrySettings shows the various settings available for this renderer, and how to save to different files.

Sequence shows how to use saveFrame() to save a sequence of numbered SVG files.

--

History: it has been started in July 2012 after a question* on the Processing.org forum
shown that the old proSVG** library is badly outdated and doesn't work anymore with
modern Processing. Even the update by Konstantin Levinski*** wasn't working well.

* https://forum.processing.org/topic/status-of-prosvg-svg-export-plugin
** SVGOut by Christian Riekoff <http://www.texone.org/prosvg/> (dead link!)
*** https://sites.google.com/site/kdlprosvg/

I have a long time interest in SVG, back to a time there was little support for it
(beside an Adobe plug-in for Internet Explorer).
Now most good browsers have a native support for it, Inkscape is very good at handling it,
and of course other softwares (Gimp, Illustrator, Photoshop, etc.) can handle it too.
Processing itself can read simple SVG files (I also contributed some little improvements to this part).

So I thought it was time to have a modern SVG renderer for Processing.

I took a look at proSVG and indeed saw it has many issues, being based on an old Processing version.
But I also saw it was easy to take a subset of the Batik library
(general purpose Java library to read and write SVG documents),
a small set of hand-selected jars, the minimum needed to generate SVG files out of
Java2D drawing commands.

So I created a new library, modeled after the PGraphicsPDF one, allowing more options,
correctly handling images, and working with Processing 1.5.1 and 2.0a (and hopefully later versions!).
Like PGraphicsPDF, they rely on a library (iText for PDF, Batik for SVG) that reuse the Java2D API,
allowing to write vector files from regular Java programs with little changes.
This leads to a simple and short implementation, allowing lot of flexibility.
