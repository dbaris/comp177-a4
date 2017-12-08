String filepath = "a4/simple.csv";
String treepath = "a4/simple_tree.csv";
Parser p;
MissionControl mc;



void setup() {  
  //fullScreen();
  size(1200,500);
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