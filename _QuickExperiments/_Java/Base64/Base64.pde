import javax.xml.bind.DatatypeConverter;

void setup()
{
  String b64 = DatatypeConverter.printBase64Binary("Java has well hidden resources!".getBytes());
  println(b64);
  byte[] origB = DatatypeConverter.parseBase64Binary(b64);
  String orig = new String(origB);
  println(orig);
  exit();
}

