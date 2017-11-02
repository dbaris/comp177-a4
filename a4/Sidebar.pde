class Sidebar {
  float x, y, h, w;
  String[] labels = {"GDP per capita", "Social Support", "Life Expectancy", "Freedom", "Generosity", 
                     "Corruption", "Dystopia (residual)"};
  color []cArray = {color(144, 50, 105), color(0, 79, 130), color(78, 33, 68),
                  color(0, 72, 0), color(205, 136, 0), color (11, 0, 61), 
                  color(125, 23, 23)};                  
  
  Sidebar(float x, float y, float w, float h){
    this.x = x;
    this.y = y; 
    this.h = h;
    this.w = w;
                
  }
  
  public void render() {
      fill(177);
      noStroke();
      rect(x, y, w, h);
      
      //int i = 0;
      for(int i = 0; i < 7; i++) {
          float cx, cy, cr;
          cx = this.x + this.w /2;
          cy = (this.h / 14) + (this.h * i/ 7);
          cr = this.h / 8;
          
          if (abs(mouseX - cx) < cr / 2 && abs(mouseY - cy) < cr / 2) {
              fill(255);
              ellipse(cx, cy, cr, cr);
              fill(0);
          } else {
              fill(cArray[i]);
              ellipse(cx, cy, cr, cr);
              fill(255);
          }
          textSize(cr / 10);
          textAlign(CENTER, CENTER);
          text(labels[i], cx, cy);
          //i++;
      }
  }
      
      
        
       
  }