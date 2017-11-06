public class BarGraph{

    float x, y, w, h; 
    color colors[];
  
    BarGraph(float x, float y, float w, float h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;

        color []cArray = {color(144, 50, 105), color(0, 79, 130), color(78, 33, 68),
                  color(0, 72, 0), color(205, 136, 0), color (11, 0, 61), 
                  color(125, 23, 23)};
        this.colors = cArray;
        //println(colors);
      
    }
  
    public void render(ArrayList<Country> countries, int barState, float maxHappy){
        
        // Draw Axes
        stroke(0);
        line(this.x + this.w * .15, this.y, this.x + this.w * .15, this.y + this.h * 0.9);
        
        float ratio = this.w * .85 / maxHappy;
        float interval = this.h / countries.size();
        float barHeight = interval * 0.9;
        float barPos = this.x + this.w * 0.15;
        
        if (barState != 8) {
          float maxVal = countries.get(0).scores[barState];
          for (int i = 1; i < countries.size(); i++) {
            float testVal = countries.get(i).scores[barState];
            if (testVal > maxVal) {
              maxVal = testVal;
            }
          }
          ratio = this.w * .85 / maxVal;
        }
        
        for (int i = 0; i < countries.size(); i++) {
            float xPos = barPos;
            
            fill(0);
            textAlign(RIGHT, TOP);
            textSize(barHeight/2);
            text(countries.get(i).name, barPos - width * .01, this.y + interval * i);
            
            
            
            if (barState == 8) {
              for (int j = 0; j < 7; j++) {
                  fill(colors[j]);
                  
                  if (countries.get(i).hover) {
                    colorMode(HSB, 360, 100, 100);
                    fill(hue(colors[j]), saturation(colors[j]), brightness(colors[j]) + 20);
                    colorMode(RGB, 255);
                  }
                  noStroke();
                  rect(xPos, this.y + interval * i, ratio * countries.get(i).scores[j], barHeight);
                  xPos += ratio * countries.get(i).scores[j];
    
              }
              if (mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.h) {
                  if (mouseX > barPos && mouseX < xPos && mouseY > this.y + interval * i && mouseY < this.y + interval * i + barHeight) {
                      countries.get(i).hover = true;
                  } else {
                      countries.get(i).hover = false;
                  }
              }
            } else {
              
              fill(colors[barState]);
              
              if (countries.get(i).hover) {
                    colorMode(HSB, 360, 100, 100);
                    fill(hue(colors[barState]), saturation(colors[barState]), brightness(colors[barState]) + 20);
                    colorMode(RGB, 255);
                    //println("hovering!");
              }
              
              noStroke();
              rect(barPos, this.y + interval * i, ratio * countries.get(i).scores[barState], barHeight);
              
              if (mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.h) {
                if (mouseX > barPos && mouseX < ratio * countries.get(i).scores[barState] + this.x && 
                    mouseY > this.y + interval * i && mouseY < this.y + interval * i + barHeight) {
                    countries.get(i).hover = true;
                } else {
                    countries.get(i).hover = false;
                }
              }
              
            }
            
        }
        
    }
    
    boolean checkHover(ArrayList<Country> countries){
      return (mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.h);
    }
    
  
  
}