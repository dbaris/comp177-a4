public class MissionControl {

  Country[] countries;
  BarGraph bar;
  SquarifiedTreeMap tree;
  ScatterPlot plot;
  Sidebar sidebar;
  float margin;
  int clickState;
  int barState;

  MissionControl(Country[] countries) {
      this.margin = height * .05;
      this.countries = countries;
      this.clickState = -1;
      this.barState = 7; // show all categories
      this.sidebar = new Sidebar(0, 0, width * 0.1, height);
      this.plot = new ScatterPlot(this.margin + width * .1, this.margin, 
                                  width * .4 - this.margin * 2, height/2 - this.margin * 2);
      this.bar = new BarGraph(width / 2 + this.margin, this.margin,
                         width / 2 - this.margin * 2, 
                         height - this.margin * 2);
      this.tree = new SquarifiedTreeMap(treepath, this.margin + width * .1, height/2, 
                                        width * .42 - this.margin * 2, height * 0.55 - (this.margin * 2), countries);
  }
 
  public void render(){
    float maxHappy = 0;
    ArrayList <Country> markedCountries = new ArrayList <Country>();
    for (int i = 0; i < this.countries.length; i++){
      if (this.countries[i].isMarked) {
        markedCountries.add(this.countries[i]);
        if(this.countries[i].happinessScore > maxHappy) {
          maxHappy = this.countries[i].happinessScore;
          
        }
      }
    }

    this.sidebar.render();
    this.bar.render(markedCountries, barState, maxHappy);
    this.plot.render(markedCountries, maxHappy);
    this.tree.render(countries);
  }
  
  public void handleClick(){
    
    clickState = this.sidebar.onClick();
    if (clickState != -1) {
      this.plot.state = clickState;
      this.barState = clickState;
      this.tree.state = clickState;
      if (mouseButton == RIGHT) {
        this.barState = 7;
        
      }
    }
    
    // scatterplot 
    else if (this.plot.onGraph()) {
      
    } else if (this.tree.onGraph()) {
      this.tree.pressed = true;
    }
    
    
    //if (mouseButton == RIGHT) {
    //  this.barState = 8;
    //  this.tree.pressed = true;
    //  return;
    //}
    //clickState = this.sidebar.onClick();
    //if (clickState != -1) {
    //  this.plot.state = clickState;
    //  this.barState = clickState;
    //}
    //this.tree.pressed = true;
  }
  
}