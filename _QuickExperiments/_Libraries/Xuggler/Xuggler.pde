// Based on rbrauer's code: http://forum.processing.org/one/topic/sketch-video-catpure-with-ffmpeg-and-xuggle.html

import com.xuggle.xuggler.*;
import com.xuggle.mediatool.*;

import java.awt.image.BufferedImage;
import java.util.concurrent.TimeUnit;

IMediaWriter mediaWriter;
IStreamCoder streamCoder;
BufferedImage bufferedImage;
int videoRate = 30;
long startTime;
long frameTime;

void setup()
{
  size(1024, 768);

  ellipseMode(CENTER);

  mediaWriter = ToolFactory.makeWriter(sketchPath("output.mp4"));
  mediaWriter.addVideoStream(0, 0,
      ICodec.ID.CODEC_ID_MPEG4,
      IRational.make(videoRate),
      width, height);
  streamCoder = mediaWriter.getContainer().getStream(0).getStreamCoder();

  bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
  startTime = frameTime = System.nanoTime();
}

void draw()
{
   background(sin(frameCount / 25f) * 255);
   ellipse(mouseX, mouseY, 100, 100);
   loadPixels();

   long currentTime = System.nanoTime() - frameTime;
   if (currentTime >= 1000.0 / videoRate)
   {
    bufferedImage.getGraphics().drawImage(g.getImage(), 0, 0, null);
    mediaWriter.encodeVideo(0, bufferedImage, System.nanoTime() - startTime, TimeUnit.NANOSECONDS);
    frameTime = System.nanoTime();
  }
}

void mouseClicked()
{
  mediaWriter.close();
  exit();
}

