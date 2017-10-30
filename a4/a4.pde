String filepath = "simple.csv";
Parser p;
//MissionControl mc;

void setup() {
      size(1200, 600);
      p = new Parser(filepath);
      for (int i = 0; i < p.countries.length; i++) {
          println(p.countries[i].dystopia);
      }
      //mc = new MissionControl();
      
}

void draw() {
}