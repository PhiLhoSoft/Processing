class BreakCircle {
  ArrayList <Polygon2D> polygons = new ArrayList <Polygon2D> ();
  Voronoi voronoi;
  FloatRange xpos, ypos;
  PolygonClipper2D clip;
  float[] moveSpeeds;
  Vec2D pos, impact;
  float radius;
  int transparency;
  int start;
  VerletParticle2D vp;
  AttractionBehavior abh;
  boolean broken;

  BreakCircle(Vec2D pos, float radius) {
    this.pos = pos;
    this.radius = radius;
    vp = new VerletParticle2D(pos);
    abh = new AttractionBehavior(vp, radius*2.5 + max(0,50-radius), -1.2f, 0.01f);
    physics.addParticle(vp);
    physics.addBehavior(abh);
  }

  void run() {
    // for regular (not broken) circles
    if (!broken) {
      moveVerlet();
      displayVerlet();
      checkBreak();
    // if the circle is broken
    } else {
      moveBreak();
      displayBreak();
    }
  }

  // set position based on the particle in the physics system
  void moveVerlet() {
    pos = vp;
  }

  // display circle
  void displayVerlet() {
    fill(255);
    gfx.circle(pos,radius*2);
  }

  // if the mouse is pressed on a circle, it will be broken
  void checkBreak() {
    if (mouse.isInCircle(pos,radius) && mousePressed) {
      // remove particle + behavior in the physics system
      physics.removeParticle(vp);
      physics.removeBehavior(abh);
      // point of impact is set to mouseX,mouseY
      impact = mouse;
      initiateBreak();
    }
  }

  void initiateBreak() {
    broken = true;
    transparency = 255;
    start = frameCount;
    // create a voronoi shape
    voronoi = new Voronoi();
    // set biased float ranges based on circle position, radius and point of impact
    xpos = new BiasedFloatRange(pos.x-radius, pos.x+radius, impact.x, 0.333f);
    ypos = new BiasedFloatRange(pos.y-radius, pos.y+radius, impact.y, 0.5f);
    // set clipping based on circle position and radius
    clip = new SutherlandHodgemanClipper(new Rect(pos.x-radius, pos.y-radius, radius*2, radius*2));
    addPolygons();
    addSpeeds();
  }

  void addPolygons() {
    // add random points (biased towards point of impact) to the voronoi
    for (int i=0; i<numPoints; i++) {
      voronoi.addPoint(new Vec2D(xpos.pickRandom(), ypos.pickRandom()));
    }
    // generate polygons from voronoi segments
    for (Polygon2D poly : voronoi.getRegions()) {
      // clip them based on the rectangular clipping
      poly = clip.clipPolygon(poly);
      for (Vec2D v : poly.vertices) {
        // if a point is outside the circle
        if (!v.isInCircle(pos,radius)) {
          // scale it's distance from the center to the radius
          clipPoint(v);
        }
      }
      polygons.add(new Polygon2D(poly.vertices));
    }
  }

  void addSpeeds() {
    // generate random speeds for all polygons
    moveSpeeds = new float[polygons.size()];
    for (int i=0; i<moveSpeeds.length; i++) {
      moveSpeeds[i] = random(minSpeed,maxSpeed);
    }
  }

  // move polygons away from the point of impact at their respective speeds
  void moveBreak() {
    for (int i=0; i<polygons.size(); i++) {
      Polygon2D poly = polygons.get(i);
      Vec2D centroid = poly.getCentroid();
      Vec2D targetDir = centroid.sub(impact).normalize();
      targetDir.scaleSelf(moveSpeeds[i]);
      for (Vec2D v : poly.vertices) {
        v.set(v.addSelf(targetDir));
      }
    }
  }

  // draw the polygons
  void displayBreak() {
    // after 12 frames, start decreasing the transparency
    if (frameCount-start > 12) { transparency -= 7; }
    fill(255,transparency);
    for (Polygon2D poly : polygons) {
      gfx.polygon2D(poly);
    }
  }

  void clipPoint(Vec2D v) {
    v.subSelf(pos);
    v.normalize();
    v.scaleSelf(radius);
    v.addSelf(pos);
  }
}

