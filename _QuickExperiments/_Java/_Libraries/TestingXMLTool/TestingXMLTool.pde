// http://code.google.com/p/xmltool/
import com.mycila.xmltool.*;

// https://forum.processing.org/topic/manipulate-xml-data-in-processing-with-proxml
println("\n=== XML Creation 1\n");

XMLTag tag1 = XMLDoc.newDocument(true)
    .addRoot("html")
    .addTag("head").addText("one")
    .gotoChild("head")
    .addTag("title").addText("my title 1")
    .addTag("title").addText("my title 2")
    .addText("")

    .addTag("body")
    .addTag("number").addAttribute("type", "hexa").addText("0xCAFEBABE")
    .addText("two")
    .gotoChild("body")
    .addTag("bool").addText("true")
    .gotoRoot();
println(tag1.toString());

println("\n=== XML Creation 2\n");

XMLTag tag2 = XMLDoc.newDocument(false)
    .addDefaultNamespace("http://www.w3.org/2002/06/xhtml2/")
    .addNamespace("w", "http://wicket.sourceforge.net/wicket-1.0")
    .addRoot("html")
    .addTag("w:border").addText("one and...")
    .gotoChild(1).addText(" two !")
    .gotoParent().addTag("head")
    .addTag("title")
    .addAttribute("w:id", "title")
    .addText("This is my title with special characters: <\"!@#$%'^&*()>")
    .gotoParent()
    .addTag("body").addCDATA("Some data...")
    .gotoTag("ns0:body").addTag("child")
    .gotoParent().addCDATA("with special characters")
    .gotoTag("ns0:body").addCDATA("<\"!@#$%'^&*()>");
println(tag2.toString());

println("\n=== XML Creation 3\n");
// https://forum.processing.org/topic/manipulate-xml-data-in-processing-with-proxml

XMLTag tag3 = XMLDoc.newDocument(true)
    .addRoot("emails")
    .addTag("email")
    .addTag("date").addText("238129038")
    .addTag("from")
      .addAttribute("name", "Doeke Wartena").addAttribute("email", "ck@gmail.com")
    .gotoParent().addTag("to")
      .addTag("person")
        .addAttribute("name", "Doeke Wartena").addAttribute("email", "ck@gmail.com")
      .gotoParent().addTag("person")
        .addAttribute("name", "Fons Hofhui").addAttribute("email", "fh@gmail.com")
    .gotoRoot().gotoTag("email").addTag("content")
      .addText("efdsfdsfds")
    .gotoRoot().gotoTag("email").addTag("questions")
      .addTag("q").addText("hoe laat?")
      .addTag("q").addText("wanneer?");
println(tag3.toString());

println("\n=== Changing a SVG file\n");

XMLTag doc = XMLDoc.from(new File("H:/Temp/Test.svg"), false);
for (XMLTag tag : doc.getChilds())
{
  if (tag.getCurrentTagName().equals("g"))
  {
    if (tag.hasAttribute("transform"))
    {
      tag.deleteAttribute("transform");
    }
  }
}
println(doc.toString());

exit();

