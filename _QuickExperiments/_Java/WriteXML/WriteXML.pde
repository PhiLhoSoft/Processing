import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import javax.xml.stream.*;

import org.w3c.dom.*;

final String NAMESPACE = "http://www.daisy.org/z3986/2005/ncx/";
final String NAMESPACE2 = "http://www.example.com/";

void setup()
{
  createXMLFile1(sketchPath("Test1.xml"), false);
  createXMLFile1(sketchPath("Test2.xml"), true);
  createXMLFile2(sketchPath("Test3.xml"));
  println("Done");
  exit();
}

void createXMLFile1(String fileName, boolean bUseNamespace)
{
  try
  {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//~     factory.setNamespaceAware(bUseNamespace);
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document document = builder.newDocument();
    if (bUseNamespace)
    {
//~       DOMImplementation di = builder.getDOMImplementation();
      DOMImplementation di = document.getImplementation();
      DocumentType doctype = di.createDocumentType(
          "root", // Qualified name
          "-//NISO//DTD xml 2005-1//EN", // publicId
          "http://www.daisy.org/z3986/2005/ncx-2005-1.dtd" // systemId
      );

//~       document = di.createDocument(
//~           NAMESPACE, // Namespace URI
//~           "root", // Qualified name
//~           doctype // Document type
//~       );
      document.appendChild(doctype);
    }
    Element root = null;
    /*
    if (bUseNamespace)
    {
//~       root = document.createElementNS(NAMESPACE, "root");
//~       root = document.getDocumentElement();
      root = (Element) document.getChildNodes().item(1);
    }
    else
    */
    {
      root = document.createElement("root");
      document.appendChild(root);
    }
    Attr rootAttribute = null;
    if (bUseNamespace)
    {
      rootAttribute = document.createAttributeNS(NAMESPACE2, "attribute");
    }
    else
    {
      rootAttribute = document.createAttribute("attribute");
    }
    rootAttribute.setValue("value");
    if (bUseNamespace)
    {
      root.setAttributeNodeNS(rootAttribute);
    }
    else
    {
      root.setAttributeNode(rootAttribute);
    }

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
    child3.setAttribute("param", "Empty tag");
    root.appendChild(child3);

    Element child4 = document.createElement("other-child");
    child4.setTextContent("Content of the other child");
    child4.setAttribute("param", "Some value");
    root.appendChild(child4);

    Attr otherAttribute = null;
    if (bUseNamespace)
    {
      otherAttribute = document.createAttributeNS(NAMESPACE2, "attrNS");
    }
    else
    {
      otherAttribute = document.createAttribute("attrNoNS");
    }
    otherAttribute.setValue("Yo Man!");
    child4.setAttributeNode(otherAttribute);

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

void createXMLFile2(String fileName)
{
  XMLOutputFactory xof =  XMLOutputFactory.newInstance();
  XMLStreamWriter xtw = null;
  try
  {
    xtw = xof.createXMLStreamWriter(new FileOutputStream(fileName), "UTF-8");
    xtw.writeStartDocument("UTF-8", "1.0");
    xtw.writeStartElement("root");
    xtw.writeComment("This is an attempt to create an XML file with StAX");

    xtw.writeStartElement("foo");
    xtw.writeAttribute("order", "1");
      xtw.writeStartElement("meuh");
      xtw.writeAttribute("active", "true");
        xtw.writeCharacters("The cows are flying high this Spring");
      xtw.writeEndElement();
    xtw.writeEndElement();

    xtw.writeEmptyElement("separator");

    xtw.writeStartElement("bar");
    xtw.writeAttribute("order", "2");
      xtw.writeStartElement("tcho");
      xtw.writeAttribute("kola", "K");
        xtw.writeCharacters("Content of tcho tag");
      xtw.writeEndElement();
    xtw.writeEndElement();

    xtw.writeEndElement();
    xtw.writeEndDocument();
  }
  catch (XMLStreamException e)
  {
    e.printStackTrace();
  }
  catch (IOException ie)
  {
    ie.printStackTrace();
  }
  finally
  {
    if (xtw != null)
    {
      try
      {
        xtw.close();
      }
      catch (XMLStreamException e)
      {
        e.printStackTrace();
      }
    }
  }
}

