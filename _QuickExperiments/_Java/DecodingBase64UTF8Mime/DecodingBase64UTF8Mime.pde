String s1 = "=?UTF-8?B?Tm93IFRocm91Z2ggUHJlc2lkZW50c+KAmSBEYXk6IEVHR1hlY3V0?=";
String s2 = "=?UTF-8?B?aXZlIFNhdmluZ3Mgb24gQ29tcG9uZW50cywgRWxlY3Ryb25pY3MgJiBNb3Jl?=";
String s3 = "=?UTF-8?B?IQ==?=";

void setup()
{
  println(decode(s1));
  println(decode(s2));
  println(decode(s3));
  exit();
}

String decode(String s)
{
  String eu = s.substring(10);
  byte[] ba = javax.xml.bind.DatatypeConverter.parseBase64Binary(eu);
  try
  { 
    return new String(ba, "UTF-8");
  }
  catch (UnsupportedEncodingException e)
  {
    println(e);
  }
  return null; // Only if we had the exception, which shouldn't happen if you don't change the encoding...
}


