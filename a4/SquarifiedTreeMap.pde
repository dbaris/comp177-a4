TreeParser tp;
Tree t;
Arrange a;
Area area;
Node startNode;
boolean found;

boolean transition; 
float transparency;

public class SquarifiedTreeMap{
  
    float x, y, w, h;
    boolean pressed;
  
    SquarifiedTreeMap (String treepath, float x, float y, float w, float h, Country[] countries) {
        tp = new TreeParser(treepath);
        t = new Tree(tp.labels, tp.weights, tp.parents, tp.children);
        a = new Arrange(t); // pass the tree to be arranged
        startNode = t.root; // initialize the graph to the root
        area = new Area(x, y, w, h);
        a.drawFrom(startNode, area, countries);
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        transition = false;
        transparency = 255;
        this.pressed = false;
    }
    
    boolean onGraph(){
      return (mouseX > this.x && mouseX < this.x + this.w && mouseY > this.y && mouseY < this.y + this.h);
    }
    
    void markChildren(Node root, Country[] countries) {
        ArrayList<String> selected = getChildrenName(root);
        for (Country c : countries) {
            c.isMarked = selected.contains(c.name);
        }
    }
    
    ArrayList<String> getChildrenName(Node root) {
        if (root.level == 1) {
              ArrayList<String> result = new ArrayList<String>();
              result.add(root.label);
              return result;
        } else {
              ArrayList<String> result = new ArrayList<String>();
              for (Node c: root.children) {
                  result.addAll(getChildrenName(c));
              }
              return result;
        }
    }
    
    void render(Country[] countries) {
        if (pressed && (mouseButton == LEFT)) {
                Node newStart = t.getNode(locateNode(a.root).label);
                if (startNode != newStart) {
                    startNode = newStart;
                    //transition = true;
                }
                markChildren(newStart, countries);
            
        } else if (pressed && mouseButton == RIGHT) {
            if (startNode.parent != null){
                startNode = startNode.parent;
                //transition = true;
                markChildren(startNode, countries);
            }
            
        }
        area = new Area(x, y, w, h);
        a.drawFrom(startNode, area, countries);
        
        fill(0);
        textAlign(CENTER, TOP);
        text(startNode.label, this.x + this.w/2, this.y + this.h + 0.5);
        
        if (startNode.level == 1) {
          text("Population: " + startNode.weight, this.x + this.w/2, this.y + this.h + 0.02 * height);
        }
        
        if (transition) {
            if (transparency == 5) {
                transition = false;
                transparency = 255;
            }
            fill(0, 0, 0, transparency);
            rect(0, 0, width, height);
            transparency -= 5;
        } 
        pressed = false;
        found = false;
    }
    
    WNode locateNode(WNode r) {
        if (!found) {
            boolean b = true;
            // Check if any children nodes are hovering
            for (WNode c: r.children) {
                if (a.hovering(c)) b = false;
            }
            // If no children nodes are hovering, color parent
            if (a.hovering(r) && b) {
                if (r != null) {
                    found = true;
                    return r;
                }
            }
            else {
                for (WNode c: r.children) {
                    WNode result = locateNode(c);
                    if (result != null) {
                        return result;
                    }
                }
            }    
        }
        return null;
    }
    
    void mousePressed() {
        pressed = true;
    }
}