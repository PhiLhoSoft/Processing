
PShape africa;
PShape country;
 
void setup() {
  size( 1000, 1000 );
  africa = loadShape( "BlankMap-Africa.svg" );
  smooth();
  noLoop();
}
 
void draw() {
  background( 255 );
  africa.disableStyle();
  fill(128, 255, 200); stroke(0);
  shape( africa, 0, 0 );
  setCountryColour();
//  saveFrame( "africa_population.png" );
}
 
void setCountryColour() {
  country = africa.getChild( "dz" );
  if (country == null ) {
    println( "no country found" );
  }
  else {
    println( "country found ");
    ((PShapeSVG) country).print();
  }
  country.disableStyle();
  fill( 0, 0, 255 );
  noStroke();
  translate(-1721.783, -693.262);
  scale(1.594335, 1.594335);
  shape( country, 0, 0 );
}

