/*
The class associating a matcher and a drawer;
and a sample list of instances of this class.

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2009/05/08 (PL) -- Creation, based on SearchWordsColor and DrawingInSequence.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2009 Philippe Lhoste / PhiLhoSoft
*/

/**
 * Associates a matcher (finding a word or some complex combination)
 * and a drawer (displaying a message in a more or less complex way).
 */
class MatcherAndDrawer
{
  Matcher matcher;
  Drawer drawer;

  MatcherAndDrawer(Matcher m, Drawer d)
  {
    matcher = m;
    drawer = d;
  }
}

/**
 * The demonstration matchers and drawers.
 */
MatcherAndDrawer[] triggers =
{
  new MatcherAndDrawer(new WordInside("grow"), new Growing()),
  new MatcherAndDrawer(new RegExMatcher("(tiny|small|little)", true), new Shrinking()),
  new MatcherAndDrawer(new RegExMatcher("fade.*black"), new Fade(BACK_COLOR, #000000)),
  new MatcherAndDrawer(new RegExMatcher("fade.*gr[ea]y"), new Fade(BACK_COLOR, #7F7F7F)),
  // Only if at start of sentence!
  new MatcherAndDrawer(new RegExMatcher("black.*"), new PlainColor(#000000)),
  new MatcherAndDrawer(new WordInside("white"), new PlainColor(#FFFFFF)),
  new MatcherAndDrawer(new WordInside("blue"), new PlainColor(#0000FF)),
  new MatcherAndDrawer(new WordInside("green"), new PlainColor(#00FF00)),
  new MatcherAndDrawer(new WordInside("red"), new PlainColor(#FF0000)),
  // Only as a separate word, but anywhere in the sentence
  new MatcherAndDrawer(new RegExMatcher("\\bcyan\\b", true), new PlainColor(#00FFFF)),
  new MatcherAndDrawer(new WordInside("magenta"), new PlainColor(#FF00FF)),
  new MatcherAndDrawer(new WordInside("yellow"), new PlainColor(#FFFF00))
};
