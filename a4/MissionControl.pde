public class MissionControl {

  Country[] countries;
  BarGraph bar;
  //SquarifiedTreeMap tree;
  //ScatterPlot plot;
  float margin;

  MissionControl(Country[] countries) {
      this.margin = height * .05;
      this.countries = countries;
      bar = new BarGraph(width / 2 + this.margin, this.margin,
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
    
    this.bar.render(markedCountries, maxHappy);
  }
}