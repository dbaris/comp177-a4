public class Country {

    String name;
    float happinessScore, GDP, socialSupport, lifeExpt,freedom, generosity, corruption;
    boolean isMarked;
    int population;
    String continent;
    
    Country(String name, float happinessScore, float GDP, float socialSupport,
            float lifeExpt, float freedom, float generosity, float corruption){
        this.name = name;
        this.happinessScore = happinessScore;
        this.GDP = GDP;
        this.socialSupport = socialSupport;
        this.lifeExpt = lifeExpt;
        this.freedom = freedom;
        this.generosity = generosity;
        this.corruption = corruption;
        this.isMarked = true;
        this.population = 0;
        this.continent = "";
    }  
}