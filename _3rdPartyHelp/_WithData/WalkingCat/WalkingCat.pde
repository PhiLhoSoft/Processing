animal meow;
PImage outside, house, back, cat;

void setup()
{
 size(200, 150);

 outside = loadImage( "outside.png" );
 house = loadImage( "house.png" );
 cat = loadImage( "kitty.png" );
 back = outside;

 meow = new animal(cat, 0);

 frameRate(10);
}

void draw()
{
 background(255);
 meow.update();
 meow.draw();
}




class animal
{
 PImage img;
 int imgCol, imgRow, //animation, direction
     currentX, targetX, patience;

 animal (PImage img, int x)
 {
   this.img = img;
   currentX = x;
   patience = 1;
 }

 void update()
 {
   patience--;
   if ( patience == 0)
   {
     patience = int ( random(80, 110));
     targetX = int ( random(-65, 305));
     imgCol=30;
   }
   walk();
 }

 void draw()
 {
   image(back, -currentX, 10);
   PImage curCat = cat.get(imgCol, imgRow, 30, 30);
   image(curCat, 65, 95, 30, 30);
 }

 void walk()
 {
   imgCol = -imgCol + 30;

   if ( targetX < currentX )
   {
     currentX--;
     imgRow = 30;
   }
   else if ( targetX > currentX )
   {
     currentX++;
     imgRow = 0;
   }
   else
     imgCol = 60;
//   println(imgCol);
 }
}

