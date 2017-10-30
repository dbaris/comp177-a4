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
  
    public void render(ArrayList<Country> countries, float maxHappy){
        //fill(0, 100, 0);
        //rect(this.x, this.y, this.w, this.h);
        
        // Draw Axes
        stroke(0);
        line(this.x + this.w * .15, this.y, this.x + this.w * .15, this.y + this.h * 0.9);
        
        //line(this.x + this.w * .15, this.y + this.h * 0.9, this.x + this.w, this.y + this.h * 0.9);
        
        float ratio = this.w / maxHappy;
        float interval = this.h / countries.size();
        float barHeight = interval * 0.9;
        float barPos = 0;
        
        for (int i = 0; i < countries.size(); i++) {
            for
        }
    }
    
  
  
}