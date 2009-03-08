// Based on http://www.processing.org/hacks/hacks:gpx
import tomc.gpx.*;

GPX gpx;
// I limit the sketch to one track with one segment...
// Just taking the first ones if there are several
// So I don't use here gpx.getTrackCount() nor track.size()
GPXTrack track;
GPXTrackSeg trackSeg;
String trackName;

double minLat, maxLat;
double minLon, maxLon;
double minEle, maxEle;

final static int SEPARATOR = 200;

void setup()
{
  size(500, 700);
  gpx = new GPX(this);
  // Load GPX file in data folder
  gpx.parse("route-Dolomieten.gpx"); // or a URL
  track = gpx.getTrack(0);
  trackName = track.name;
  trackSeg = track.getTrackSeg(0);

  // Find scope of segement
  minLat = 100; minLon = 200; minEle = 50000;
  for (int i = 0; i < trackSeg.size(); i++)
  {
    GPXPoint pt = trackSeg.getPoint(i);
    if (pt.lat < minLat)
    {
      minLat = pt.lat;
    }
    if (pt.lon < minLon)
    {
      minLon = pt.lon;
    }
    if (pt.ele < minEle)
    {
      minEle = pt.ele;
    }

    if (pt.lat > maxLat)
    {
      maxLat = pt.lat;
    }
    if (pt.lon > maxLon)
    {
      maxLon = pt.lon;
    }
    if (pt.ele > maxEle)
    {
      maxEle = pt.ele;
    }
  }
println("Lat: " + minLat + " to " + maxLat);
println("Lon: " + minLon + " to " + maxLon);
println("Ele: " + minEle + " to " + maxEle);
}

void draw()
{
  background(255);
  stroke(#FF0000);
  line(0, SEPARATOR, width, SEPARATOR);

  double distance = 0;
  GPXPoint prevPt = trackSeg.getPoint(0);
  PVector prevEle = GetElevation(0, prevPt);
  PVector prevPos = GetPosition(prevPt);
  for (int i = 1; i < trackSeg.size(); i++)
  {
    GPXPoint pt = trackSeg.getPoint(i);

    // Show altitude
    // I should compute the real distance in kilometers between two geo points
    // probably using Vincenty's formulae <http://en.wikipedia.org/wiki/Vincenty%27s_formulae>
    // Here I just use mean distance between points
    PVector ele = GetElevation(i, pt);
    stroke(#0000AA);
    line(prevEle.x, prevEle.y, ele.x, ele.y);
    prevEle = ele;

    // Show track
    PVector pos = GetPosition(pt);
    stroke(#008888);
    line(prevPos.x, prevPos.y, pos.x, pos.y);
    prevPos = pos;
  }
}

PVector GetElevation(int n, GPXPoint pt)
{
  return new PVector(
      map(n, 0, trackSeg.size(), 10, width - 10),
      map((float) pt.ele, (float) minEle, (float) maxEle, SEPARATOR - 10, 10)
  );
}

PVector GetPosition(GPXPoint pt)
{
  return new PVector(
      map((float) pt.lon, (float) minLon, (float) maxLon, 10, width - 10),
      map((float) pt.lat, (float) minLat, (float) maxLat, height - 10, SEPARATOR + 10)
  );
}

