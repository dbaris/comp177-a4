

public class ScatterPlot{
  float x, y, w, h;
  int state;
  color []cArray = {color(144, 50, 105), color(0, 79, 130), color(78, 33, 68),
                  color(0, 72, 0), color(205, 136, 0), color (11, 0, 61), 
                  color(125, 23, 23)};
  String[] labels = {"GDP per capita", "Social Support", "Life Expectancy", "Freedom", "Generosity", 
                     "Corruption", "Dystopia (residual)"};
  
  ScatterPlot(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.state = 0; // start state - GDP
  }
  
  public void render(ArrayList<Country> countries, float maxHappy) {
      stroke(0);
      line(this.x, this.y, this.x, this.y + this.h * 0.9);
      line(this.x, this.y + this.h * 0.9, this.x + this.w, this.y + this.h * 0.9);
      
      pushMatrix();
      translate(this.x, this.y + this.h * 0.9 / 2);
      rotate(-HALF_PI);
      translate(-this.x, - this.y - this.h * 0.9 / 2);
      fill(0);
      textAlign(CENTER, BOTTOM);
      text("Happiness Score", this.x, this.y + this.h * .45);
      popMatrix();
      
      textAlign(CENTER, TOP);
      text(this.labels[this.state], this.x + this.w / 2, this.y + this.h * .9);
      
      stroke(177);
      float interval = this.h * .9 / 8;
      for(int i = 1; i < 9; i++) { 
        line(this.x + 1, this.y + this.h * 0.9 - interval * i, this.x + this.w, this.y + this.h * 0.9 - interval * i);
      }
      
      float minValue = countries.get(0).scores[state];
      float maxValue = countries.get(0).scores[state];
      float minHappy = countries.get(countries.size() - 1).happinessScore;
      
      for (int i = 1; i < countries.size(); i++) {
          float cur_value = countries.get(i).scores[state];
          if (cur_value < minValue) {
              minValue = cur_value;
          } 
          if (cur_value > maxValue) {
              maxValue = cur_value;
          }
      }
      
      //float ratio = this.h / (maxHappy - minHappy);
      float xOffset =  0.1 * (maxValue - minValue);
      float yOffset = 0.1 * (maxHappy - minHappy);
      
      minValue -= xOffset;
      maxValue += xOffset;
      maxHappy += yOffset;
      minHappy -= yOffset;
      
      textSize(10);
      textAlign(RIGHT, CENTER);
      text(str(float(int(minHappy * 1000))/ 1000), this.x - this.w * .02, this.y + this.h * .9);
      text(str(float(int(maxHappy * 1000))/ 1000), this.x - this.w * .02, this.y);
      textAlign(CENTER, TOP);
      text(str(float(int(minValue * 1000))/ 1000), this.x, this.y + this.h * .92);
      text(str(float(int(maxValue * 1000))/ 1000), this.x + this.w, this.y + this.h * .92);
      
      for (int i = 0; i < countries.size(); i++) {
          float cur_value = countries.get(i).scores[state];
          float cur_happy = countries.get(i).happinessScore;
          float normalizeX = (cur_value - minValue)/ (maxValue - minValue);
          float normalizeY = (cur_happy - minHappy) / (maxHappy - minHappy);
          stroke(cArray[this.state]);
          ellipse(normalizeX * this.w + this.x, this.y + this.h * 0.9 * normalizeY, 8, 8); 
          
      }
      
  }
}