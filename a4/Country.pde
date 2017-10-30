public class Country {

    String name;
    float happinessScore, GDP, socialSupport, lifeExpt,freedom;
    float generosity, corruption, dystopia;
    boolean isMarked;
    int population;
    String continent;
    
    Country(String name, float happinessScore, float GDP, 
            float socialSupport, float lifeExpt, float freedom, 
            float generosity, float corruption, float dystopia){
        this.name = name;
        this.happinessScore = happinessScore;
        this.GDP = GDP;
        this.socialSupport = socialSupport;
        this.lifeExpt = lifeExpt;
        this.freedom = freedom;
        this.generosity = generosity;
        this.corruption = corruption;
        this.dystopia = dystopia;
        this.isMarked = true;
        this.population = 0;
        this.continent = "";
    }  
}