import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
 
import org.w3c.dom.*;
 
void setup()
{
  createXMLFile(sketchPath("Test.xml"), false);
  println("Done");
  exit();
}
 
void createXMLFile(String fileName, boolean validating)
{
  try
  {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    factory.setNamespaceAware(true);
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document document = builder.newDocument();
 
    Element root = document.createElementNS("http://example.com", "root");
    document.appendChild(root);
    Attr rootAttribute = document.createAttributeNS("http://example.com", "attribute");
    rootAttribute.setValue("value");
    root.setAttributeNodeNS(rootAttribute);
 
    Element child1 = document.createElement("one-child");
    child1.setTextContent("Content of one child");
    root.appendChild(child1);
 
    // Don't re-use Element!
    Element child2 = document.createElement("one-child");
    child2.setTextContent("Another content\nof one child");
    Attr childAttr = document.createAttribute("a");
    childAttr.setValue("Fooo");
    child2.setAttributeNode(childAttr);
    root.appendChild(child2);
 
    Element child3 = document.createElement("other-child");
    Attr childParam1 = document.createAttribute("param");
    childParam1.setValue("Empty tag");
    child3.setAttributeNode(childParam1);
    root.appendChild(child3);
 
    Element child4 = document.createElement("other-child");
    child4.setTextContent("Content of the other child");
    Attr childParam2 = document.createAttribute("param");
    childParam2.setValue("Some value");
    child4.setAttributeNode(childParam2);
    root.appendChild(child4);
 
    DOMSource source = new DOMSource(document);
    PrintStream ps = new PrintStream(fileName);
    StreamResult res = new StreamResult(ps);
 
    TransformerFactory tf = TransformerFactory.newInstance();
    Transformer transf = tf.newTransformer();
 
    // Output the generated XML
    transf.transform(source, res);
  }
  catch (ParserConfigurationException e)
  {
    println("Error: " + e);
  }
  catch (TransformerConfigurationException e)
  {
    println("Error: " + e);
  }
  catch (TransformerException e)
  {
    println("Error: " + e);
  }
  catch (IOException e)
  {
    println("Cannot write file " + fileName);
  }
}

