public class Country {

    String name;
    float happinessScore;
    float [] scores;
    boolean isMarked, hover;
    int population;
    String continent;
    
    Country(String name, float happinessScore, float GDP, 
            float socialSupport, float lifeExpt, float freedom, 
            float generosity, float corruption, float dystopia){
        this.name = name;
        this.happinessScore = happinessScore;
        this.hover = false;
        
        this.scores = new float[7];
        
        this.scores[0] = GDP;
        this.scores[1] = socialSupport;
        this.scores[2] = lifeExpt;
        this.scores[3] = freedom;
        this.scores[4] = generosity;
        this.scores[5] = corruption;
        this.scores[6] = dystopia;
        this.isMarked = true;
        this.population = 0;
        this.continent = "";
    }  
}