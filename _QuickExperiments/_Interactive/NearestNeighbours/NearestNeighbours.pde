// Displays big and small circles.
// If big ones are hovered, it shows the n closest small points around it.

int PLAIN_NODE_NB = 100;
int PLAIN_NODE_RADIUS = 8;
int MASTER_NODE_NB = 7;
int MASTER_NODE_RADIUS = 16;
int NEIGHT_NB = 5;

Node[] nodes = new Node[PLAIN_NODE_NB];
MasterNode[] masterNodes = new MasterNode[MASTER_NODE_NB];

void setup()
{
  size(800, 800);
  smooth();

  for (int i = 0; i < PLAIN_NODE_NB; i++)
  {
    nodes[i] = new Node(
        random(PLAIN_NODE_RADIUS, width - PLAIN_NODE_RADIUS),
        random(PLAIN_NODE_RADIUS, height - PLAIN_NODE_RADIUS));
  }
  for (int i = 0; i < MASTER_NODE_NB; i++)
  {
    masterNodes[i] = new MasterNode(
        random(MASTER_NODE_RADIUS, width - MASTER_NODE_RADIUS),
        random(MASTER_NODE_RADIUS, height - MASTER_NODE_RADIUS));
  }
}

void draw()
{
  background(#DDFFEE);
  for (int i = 0; i < PLAIN_NODE_NB; i++)
  {
    nodes[i].Display();
  }
  for (int i = 0; i < MASTER_NODE_NB; i++)
  {
    masterNodes[i].Display();
  }
}

void mouseMoved()
{
  for (int i = 0; i < MASTER_NODE_NB; i++)
  {
    masterNodes[i].HandleMouse();
  }
}

// A node, a simple circle with position, radius, color (normal and highlighted) and state.
class Node
{
  float posX, posY;
  float radius = PLAIN_NODE_RADIUS;
  // Fill and stroke colors
  color fColor = #FFFF00, sColor = #0000FF;
  // Highlighted colors
  color hfColor = #FFFFFF, hsColor = #5555FF;
  boolean bHighlighted;

  Node(float px, float py)
  {
    posX = px; posY = py;
  }

  void Display()
  {
    if (!bHighlighted)
    {
      fill(fColor);
      stroke(sColor);
    }
    else
    {
      fill(hfColor);
      stroke(hsColor);
    }
    ellipse(posX, posY, radius, radius);
  }

  void Highlight(boolean bLight)
  {
    bHighlighted = bLight;
  }

  public String toString()
  {
    return "N[" + int(posX) + ", " + int(posY) + "]";
  }
}

// A master node, they check what are the closest plain nodes around them
// and highlight them when hovered.
class MasterNode extends Node
{
  // The list of closest neighbour nodes
  NeighbourNodes neighNodes = new NeighbourNodes();

  MasterNode(float px, float py)
  {
    super(px, py);
    radius = MASTER_NODE_RADIUS;
    fColor = #00FF00; sColor = #0080FF;
    hfColor = #55FFEE; hsColor = #5080FF;
    CheckDistances();
  }

  // Handle hovering
  void HandleMouse()
  {
    if (dist(posX, posY, mouseX, mouseY) <= radius/2)
    {
      // Hovered: highlight the closest nodes
      bHighlighted = true;
      neighNodes.Highlight(true);
    }
    else
    {
      if (bHighlighted)
      {
        // Was hovered but no longer: remove the highlighting
        bHighlighted = false;
        neighNodes.Highlight(false);
      }
    }
  }

  void Display()
  {
    // Display as a simple node
    super.Display();
    // But if highlighted, also display connections to the nearest nodes
    if (bHighlighted)
    {
      neighNodes.Connect(this);
    }
  }

  // Build the list of closest neighbours
  void CheckDistances()
  {
    // For each plain node
    for (int i = 0; i < PLAIN_NODE_NB; i++)
    {
      Node n = nodes[i];
      // Check if closer than the previous checked one and if so, replace the farthest
      neighNodes.CheckDist(dist(posX, posY, n.posX, n.posY), n);
    }
    println(this + "\n");
  }

  public String toString()
  {
    return "M" + super.toString() + "[" + neighNodes + "]";
  }
}

class NeighbourNodes
{
  // Define a neighbour node: distance to master node and reference to the plain node
  class NeighbourNode
  {
    float dist;
    Node node;

    NeighbourNode()
    {
      // Initialize with the biggest distance we can have
      dist = Float.MAX_VALUE;
    }
    NeighbourNode(float d, Node n)
    {
      dist = d;
      node = n;
    }

    public String toString()
    {
      return "NN[" + int(dist) + ", " + node + "]";
    }
  }
  LinkedList neighbours = new LinkedList();

  NeighbourNodes()
  {
    // Initialize with empty far nodes
    for (int i = 0; i < NEIGHT_NB; i++)
    {
      NeighbourNode nn = new NeighbourNode();
      neighbours.add(nn);
    }
  }

  // The algorithm to test if given node is closer than the stored ones
  void CheckDist(float d, Node n)
  {
    // First node is always the farthest, as we keep the linked list sorted (by inserting at the right place)
    NeighbourNode fnn = (NeighbourNode) neighbours.getFirst();
    if (d < fnn.dist)
    {
      println(int(d) + " < " + int(fnn.dist));
      // Found an element closer
      // Remove the far element
      neighbours.remove();
      println("B " + neighbours);
      // To add
      NeighbourNode nnn = new NeighbourNode(d, n);
      println("Add " + nnn);
      // Walk the list until we find a node which is farther than this one
      Iterator it = neighbours.iterator();
      int idx = -1;
      while (it.hasNext())
      {
        NeighbourNode nn = (NeighbourNode) it.next();
        idx++;
//        println("I " + nn);
        if (d > nn.dist)
        {
          // Found, we add the node before this one
          neighbours.add(idx, nnn);
          println("A " + neighbours);
          return;
        }
      }
      // Not found, ie. found the smallest distance, put it at end
      neighbours.add(nnn);
      println("SA " + neighbours);
    }
  }

  public void Highlight(boolean bHighlight)
  {
    Iterator it = neighbours.iterator();
    while (it.hasNext())
    {
      NeighbourNode nn = (NeighbourNode) it.next();
      nn.node.Highlight(bHighlight);
    }
  }

  public void Connect(Node mNode)
  {
    Iterator it = neighbours.iterator();
    while (it.hasNext())
    {
      NeighbourNode nn = (NeighbourNode) it.next();
      stroke(#0000FF);
      line(nn.node.posX, nn.node.posY, mNode.posX, mNode.posY);
    }
  }

  public String toString()
  {
    StringBuilder sb = new StringBuilder("NNs[");
    Iterator it = neighbours.iterator();
    while (it.hasNext())
    {
      NeighbourNode nn = (NeighbourNode) it.next();
      sb.append(nn.toString() + ", ");
    }
    sb.delete(sb.length() - 2, sb.length() - 1).append("]");
    return sb.toString();
  }
}

