public class MissionControl {

  Country[] countries;
  BarGraph bar;
  SquarifiedTreeMap tree;
  ScatterPlot plot;
  float margin;
  
  
  MissionControl(Country[] countries) {
      this.margin = height * .05;
      this.countries = countries;
      bar = new BarGraph(width / 2 + this.margin, this.margin,
                         width / 2 - this.margin * 2, 
                         height - this.margin * 2);
  }
  
}