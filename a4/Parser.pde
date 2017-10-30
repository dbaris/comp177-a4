class Parser {
  String lines[];
  Country[] countries;
  
  Parser(String filepath){
    this.lines = loadStrings(filepath);
    countries = new Country[lines.length - 1];
    
    for(int i = 1; i < lines.length; i++) {
      String[] line = split(lines[i], ",");
      Country c = new Country(line[0], float(line[1]), float(line[4]), 
                              float(line[5]), float(line[6]), float(line[7]),
                              float(line[8]), float(line[9]));
      countries[i - 1] = c;
    }  
  }
}