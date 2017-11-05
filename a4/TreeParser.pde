public class TreeParser {

    String[] lines;
    int num_leaves;   // number of leaves
    int num_rel;      // number of relations
    String[] labels;  // array of countries 
    int[] weights;    // population of countries
    String[] parents; 
    String[] children;

    TreeParser(String filePath) {
        lines = loadStrings(filePath);
        num_leaves = int(lines[0]); 
        num_rel = int(lines[num_leaves + 1]);
        labels = new String[num_leaves];
        weights = new int[num_leaves];
        parents = new String[num_rel];
        children = new String[num_rel];
        
        for (int i = 0; i < num_leaves; i++){
            String[] line = split(lines[i + 1], ",");
            labels[i] = line[0];
            weights[i] = int(line[1]);
        }
        
        for (int i = 0; i < num_rel; i++) {
            String[] line = split(lines[num_leaves + 2 + i], ",");
            parents[i] = line[0];
            children[i] = line[1];
        }  
    } 
}