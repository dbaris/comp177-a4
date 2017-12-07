//import java.util.*;

public class BarGraph{

    float x, y, w, h; 
    color colors[];
    String labels[];
  
    BarGraph(float x, float y, float w, float h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;

        color []cArray = {color(144, 50, 105), color(0, 79, 130), color(78, 33, 68),
                  color(0, 72, 0), color(205, 136, 0), color (11, 0, 61), 
                  color(125, 23, 23)};
        String[] labels_temp = {"GDP per capita", "Social Support", "Life Expectancy", "Freedom", "Generosity", 
                           "Corruption", "Dystopia (residual)", "Happiness Score"};
        this.colors = cArray;
        this.labels = labels_temp;
        //println(colors);
      
    }
  
    public void render(Country[] countries, int numCountries, int barState, float maxHappy){
        textAlign(CENTER, TOP);
        fill(0);
        text(this.labels[barState], this.x + this.w/2, this.y + this.h);
      
        float ratio = this.w * .85 / maxHappy;
        float interval = this.h / numCountries;
        float barHeight = interval * 0.9;
        
        if (barHeight > 60) {
          barHeight = 60;
        }
        
        float barPos = this.x + this.w * 0.15;
        
        if (barState != 7) {
          float maxVal = countries[0].scores[barState];
          for (int i = 1; i < numCountries; i++) {
            float testVal = countries[i].scores[barState];
            if (testVal > maxVal) {
              maxVal = testVal;
            }
          }
          ratio = this.w * .85 / maxVal;
        }
        
        if (barState == 7) {
            //Collections.sort(countries, new Comparator<Country>(){
            //    public int compare(Country p1, Country p2){
            //        Float s1 = new Float(p1.happinessScore);
            //        Float s2 = new Float(p2.happinessScore);
            //        return -s1.compareTo(s2);
            //    }
            //});
        } else if (barState == 0) {
            //Collections.sort(countries, new Comparator<Country>(){
            //    public int compare(Country p1, Country p2){
            //        Float s1 = new Float(p1.scores[0]);
            //        Float s2 = new Float(p2.scores[0]);
            //        return -s1.compareTo(s2);
            //    }
            //});
        } else if (barState == 1) {
            //Collections.sort(countries, new Comparator<Country>(){
            //    public int compare(Country p1, Country p2){
            //        Float s1 = new Float(p1.scores[1]);
            //        Float s2 = new Float(p2.scores[1]);
            //        return -s1.compareTo(s2);
            //    }
            //});
        } else if (barState == 2) {
            //Collections.sort(countries, new Comparator<Country>(){
            //    public int compare(Country p1, Country p2){
            //        Float s1 = new Float(p1.scores[2]);
            //        Float s2 = new Float(p2.scores[2]);
            //        return -s1.compareTo(s2);
            //    }
            //});
        } else if (barState == 3) {
            //Collections.sort(countries, new Comparator<Country>(){
            //    public int compare(Country p1, Country p2){
            //        Float s1 = new Float(p1.scores[3]);
            //        Float s2 = new Float(p2.scores[3]);
            //        return -s1.compareTo(s2);
            //    }
            //});
        } else if (barState == 4) {
            //Collections.sort(countries, new Comparator<Country>(){
            //    public int compare(Country p1, Country p2){
            //        Float s1 = new Float(p1.scores[4]);
            //        Float s2 = new Float(p2.scores[4]);
            //        return -s1.compareTo(s2);
            //    }
            //});
        } else if (barState == 5) {
            //Collections.sort(countries, new Comparator<Country>(){
            //    public int compare(Country p1, Country p2){
            //        Float s1 = new Float(p1.scores[5]);
            //        Float s2 = new Float(p2.scores[5]);
            //        return -s1.compareTo(s2);
            //    }
            //});
        } else if (barState == 6) {
            //Collections.sort(countries, new Comparator<Country>(){
            //    public int compare(Country p1, Country p2){
            //        Float s1 = new Float(p1.scores[6]);
            //        Float s2 = new Float(p2.scores[6]);
            //        return -s1.compareTo(s2);
            //    }
            //});
        }
        
        
        for (int i = 0; i < numCountries; i++) {
            float xPos = barPos;
            
            fill(0);
            textAlign(RIGHT, TOP);
            textSize(9);
            text(countries[i].name, barPos - width * .01, this.y + interval * i + barHeight/2);

            if (barState == 7) {
              
              for (int j = 0; j < 7; j++) {
                  fill(colors[j]);
                  
                  if (countries[i].hover) {
                    colorMode(HSB, 360, 100, 100);
                    fill(hue(colors[j]), saturation(colors[j]), brightness(colors[j]) + 20);
                    colorMode(RGB, 255);
                  }
                  noStroke();
                  rect(xPos, this.y + interval * i, ratio * countries[i].scores[j], barHeight);
                  xPos += ratio * countries[i].scores[j];
    
              }
              
              if (numCountries == 1) {
                  Country c = countries[0];
                  int k;
                  for (k = 0; k < 7; k++) {
                      fill(colors[k]);
                      textSize(12);
                      textAlign(CENTER, CENTER);
                      text(this.labels[k] + ": " + c.scores[k], this.x + this.w/2, this.y + this.h/5 + k * height*0.05);
                  } 
                  fill(0);
                  text("Total Happiness Score: " + c.happinessScore, this.x + this.w/2, this.y + this.h/5 + k * height*0.05);
              }
              
              if (mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.h) {
                  if (mouseX > barPos && mouseX < xPos && mouseY > this.y + interval * i && mouseY < this.y + interval * i + barHeight) {
                      countries[i].hover = true;
                  } else {
                      countries[i].hover = false;
                  }
              }
            } else {
              
              fill(colors[barState]);
              
              if (countries[i].hover) {
                    colorMode(HSB, 360, 100, 100);
                    fill(hue(colors[barState]), saturation(colors[barState]), brightness(colors[barState]) + 20);
                    colorMode(RGB, 255);
                    //println("hovering!");
              }
              
              noStroke();
              rect(barPos, this.y + interval * i, ratio * countries[i].scores[barState], barHeight);
              
              if (mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.h) {
                if (mouseX > barPos && mouseX < ratio * countries[i].scores[barState] + this.x && 
                    mouseY > this.y + interval * i && mouseY < this.y + interval * i + barHeight) {
                    countries[i].hover = true;
                } else {
                    countries[i].hover = false;
                }
              }
              
            }
            
        }
        
    }
    
    boolean checkHover(Country[] countries){
      return (mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.h);
    }
    
  
  
}