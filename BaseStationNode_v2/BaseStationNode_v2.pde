import processing.serial.*;
import processing.net.*;

Server s;
Client c;

Slider[] sliders;
Button saveButton, playButton;

boolean savePressed, playPressed;
String msg;
boolean playing;
int[] currPos;
ArrayList<int[]> posns;
int posCount;

void setup() {
  size(400, 280);

  sliders = new Slider[4];
  PVector sliderRange = new PVector(0, 100);
  sliders[0] = new Slider(50, sliderRange, new PVector(20, 100), 250, "Base");
  sliders[1] = new Slider(50, sliderRange, new PVector(20, 150), 250, "Left");
  sliders[2] = new Slider(50, sliderRange, new PVector(20, 200), 250, "Right");
  sliders[3] = new Slider(100, sliderRange, new PVector(20, 250), 250, "Claw");

  saveButton = new Button(new PVector (20, 15), new PVector(170, 50), "Save");
  playButton = new Button(new PVector (210, 15), new PVector(170, 50), "Play");

  currPos = new int[4];

  s = new Server(this, 12345);

  posns = new ArrayList<int[]>(50);
  posCount = 0;

  frameRate(10);
}

void draw() {
  if (playing) {
    if (frameCount % 10 == 0) {
      currPos = copy(posns.get(posCount));
      posCount = (posCount + 1) % posns.size();
    }
  } else {
    for (int i = 0; i < currPos.length; i++) {
      currPos[i] = int(map(sliders[i].value, 0, 100, 0, 180));
    }

    if (savePressed) {
      posns.add(copy(currPos));
      savePressed = false;
    } else if (playPressed) {
      playing = true;
      playPressed = false;
    }
  }

  msg = currPos[0] + " " + currPos[1] + " " + currPos[2] + " " + currPos[3] + "\n";
  s.write(msg);
  println(msg);

  background(255);

  for (int i = 0; i < sliders.length; i++) {
    sliders[i].update();
    sliders[i].draw();
  }

  saveButton.draw();
  playButton.draw();
}

void mousePressed() {
  for (int i = 0; i < sliders.length; i++) {
    sliders[i].isSelected = sliders[i].isOverHandle(mouseX, mouseY);
  }

  saveButton.isClicked = saveButton.isOver(mouseX, mouseY);
  playButton.isClicked = playButton.isOver(mouseX, mouseY);
}

void mouseReleased() {
  for (int i = 0; i < sliders.length; i++) {
    sliders[i].isSelected = false;
  }

  saveButton.isClicked = false;
  playButton.isClicked = false;

  savePressed = saveButton.isOver(mouseX, mouseY);
  playPressed = playButton.isOver(mouseX, mouseY);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    playing = false;
  }
}

int[] copy(int[] arr) {
  int[] newArr = new int[arr.length];

  for (int i = 0; i < arr.length; i++) {
    newArr[i] = arr[i];
  }

  return newArr;
}
