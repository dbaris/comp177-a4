class Node {
    String label;
    int weight;
    Node parent;
    int level;
    ArrayList<Node> children;
    
    Node(String l, int w) {
        label = l;
        weight = w;
        parent = null;
        level = 0;
        children = new ArrayList<Node>();
    }
}

public class Tree {
  
    Node root;
    ArrayList<Node> allNodes;
  
    Tree(String[] labels, int[] weights, String[] parents, String[] children) {
        allNodes = new ArrayList<Node>();
        if (parents.length == 0) {
            root = null;
        } else {
            boolean newNode = false;
            root = new Node(parents[0], getWeight(parents[0], labels, weights));
            allNodes.add(root);
            for (int i = 0; i < parents.length; i++) {
                Node r = getNode(parents[i]);
                Node c = getNode(children[i]);
                if (r == null) {
                    r = new Node(parents[i], getWeight(parents[i], labels, weights));
                    allNodes.add(r);
                }
                if (c == null) {
                    newNode = true;
                    c = new Node(children[i], getWeight(children[i], labels, weights));
                    allNodes.add(c);
                }
                if (!newNode && !isRoot(c.label)) {
                    Node oldParent = c.parent;
                    appendChild(oldParent, r);
                    r.parent = oldParent;
                }
                appendChild(r, c);
                if (isRoot(c.label)){
                    root = r;
                }
            }
        }
        root.weight = updatedWeights(root);
        int maxLevel = 0;
        for (Node c: root.children) {
            if (c.level > maxLevel) maxLevel = c.level;
        }
        root.level = maxLevel + 1;
        trickleDown(root);
    }
    
    boolean isRoot(String label) {
        return(label.equals(root.label));
    }
    
    void trickleDown(Node r) {
          for (Node c: r.children) {
              c.level = r.level - 1;
              trickleDown(c);
          }
    }
    
    void printTree(Node r) { // for debugging purposes
        if (r == null) return;
        for (Node child: r.children) println(child.label); //printTree(child);
    }
    
    Node getParentNode(String label) {
        return getNode(label).parent;
    }
    
    int getWeight(String label, String[] labels, int[] weights) {
        for (int i = 0; i < labels.length; i++) {
            if (labels[i].equals(label)) return weights[i];
        }
        return 0;
    }
    
    Node getNode(String label) {
        Node result = getNodeInternal(label, root);
        if (result == null) {
            for (Node ch: allNodes) {
                if (ch.label.equals(label)) {
                    result = ch;
                    break;
                }
            }
        }
        return result;
    }
    
    Node getNodeInternal(String label, Node r) {
        if (r == null) {
            return null;
        } else if (r.label.equals(label)) {
            return r;
        } else {
            Node result = null;
            for (Node child: r.children) {
                result = getNodeInternal(label, child);
                if (result != null) break;
            }
            return result;
        }
    }
    
    void appendChild(Node parent, Node child) {
        child.parent = parent;
        parent.children.add(child);
    }
    
    // to trickle up weights to the parents
    int updatedWeights(Node r){
        if (r.children.size() == 0) {
            r.level = 1;
            return r.weight;
        }
        int sum = 0;
        int maxLevel = 0;
        for (Node c: r.children) {
            sum += updatedWeights(c);
            if (c.level > maxLevel) maxLevel = c.level;
        }
        r.level = maxLevel + 1;
        r.weight = sum;
        return sum;
    }

}