class MathsSym {
  int x, y;
  String text;
  float angle=0;
  int size=60;
  int rad=10;

  MathsSym() {
  }

  void draw() {
    //noFill();
    //stroke(rectCol);
    noStroke();
    pushStyle();
    fill(255, 150, 150, 100);

    pushMatrix();
    translate(
      (int)Calibration.transformX(x), 
      (int)Calibration.transformY(y));

    //rotate(angle);
    rect(0, 0, size, size, rad, rad, rad, rad);
    popMatrix();

    //fill(textCol);
    text(text, (int)Calibration.transformX(x), 
      (int)Calibration.transformY(y));
    popStyle();
  }

  String toString() {
    return text;
  }

  boolean isNum() {
    return (text=="0" || text == "1" || text == "2" || text == "3"|| text == "6");// text == 0, 1, 2, ...
  }
  boolean isName() {
    return (text=="A" || text == "B" || text == "C" || text == "D"|| text == "E");// text == 0, 1, 2, ...
  }
  boolean isBinOp() {
    return (text==UNION || text == INTER || text == DIFF);
  }  
  boolean isOpen() {
    return (text=="(");
  }  
  boolean isClose() {
    return (text==")");
  }
}
