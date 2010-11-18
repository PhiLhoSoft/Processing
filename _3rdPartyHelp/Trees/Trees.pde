// http://forum.processing.org/topic/dynamicly-class-extension
int MAX_LEVELS = 3;
Node[] nodes = new Node[5];

static color[] colors =
{
  #FF0000,
  #00FF00,
  #0000FF,
  #FFFF00,
  #FF00FF,
  #00FFFF,
};

void setup() {
  size(500, 500);
  background(255);
  smooth();
  frameRate(1);

  for (int i = 0; i < nodes.length; i++) {
    nodes[i] = new Node(0, (int) random(3, 7), width/2, height/2, 10);
    nodes[i].makeNodes(300, 300);
  }
}

int teller = 0;
int tellerGrens = 5;
int i;

void draw() {
  background(255);
  nodes[i].display();

  teller = ++teller % tellerGrens;
  if (teller == 0) {
    i = ++i % nodes.length;
  }
}

