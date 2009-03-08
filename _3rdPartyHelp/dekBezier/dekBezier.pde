// File: bezier.pde
// Interact bezier curve and example of class with member functions and an instance, and mouse interaction.
// Author: David Ethan Kennerly
// Date last modified: 2006-11-20
// http://interactive.usc.edu/members/ekennerly/bezier.pde

// For Processing to be accessible to visual, interactive artists, it needs a visual, interactive interface.
// Programming a curve is counterintuitive and is a missed opportunity to tap the talent of an artist's eye.

int UNDEFINED = -99;

int canvas_width = 320;         int canvas_height = 240;

// Default bezier.
int default_x0 = 50;            int default_y0 = 50;
int default_control_x0 = 100;   int default_control_y0 = 50;
int default_control_x1 = 100;   int default_control_y1 = 200;
int default_x1 = 200;           int default_y1 = 200;

bezier_container_class bezier_container = new bezier_container_class( 16 );
bezier_class default_bezier = new bezier_class( default_x0, default_y0,
     default_control_x0, default_control_y0,
     default_control_x1, default_control_y1,
     default_x1, default_y1 );

void setup() {
   size( canvas_width, canvas_height );

   bezier_container.add( default_bezier );
   println( "Click on a point to move or stop moving that point." );
   println( "Press 'p' to print the bezier parameters." );

}

void draw() {
   background( 63, 63, 63 );
   bezier_container.update();
}


void mouseReleased() {
   bezier_container.mouseReleased();
}

void keyReleased() {
   if ( 'p' == key || 'P' == key ) {
     bezier_container.print();
   }
}



class bezier_class {
   int x0, y0, control_x0, control_y0, control_x1, control_y1, x1, y1;

   bezier_class( int new_x0, int new_y0,
       int new_control_x0, int new_control_y0, int new_control_x1, int new_control_y1,
       int new_x1, int new_y1 ) {
     x0 = new_x0;
     x1 = new_x1;
     y0 = new_y0;
     y1 = new_y1;
     control_x0 = new_control_x0;
     control_x1 = new_control_x1;
     control_y0 = new_control_y0;
     control_y1 = new_control_y1;
   }

   void update() {
     noFill();

     stroke( 127, 127, 127 );
     strokeWeight( 2 );

     line( x0, y0, control_x0, control_y0 );
     ellipse( control_x0, control_y0, 5, 5 );

     line( x1, y1, control_x1, control_y1 );
     ellipse( control_x1, control_y1, 5, 5 );

     stroke( 255, 255, 255 );
     strokeWeight( 5 );

     bezier( x0, y0, control_x0, control_y0, control_x1, control_y1, x1, y1 );

   }
   void print() {
     // Print the function parameters being displayed.
     println( "bezier( " + x0 + ", " + y0 + ", "
       + control_x0 + ", " + control_y0 + ", "
       + control_x1 + ", " + control_y1 + ", "
       + x1 + ", " + y1  + " );" );
   }
}


class bezier_container_class {
   int count = 0;
   int max_count = 10;
   bezier_class[] bezier_array = new bezier_class[ max_count ];
   int select_radius = 20;

   int SELECT_STATE = 0;
   int MOVE_0_STATE = 1;
   int MOVE_1_STATE = 2;
   int MOVE_CONTROL_0_STATE = 3;
   int MOVE_CONTROL_1_STATE = 4;

   int state = SELECT_STATE;
   bezier_class active_bezier = null;

   bezier_container_class( int new_max_count ) {
     count = 0;
     max_count = new_max_count;
     bezier_class[] bezier_array = new bezier_class[ max_count ];
   }

   void add( bezier_class new_bezier ) {
     bezier_array[ count ] = new_bezier;
     count ++;
   }

   void print() {
     for ( int index = 0; index < count; index ++ ) {
       bezier_array[ index ].print();
     }
   }

   void update() {
     for ( int index = 0; index < count; index ++ ) {
       bezier_array[ index ].update();

       if ( null != active_bezier ) {
         if ( MOVE_0_STATE == state ) {
           active_bezier.x0 = (int)mouseX;
           active_bezier.y0 = (int)mouseY;
         }
         else if ( MOVE_1_STATE == state ) {
           active_bezier.x1 = (int)mouseX;
           active_bezier.y1 = (int)mouseY;
         }
         else if ( MOVE_CONTROL_0_STATE == state ) {
           active_bezier.control_x0 = (int)mouseX;
           active_bezier.control_y0 = (int)mouseY;
         }
         else if ( MOVE_CONTROL_1_STATE == state ) {
           active_bezier.control_x1 = (int)mouseX;
           active_bezier.control_y1 = (int)mouseY;
         }
       }
     }
   }

   void mouseReleased() {
     // println( "bezier_container_class: mouseReleased" + mouseX + ", "  + mouseY );

     if ( SELECT_STATE == state ) {
       for ( int index = 0; index < count; index ++ ) {
         // println( "index" + index );
         bezier_class bez = bezier_array[ index ];
         if ( select_radius >= dist( bez.x0, bez.y0, mouseX, mouseY ) ) {
           state = MOVE_0_STATE;
           active_bezier = bez;
           // println( "bez selected" );
         }
         else if ( select_radius >= dist( bez.x1, bez.y1, mouseX, mouseY ) ) {
           state = MOVE_1_STATE;
           active_bezier = bez;
           // println( "bez selected" );
         }
         else if ( select_radius >= dist( bez.control_x0, bez.control_y0, mouseX, mouseY ) ) {
           state = MOVE_CONTROL_0_STATE;
           active_bezier = bez;
           // println( "bez selected" );
         }
         else if ( select_radius >= dist( bez.control_x1, bez.control_y1, mouseX, mouseY ) ) {
           state = MOVE_CONTROL_1_STATE;
           active_bezier = bez;
           // println( "bez selected" );
         }
       }
     }
     else if ( MOVE_0_STATE == state ) {
       if ( 0 < mouseX && mouseX < canvas_width
       && 0 < mouseY && mouseY < canvas_height ) {
         active_bezier.x0 = (int)mouseX;
         active_bezier.y0 = (int)mouseY;

         state = SELECT_STATE;
         active_bezier = null;
       }
     }
     else if ( MOVE_1_STATE == state ) {
       if ( 0 < mouseX && mouseX < canvas_width
       && 0 < mouseY && mouseY < canvas_height ) {
         active_bezier.x1 = (int)mouseX;
         active_bezier.y1 = (int)mouseY;

         state = SELECT_STATE;
         active_bezier = null;
       }
     }
     else if ( MOVE_CONTROL_0_STATE == state ) {
       if ( 0 < mouseX && mouseX < canvas_width
       && 0 < mouseY && mouseY < canvas_height ) {
         active_bezier.control_x0 = (int)mouseX;
         active_bezier.control_y0 = (int)mouseY;

         state = SELECT_STATE;
         active_bezier = null;
       }
     }
     else if ( MOVE_CONTROL_1_STATE == state ) {
       if ( 0 < mouseX && mouseX < canvas_width
       && 0 < mouseY && mouseY < canvas_height ) {
         active_bezier.control_x1 = (int)mouseX;
         active_bezier.control_y1 = (int)mouseY;

         state = SELECT_STATE;
         active_bezier = null;
       }
     }
   }
}
