String filepath = "simple.csv";
String treepath = "simple_tree.csv";
Parser p;
MissionControl mc;

void setup() {
  fullScreen();
  p = new Parser(filepath);
  mc = new MissionControl(p.countries);
}

void draw() {
  background(255);
  mc.render();
}

void mouseClicked(){
  mc.handleClick();
}