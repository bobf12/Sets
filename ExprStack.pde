class ExprStack {
  // Make into a class

  ArrayList<Expr> stack = new ArrayList();
  void init() {
    stack = new ArrayList();
  }

  void push (Expr e) {
    stack.add(e);
  }
  Expr pop() {
    return stack.remove(stack.size()-1);
  }
  Expr top() {
    return stack.get(stack.size()-1);
  }
  boolean isEmpty() {
    return (stack.size()==0);
  }
  
  int size(){
    return stack.size();
  }
  
  String toString(){
    return stack.toString();
  }
}
