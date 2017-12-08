String filepath = "a4/simple.csv";
String treepath = "a4/simple_tree.csv";
Parser p;
MissionControl mc;
int width = 1000;
int height = 600;

void setup() {  
  //fullScreen();
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