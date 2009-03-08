import processing.video.*;

final int CANVAS_WIDTH  = 720;
final int CANVAS_HEIGHT = 480;
//~ final int MAX_FRAME_NB  = 720;
final int MAX_FRAME_NB  = 120;

final color START_COLOR_TOP    = #335533;
final color START_COLOR_BOTTOM = #55AA55;
final color END_COLOR_TOP      = #333355;
final color END_COLOR_BOTTOM   = #5555AA;

int xA, yA, xB = CANVAS_WIDTH / 4, yB = CANVAS_HEIGHT / 4;

MovieMaker mm;

color InterpolateColor(color startC, color endC)
{
	return lerpColor(startC, endC, (float)frameCount / (float)MAX_FRAME_NB);
}

void DrawBackground()
{
	color topColor = InterpolateColor(START_COLOR_TOP, END_COLOR_TOP);
	color bottomColor = InterpolateColor(START_COLOR_BOTTOM, END_COLOR_BOTTOM);
	for (int l = 0; l < CANVAS_HEIGHT; l++)
	{
		color sc = lerpColor(topColor, bottomColor, (float)l / (float)CANVAS_HEIGHT);
		stroke(sc);
		line(0, l, CANVAS_WIDTH - 1, l);
	}
}

void setup()
{
	smooth();
	frameRate(24);
	size(CANVAS_WIDTH, CANVAS_HEIGHT);

	mm = new MovieMaker(this, width, height, "Test-H264.mov", 24,
			MovieMaker.ANIMATION, MovieMaker.BEST);
}
// Tested with Apple QuickTime 7 for Windows (XP SP2)
// ANIMATION: perfect - 1,800KB
// BASE: empty! - 0
// BMP: perfect, enormous! - 121,500KB
// CINEPAK: Lot of artifacts on background, trail - 1,600KB
// COMPONENT: Little artifacts on background, big! - 81,000KB
// CMYK: empty! - 0
// GIF: empty! - 0
// GRAPHICS: Dithering - 16,600KB
// JPEG: Good quality, reasonable size - 2,500KB
// MS_VIDEO: empty! - 0
// MOTION_JPEG_A: Good quality, reasonable size - 3,200KB
// MOTION_JPEG_B: Good quality, reasonable size - 3,200KB
// RAW: perfect, enormous! - 162,000KB
// SORENSON: Little artifacts on background, small - 780KB
// VIDEO: Small palette (blocky gradient), trails - 470KB
// H261: Lot of artifacts on background - 460KB
// H263: Lot of artifacts on background - 330KB
// H264: Sketch fails (exception quicktime.std.StdQTException[QTJava:7.4.5g],-8960=codecErr,QT.vers:7458000) after writing 120KB

void draw()
{
	if (frameCount > MAX_FRAME_NB)
	{
		mm.finish();
		delay(1000);
		exit();
	}

	DrawBackground();
	fill(#88FFFF);
	ellipse(xA++ * 4, yA++ * 4, 20, 20);
	fill(#88AAFF);
	ellipse(xB-- * 4, yB-- * 4, 20, 20);
	fill(#88FFAA);
	ellipse(xA * 4, yB * 4, 20, 20);
	fill(#88AAAA);
	ellipse(xB * 4, yA * 4, 20, 20);

	fill(#8888AA);
	ellipse(xA * 4 + MAX_FRAME_NB, yA * 4, 20, 20);
	fill(#88AA88);
	ellipse(xB * 4 - MAX_FRAME_NB, yB * 4, 20, 20);
	fill(#8888AA);
	ellipse(xA * 4 + MAX_FRAME_NB, yB * 4, 20, 20);
	fill(#888888);
	ellipse(xB * 4 - MAX_FRAME_NB, yA * 4, 20, 20);

	mm.addFrame();
}
