import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import javax.script.Invocable;

ScriptEngine jsEngine;

final String FUNC = "Math.sin(x) + Math.cos(x)";
final String FUNCTION = "function compute(x) { return " + FUNC + "; }";

final String OBJ = "var obj = new Object(); obj.compute = function (x) { return " + FUNC + "; }";
Object method;

final int TEST_NB = 6;

void setup()
{
  size(500, 500);
  background(255);
  strokeWeight(3);

  ScriptEngineManager mgr = new ScriptEngineManager();
  jsEngine = mgr.getEngineByName("JavaScript");


  long t1 = System.currentTimeMillis();
  stroke(#FF0000);
  for (int x = 0; x < width; x++)
  {
    double y = getYEval(x / TWO_PI);
    point((float) x, (float) (1 * height / TEST_NB + y * height / 16));
  }
  println("Eval: " + (System.currentTimeMillis() - t1));


  t1 = System.currentTimeMillis();
  eval(FUNCTION);
  stroke(#0000FF);
  for (int x = 0; x < width; x++)
  {
    double y = getYInvokeF(x / TWO_PI);
    point((float) x, (float) (2 * height / TEST_NB + y * height / 16));
  }
  println("Invoke function: " + (System.currentTimeMillis() - t1));


  t1 = System.currentTimeMillis();
  eval(OBJ);
  method = jsEngine.get("obj");
  stroke(#00FF00);
  for (int x = 0; x < width; x++)
  {
    double y = getYInvokeM(x / TWO_PI);
    point((float) x, (float) (3 * height / TEST_NB + y * height / 16));
  }
  println("Invoke method: " + (System.currentTimeMillis() - t1));


  t1 = System.currentTimeMillis();
  stroke(#FFFF00);
  eval(
    "var a = java.lang.reflect.Array.newInstance(java.lang.Double, " + width + ");\n" +
    "for (var i = 0; i < a.length; i++) { var x = i / 6.28; a[i] = " + FUNC + "; }"
  );
  Double[] r1 = (Double[]) jsEngine.get("a");
//  println(r);
  for (int x = 0; x < width; x++)
  {
    double y = r1[x];
    point((float) x, (float) (4 * height / TEST_NB + y * height / 16));
  }
  println("Function with one array: " + (System.currentTimeMillis() - t1));


  t1 = System.currentTimeMillis();
  stroke(#FF00FF);
  double[] data = new double[width];
  for (int x = 0; x < width; x++)
  {
    data[x] = x / TWO_PI; // Can be more arbitrary
  }
  jsEngine.put("data", data);
  eval(
    "var a = java.lang.reflect.Array.newInstance(java.lang.Double, " + width + ");\n" +
    "for (var i = 0; i < a.length; i++) { var x = data[i]; a[i] = " + FUNC + "; }"
  );
  Double[] r2 = (Double[]) jsEngine.get("a");
//  println(r);
  for (int x = 0; x < width; x++)
  {
    double y = r2[x];
    point((float) x, (float) (5 * height / TEST_NB + y * height / 16));
  }
  println("Function with two arrays: " + (System.currentTimeMillis() - t1));
}


double getYEval(double x)
{
  try
  {
    String expr = "var x = " + x + "; " + FUNC;
    return ((Double) jsEngine.eval(expr)).doubleValue();
  }
  catch (ScriptException ex)
  {
    ex.printStackTrace();
  }
  return 0;
}

double getYInvokeF(double x)
{
  try
  {
    return ((Double) ((Invocable) jsEngine).invokeFunction("compute", Double.valueOf(x))).doubleValue();
  }
  catch (ScriptException se)
  {
    se.printStackTrace();
  }
  catch (NoSuchMethodException nsme)
  {
    nsme.printStackTrace();
  }
  return 0;
}

double getYInvokeM(double x)
{
  try
  {
    return ((Double) ((Invocable) jsEngine).invokeMethod(method, "compute", Double.valueOf(x))).doubleValue();
  }
  catch (ScriptException se)
  {
    se.printStackTrace();
  }
  catch (NoSuchMethodException nsme)
  {
    nsme.printStackTrace();
  }
  return 0;
}

Object eval(String toEval)
{
  try
  {
    return jsEngine.eval(toEval);
  }
  catch (ScriptException se)
  {
    se.printStackTrace();
  }
  return null;
}

