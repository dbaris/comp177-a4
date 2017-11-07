import java.util.*;
import java.lang.*;

color corruption = color(255, 255, 255);

color[] colorArray = {color(205, 136, 0), #457FA4, #004F82, #003A5F, #00243C};

// Class Area represents a rectangular area with its
// x, y coordinates, its width and height, and a bool
// indicating whether it is horizontal.
class Area {
    float x_coor;
    float y_coor;
    float w;
    float h; 
    boolean horizontal;
    
    Area(float x, float y, float wid, float hi) {
        x_coor = x;
        y_coor = y;
        w = wid;
        h = hi;
        if (w > h) {
            horizontal = true;
        } else {
            horizontal = false;
        } 
    }
}

// Class WNode represents a node in the working tree
// under class Arrange. It holds its label, weight, 
// the area it occupies, its color, and a list of its
// children.
class WNode{
    String label;
    String parent;
    float weight;
    Area a;
    ArrayList<WNode> children;
  
    WNode(String l, float w) {
        label = l;
        parent = "";
        weight = w;
        a = new Area(0, 0, 0, 0);
        children = new ArrayList<WNode>();
    }
    
    WNode(String l, int w, float xc, float yc, float wp, float hp){
        label = l;
        parent = "";
        weight = w;
        a = new Area(xc, yc, wp, hp);
        children = new ArrayList<WNode>();
    }
}

public class Arrange{
    WNode root; // root of the working tree
    Tree tree;  // tree from which nodes to be arranged
    float space = 3;
  
    Arrange(Tree t){
        root = null;
        tree = t;
    }  
    
    // returns WNode with label
    WNode getNode(String label) {
        return getNodeInternal(label, root);
    }
    
    // helper function for getNode
    WNode getNodeInternal(String label, WNode r) {
        if (r == null) {
            return null;
        } else if (r.label.equals(label)) {
            return r;
        } else {
            WNode result = null;
            for (WNode child: r.children) {
                result = getNodeInternal(label, child);
                if (result != null) break;
            }
            return result;
        }
    }
    
    // draws tree with root r on canvas
    public void drawFrom(Node r, Area canvas, Country[] countries) {
          // initialize working tree node]
          root = new WNode(r.label, r.weight);
          updateArea(root, canvas.x_coor, canvas.y_coor, canvas.w, canvas.h);
          // draws the root onto canvas
          drawRec(root, countries);
          // order its children
          order(root, canvas, countries);
    }

    // updates the area field of selected node
    void updateArea(WNode r, float x, float y, float wi, float hi) {
          r.a.x_coor = x;
          r.a.y_coor = y;
          r.a.w = wi;
          r.a.h = hi;       
    }
    
    // draws a rectangle based on the working node info
    void drawRec(WNode r, Country[] countries) {
        String label = r.label;
        boolean b = true;
        int lev = tree.getNode(r.label).level;
        //float alpha = 1 / lev;
        //println(alpha);
        
        for (WNode c: r.children) {
            if(hovering(c)) b = false;
        }
        if (hovering(r)&& b) {
          //colorMode(HSB, 360, 100, 100);
          fill(colorArray[0]);
          for (Country c : countries) {
              if (c.name.equals(label)) {
                c.hover = true;
                //break;
              } else {
                c.hover = false;
              }
          }
          
        }
        else {
            colorMode(RGB, 255);
            
            fill(colorArray[lev]);
            
            // check if country is being hovered
            for (Country c : countries) {
              if (c.name.equals(label)) {
                if (c.hover){
                  fill(colorArray[0]);
                }
                break;
              }
            }
        }
        rect(r.a.x_coor, r.a.y_coor, r.a.w, r.a.h, 4);
        if (r.a.w > label.length() * 8 && r.a.h > 5 && lev == 1) { 
          stroke(color(25, 25, 112));
          textAlign(CENTER, CENTER);
          fill(0);
          text(label, r.a.x_coor + r.a.w/2, r.a.y_coor + r.a.h/2);
        }
    }

    // add a level of children from one node r
    void buildTree(WNode r, ArrayList<Node> children) {
        // add all children to working tree
        for (Node c: children) {
            WNode nc = new WNode(c.label, c.weight);
            r.children.add(nc);
            nc.parent = r.label;
        }
        // sort all children in working tree from biggest to smallest
        Collections.sort(r.children, new Comparator<WNode>(){
            public int compare(WNode n1, WNode n2) {
                return int(n2.weight - n1.weight);}});
    }

    // lays out children from r on canvas
    public void order(WNode r, Area canvas, Country[] countries) {
        float total_weight = 0;
        if (r == null) return; // if root null, do nothing
        buildTree(r, t.getNode(r.label).children); // add all children of r
        for (WNode child: r.children) total_weight += child.weight;
        squarify(r.children, new ArrayList<WNode>(), canvas, total_weight);
        
        for (WNode child: r.children) {
            order(child, getNode(child.label).a, countries);
        }
        drawAll(r, countries);
    }
    
    // renders all rectangles in a tree
    void drawAll(WNode r, Country[] countries) {
        drawRec(r, countries);
        for (WNode c: r.children) drawAll(c, countries);
    }
    
    public void squarify(ArrayList<WNode> children, ArrayList<WNode> row, Area canvas, float total_weight) {
        if (!children.isEmpty()) {
            float w;
            float h;
            
            // set width and height
            if (canvas.horizontal) {
                w = canvas.h;
                h = canvas.w;
            } else {
                w = canvas.w;
                h = canvas.h;
            }
            
            WNode child = children.get(0); // get the first child
            ArrayList<WNode> appended = new ArrayList<WNode>();
            for (WNode rec: row) appended.add(rec); // copy current subrec
            appended.add(child); // add child
            ArrayList<WNode> newChildren = new ArrayList<WNode>(); 
            if (row.size() == 0 || 
                worst(row, canvas, total_weight) > worst(appended, canvas, total_weight)) {
                for (WNode c: children) newChildren.add(c);
                newChildren.remove(0);
                squarify(newChildren, appended, canvas, total_weight);
            } else {
                canvas = layOutRow(row, canvas, total_weight);
                total_weight = 0;
                for (WNode c: children) total_weight += c.weight;
                squarify(children, new ArrayList<WNode>(), canvas, total_weight);
            }   
        } else {
            layOutRow(row, canvas, total_weight);
        }
    }
    
   Area layOutRow(ArrayList<WNode> row, Area canvas, float total_weight) {
            float w = 0;
            float h = 0;
            float x = 0;
            float y = 0;
            float offset = 0;
            float totalSize = canvas.h * canvas.w;
            float totalRowWeight = 0;
            
            
            for (WNode rec: row) totalRowWeight += rec.weight;
            
            for (WNode rec: row) {
                float currentRatio = rec.weight / totalRowWeight;
                if (canvas.horizontal) {
                    w = (totalRowWeight / total_weight * totalSize) / canvas.h;
                    h = canvas.h * currentRatio;
                    x = canvas.x_coor;
                    y = canvas.y_coor + canvas.h * offset;
                } else {
                    w = canvas.w * currentRatio;
                    h = (totalRowWeight / total_weight * totalSize) / canvas.w;
                    x = canvas.x_coor + canvas.w * offset;
                    y = canvas.y_coor;
                }
                updateArea(rec, x + space, y + space, w - 2 * space, h - 2 * space);
                //drawRec(rec);
                offset += currentRatio;
            }
            if (canvas.horizontal) {
                  return new Area(canvas.x_coor + w, canvas.y_coor, canvas.w - w, canvas.h);
            } else {
                  return new Area(canvas.x_coor, canvas.y_coor + h, canvas.w, canvas.h - h);  
            }
    }
    
    double worst(ArrayList<WNode> row, Area canvas, float total_weight) {
        float w;
        float h;
        float total_area = canvas.h * canvas.w;
        float ratio = total_area / total_weight;
        float weight_sum = 0;
        float s; // sum of area
        
        WNode max = row.get(0);
        WNode min = row.get(row.size() - 1);
        
        if (canvas.horizontal) {
            w = canvas.h;
            h = canvas.w;
        } else {
            w = canvas.w;
            h = canvas.h;
        }
        
        for (WNode rec: row) weight_sum += rec.weight;
        s = weight_sum * ratio;
        
        return Math.max(Math.pow(w, 2) * max.weight * ratio / Math.pow(s, 2), 
                 Math.pow(s, 2) / (Math.pow(w, 2) * min.weight * ratio));
    }

    boolean hovering(WNode rec) {
        return (mouseX > rec.a.x_coor && mouseX < rec.a.x_coor + rec.a.w && 
            mouseY > rec.a.y_coor && mouseY < rec.a.y_coor + rec.a.h);
    }
}