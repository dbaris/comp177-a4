public class MissionControl {

  Country[] countries;
  BarGraph bar;
  //SquarifiedTreeMap tree;
  ScatterPlot plot;
  Sidebar sidebar;
  float margin;

  MissionControl(Country[] countries) {
      this.margin = height * .05;
      this.countries = countries;
      this.sidebar = new Sidebar(0, 0, width * 0.1, height);
      this.plot = new ScatterPlot(this.margin + width * .1, this.margin, 
                                  width * .4 - this.margin * 2, height/2 - this.margin * 2);
      this.bar = new BarGraph(width / 2 + this.margin, this.margin,
                         width / 2 - this.margin * 2, 
                         height - this.margin * 2);
      
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
    this.bar.render(markedCountries, maxHappy);
    this.plot.render(markedCountries, maxHappy);
  }
}