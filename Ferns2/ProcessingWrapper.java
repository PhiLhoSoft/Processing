/**
Wrapper of PApplet (and perhaps some other Processing classes) to offer simplified
access to Processing API/functions: one unique initializer for the whole library,
to store current PApplet instance, and share of this object between library classes.
No longer need to pass this to each class instanciation.
Idea stolen from flux.vertext library made by ?
// by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
// File/Project history:
 1.00.000 -- 2008/06/04 (PL) -- Separation from Fern.pde.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008 Philippe Lhoste / PhiLhoSoft
*/
import processing.core.*;

/**
 * The wrapper of Processing internal guts.
 * Abstract because it shouldn't be instancied: library classes needing Processing specific operations
 * must extend this class. Limiting (cannot extend another class) but OK in most cases.
 */
public abstract class ProcessingWrapper
{
	protected static PApplet p$;

	public static void Register(PApplet p)
	{
		ProcessingWrapper.p$ = p;
	}

	/*
	 * Convenience functions: remake direct access to some functions.
	 */
	public void print(Object o)
	{
		PApplet.print(o);
	}
	public void println(Object o)
	{
		PApplet.println(o);
	}
}
