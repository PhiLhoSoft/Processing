PGraphicsSVG 1.0

This library is just a new PGraphics renderer for Processing, like the PDF or the DXF ones.
It extends the PGraphicsJava2D renderer, allowing to save the drawings of a sketch to a SVG file.
It doesn't handle animations, rendering only a static image.
It doesn't handle multiple pages.

Unlike the PDF renderer, you can use save() and saveFrame() with PGraphicsSVG.
On the other hand, the Pausing While Recording (pause-resume) sketch of the PDF library
cannot be done with PGraphicsSVG because of a different way of handling
recording events: if this sketch is used with PGraphicsSVG instead of PDF,
only the last drawing events will be recorded.

See the examples for examples of use.


Note: there is a bug* in Batik 1.7, binary dated 2008-01-09.
It has been fixed in the SVN trunk but not released in the binary version yet.
Text size defined in inline CSS is written without unit, making it size to be ignored by some renderers (Firefox and Opera).
A suggested workaround is to disable inline CSS (setUseInlineCSS(false)).
Another one is to hand-edit (or use automated replace) the generated SVG to add the missing unit.
A regular expression like: /font-size:(\d+);/ -> /font-size:\1px;/ can do the job.

* https://issues.apache.org/bugzilla/show_bug.cgi?id=50100

--

By Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com

Home page of the library:
http://bazaar.launchpad.net/~philho/+junk/Processing/files/head:/libraries/PGraphicsSVG/

Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2012 Philippe Lhoste / PhiLhoSoft

This version of PGraphicsSVG uses Apache Batik 1.7.
http://xmlgraphics.apache.org/batik/
It is to be used with Processing 1.5+
http://Processing.org

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
(filter, blend, mask, etc.) must be done in a regular PGraphics and will result in a new image.

SavingChoice shows how to save a chosen frame from an animation.
This implies to reset the previous recordings on each new frame.

TrySettings shows the various settings available for this renderer, and how to save to different files.

--

History: it has been started in July 2012 after a question* on the Processing.org forum
shown the old proSVG library is badly outdated and doesn't work anymore with
modern Processing.

* https://forum.processing.org/topic/status-of-prosvg-svg-export-plugin

I have a long time interest in SVG, back to a time there was little support for it.
Now most good browsers have a native support for it, Inkscape is very good at handling it,
and of course other softwares (Gimp, Illustrator, Photoshop, etc.) can handle it too.
And, of course, Processing itself can read simple SVG files
(I contributed some little improvements to this part).

So I thought it was time to have a modern SVG renderer for Processing.

I took a look at proSVG and indeed saw it has many issues, being based on an old Processing version.
But I also saw it was easy to take a subset of the Batik library
(general purpose Java library to handle SVG documents),
a small set of hand-selected jars, the minimum needed to generate SVG files out of
Java2D drawing commands.

So I created a new library, modeled after the PGraphicsPDF one, allowing more options,
correctly handling images, and working with Processing 1.5.1 and 2.0a (and hopefully later versions!).

