class Parser {
  // Expr = BinExpr | Name | ( Expr ) |... 
  // BinExpr = Expr Op Expr
  // Name = A | B | ....

  // Op = union | intersect | diff | ...

  // plus: brackets? Unary ops? Empty

  // Want lists of exprs.
  // so parser returns List<Expr>

  //ArrayList<MathsSym> symList = new ArrayList();
  //ExprStack stack = new ExprStack();

  Parser() {
  }

  // parse - return an Expr.
  // How to return a List<Expr>?

  // Better to use a stream over tokens?
  // we only ever look at pos 0 and rest for the recursive call

  ArrayList<Expr> parse(ArrayList<MathsSym> tokens) {
    ExprStack stack = new ExprStack();
    stack.init();
    return parseExp(tokens.iterator(), stack);
  }
    
  ArrayList<Expr> parseExp(Iterator<MathsSym> tokens, ExprStack stack) {
    // Nothing left to parse
    Log("P : "+stack);

    if (!tokens.hasNext()) {
      //if (stack.isEmpty() || !(stack.top().isComplete())) {
      if (!(stack.top().isComplete())) { // incomplete expr
        return null;
      } else {
        //accumulate(stack); // why accumulate?
        return stack.stack; // ArrayList containing  all expressions
      }
    }

    MathsSym token = tokens.next();
    //Log("Token:"+token);

    // 1 : Name
    if (token.isName()) {
      NameExpr n = new NameExpr();
      n.name=token.text;
      //Log("Name:"+n);
      // within an expr
      stack.push(n); // Just push it.
      accumulate(stack);
      return parseExp(tokens, stack);
    }
    if (token.isBinOp()) {

      //Log("BinOp:"+token);
      if (stack.isEmpty() || !(stack.top().isComplete())) { 
        // if empty, then we're starting with a BinOp
        // if top is not complete, then we've got two successive BinOps

        Log("Null");
        return null;
      }
      BinExpr e = new BinExpr();
      e.op=token.text;
      e.left=stack.pop();

      stack.push(e);
      return parseExp(tokens, stack);
    }

    if (token.isOpen()) {
      // push something?
      // a bracket?
      stack.push(parseSubExp(tokens));
      // return something? accumulate?
    }

    if (token.isClose()) {
      accumulate(stack);
      return stack.stack;
    }
    return null;
  }

  Expr parseSubExp(Iterator<MathsSym> tokens) {
    ExprStack s = new ExprStack();
    s.init();
    ArrayList<Expr> el= parseExp(tokens, s);
    if (el.size()==1) {
      return el.get(0);
    } else { 
      return null;
    }
  }

  void accumulate(ExprStack stack) {
    // pop some things until we can build a complete expr. Then push this.
    // 

    Log("A : "+stack);
    if (stack.size()>=2) {
      Expr e1=stack.pop(); // should be complete
      if (stack.top().isBinExpr() && stack.top().isComplete()) {
        BinExpr e2=(BinExpr)stack.pop(); // should be incomplete
        accumulate(stack);
        e2.right=e1;
        stack.push(e2); // could have left it on the stack
      } else {
        accumulate(stack);
        stack.push(e1);
      }
    }

    Log("A-: "+stack);
  }
}
