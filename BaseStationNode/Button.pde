class Button{
  public PVector pos;
  public PVector size;
  public String text;
  public boolean isClicked;
  public PFont f;
  
  public Button(PVector pos, PVector size, String text){
    this.pos = pos.copy();
    this.size = size.copy();
    this.text = text;
    
    isClicked = false;
    f = createFont("monospaced.plain", 20);
    textFont(f);
  }
  
  public boolean isOver(int x, int y){
    return x >= pos.x && x <= pos.x + size.x &&
      y >= pos.y && y <= pos.y + size.y;
  }
  
  public void draw(){
    stroke(0);
    strokeWeight(2);
    if(isClicked) fill(150);
    else          fill(200);
    
    rect(pos.x, pos.y, size.x, size.y);
    
    noStroke();
    fill(0);
    textAlign(CENTER, CENTER);
    
    text(text, pos.x + size.x / 2, pos.y + size.y / 2 - 5);
  }
}
