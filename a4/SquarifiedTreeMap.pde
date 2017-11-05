TreeParser tp;
Tree t;
Arrange a;
Area area;
Node startNode;
boolean found;
boolean pressed;
boolean transition; 
float transparency;

public class SquarifiedTreeMap{
  
    float x, y, w, h;
  
    SquarifiedTreeMap (String treepath, float x, float y, float w, float h) {
        tp = new TreeParser(treepath);
        t = new Tree(tp.labels, tp.weights, tp.parents, tp.children);
        a = new Arrange(t); // pass the tree to be arranged
        startNode = t.root; // initialize the graph to the root
        area = new Area(x, y, w, h);
        a.drawFrom(startNode, area);
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        transition = false;
        transparency = 255;
    }
    
    void render() {
        if (pressed && (mouseButton == LEFT)) {
                Node newStart = t.getNode(locateNode(a.root).label);
                if (startNode != newStart) {
                    startNode = newStart;
                    transition = true;
                }
            
        } else if (pressed && mouseButton == RIGHT) {
            if (startNode.parent != null){
                startNode = startNode.parent;
                transition = true;
            }
        }
        area = new Area(x, y, w, h);
        a.drawFrom(startNode, area);
        
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