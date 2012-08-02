// https://forum.processing.org/topic/using-an-application-written-in-processing-to-open-up-a-file
// Based on http://wiki.processing.org/w/Setting_width/height_dynamically

// Static to be accessed by main()
static String[] newArgs;

// Overload the PApplet's main
public static void main(String args[])
{
  newArgs = new String[args.length+1];
  
  // Trick found at http://stackoverflow.com/questions/41894/0-program-name-in-java-discover-main-class
  StackTraceElement[] stack = Thread.currentThread ().getStackTrace();
  StackTraceElement main = stack[stack.length - 1];
  String mainClass = main.getClassName();

  // PApplet wants the name of the class as first argument
  newArgs[0] = mainClass;
  // Copy the remainder of the parameters given on the command line
  arrayCopy(args, 0, newArgs, 1, args.length);
  // Call the original PApplet main with the build arguments
  PApplet.main(newArgs);
}

void setup()
{
  size(400, 400);
  background(255);
  fill(0);
  // Now we can access the global array
  println(newArgs.length);
  for (int i = 0; i < newArgs.length; i++)
  {
    text(newArgs[i], 10, 15 * i + 20);
  }
}

