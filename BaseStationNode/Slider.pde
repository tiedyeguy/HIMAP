class Slider {
  public int value;
  public PVector range;
  public PVector pos;
  public float length;
  public String name;
  public boolean isSelected;
  public PFont f;

  public Slider(int value, PVector range, PVector pos, float length, String name) {
    this.value = value;
    this.range = range.copy();
    this.pos = pos.copy();
    this.length = length;
    this.name = name;

    f = createFont("monospaced.plain", 20);
    textFont(f);
  }

  public boolean isOverHandle(int x, int y) {
    float handleX = map(value, range.x, range.y, pos.x, pos.x + length);
    float handleY = pos.y;

    return x >= handleX - 5 && x <= handleX + 5 &&
      y >= handleY - 10 && y <= handleY + 10;
  }

  public void update() {
    if (!isSelected) return;

    float consMouseX = constrain(mouseX, pos.x, pos.x + length);

    value = int(map(consMouseX, pos.x, pos.x + length, range.x, range.y));
  }

  public void draw() {
    stroke(0);
    strokeWeight(3);
    line(pos.x, pos.y, pos.x + length, pos.y);

    float sliderPos = map(value, range.x, range.y, pos.x, pos.x + length);

    pushMatrix();

    translate(sliderPos, pos.y);
    scale(1.5);

    noStroke();
    if (isSelected) fill(0, 0, 150);
    else           fill(0, 0, 255);
    rect(-5, -10, 10, 20);

    stroke(0);
    strokeWeight(1);
    line(-3, 5, 3, 5);
    line(-3, 0, 3, 0);
    line(-3, -5, 3, -5);

    popMatrix();

    fill(0);
    textAlign(LEFT, CENTER);
    text(name + ": " + value, pos.x + length + 15, pos.y - 5);
  }
}
