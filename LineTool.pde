public class LineTool extends Tool {
  boolean drawing;
  Line working;
  int sinceLastClick;
  
  public LineTool(){
    super();
    //isActive = true;
    args = new int[4];
    drawing = false;
    working = null;
    sinceLastClick = 0;
  }
  
  void sketch(){
    sinceLastClick++;
    if (mouseX < width*.75 && mousePressed && sinceLastClick > inputDelay) {
      sinceLastClick = 0;
      if (isActive) {
        if (drawing) {
          drawing = false;
        }
        else {
          drawing = true;
          working = new Line(mouseX, mouseY, fill, stroke, mouseX, mouseY);
          thingsToDraw.add(working);
        }
      }
    }
    
    if (!isActive && drawing) {
      drawing = false;
      thingsToDraw.remove(working);
    }
    else if (drawing) {
      working.setEndX(mouseX);
      working.setEndY(mouseY);
    }
  }
  
  void makeLine(int x1, int y1, int x2, int y2) {
    thingsToDraw.add(new Line(x1,y1,fill,stroke,x2,y2));
  }
  
  public void cleanUp() {
    if (drawing) {
      drawing = false;
      thingsToDraw.remove(working);
    }
  }
  
  public Object getObject() { return working; }
}


public class Line extends Object {
  int startX = 0;
  int startY = 0;
  int endX = 0;
  int endY = 0;
  //int[] fill;
  //int[] Color;
 
  public Line(int X, int Y, color Fill, color COlor, int eX, int eY) {
    super();
    startX = X;
    startY = Y;
    endX = eX;
    endY = eY;
    fill = Fill;
    Color = COlor;
    minX = min(startX,endX);
    minY = min(startY,endY);
    maxX = max(startX,endX);
    maxY = max(startY,endY);
  }
 
  public void drawShape() {
    line(startX, startY, endX, endY);
  }
  
  public void setX(int x) {
    startX = x;
    minX = min(startX,endX);
    maxX = max(startX,endX);
  }
  
  public void setY(int y) {
    startY = y;
    minY = min(startY,endY);
    maxY = max(startY,endY);
  } 
  
  public void setEndX(int x) {
    endX = x;
    minX = min(startX,endX);
    maxX = max(startX,endX);
  }
  
  public void setEndY(int y) {
    endY = y;
    minY = min(startY,endY);
    maxY = max(startY,endY);
  }
  
  public Object duplicate() {
    int newX = maxX()+20 >= width*0.75 ? 0 : x+20;
    int newY = maxX()+20 >= width*0.75 ? 0 : y+20;
    return new Line(newX, newY, fill, Color, newX+(endX-startX), newY+(endY-startY));
  }
}
