//import processing.serial.*;

//Serial esp;

//Slider[] sliders;
//Button saveButton, playButton;

//int action;
//boolean prevSavePressed, prevPlayPressed;
//boolean savePressed, playPressed;
//int[] armPos;
//int inByte;
//boolean firstContact = false;

//void setup() {
//  size(400, 280);

//  //esp = new Serial(this, "COM12", 57600);

//  sliders = new Slider[4];
//  PVector sliderRange = new PVector(0, 100);
//  sliders[0] = new Slider(50, sliderRange, new PVector(20, 100), 250, "Base");
//  sliders[1] = new Slider(50, sliderRange, new PVector(20, 150), 250, "Left");
//  sliders[2] = new Slider(50, sliderRange, new PVector(20, 200), 250, "Right");
//  sliders[3] = new Slider(100, sliderRange, new PVector(20, 250), 250, "Claw");

//  saveButton = new Button(new PVector (20, 15), new PVector(170, 50), "Save");
//  playButton = new Button(new PVector (210, 15), new PVector(170, 50), "Play");

//  armPos = new int[4];

//  frameRate(57600); //?????????????????????????????????????

//  delay(1000);
//}

//void draw() {
//  //if (esp.available() > 0) {
//  for (int i = 0; i < sliders.length; i++) {
//    armPos[i] = int(map(sliders[i].value, 0, 100, 0, 180));
//  }

//  savePressed = saveButton.isClicked;
//  playPressed = playButton.isClicked;

//  if (savePressed && !prevSavePressed)
//    action = 1;
//  else if (playPressed && !prevPlayPressed)
//    action = 2;
//  else
//    action = 0;

//  if (action!=0)
//    println(action + " " + armPos[3]);

//  //  inByte = esp.read();

//  //  if (inByte != 0)
//  //    println(inByte);

//  //  if (!firstContact) {
//  //    if (inByte == 1) {
//  //      esp.clear();
//  //      firstContact = true;
//  //    }
//  //  } else {
//  //    sendData();
//  //  }

//  prevSavePressed = savePressed;
//  prevPlayPressed = playPressed;
//  //}

//  background(255);

//  for (int i = 0; i < sliders.length; i++) {
//    sliders[i].update();
//    sliders[i].draw();
//  }

//  saveButton.draw();
//  playButton.draw();
//}

//void sendData() {
//  esp.write(action);
//  esp.write(armPos[0]);
//  esp.write(armPos[1]);
//  esp.write(armPos[2]);
//  esp.write(armPos[3]);
//}

//void mousePressed() {
//  for (int i = 0; i < sliders.length; i++) {
//    sliders[i].isSelected = sliders[i].isOverHandle(mouseX, mouseY);
//  }

//  saveButton.isClicked = saveButton.isOver(mouseX, mouseY);
//  playButton.isClicked = playButton.isOver(mouseX, mouseY);
//}

//void mouseReleased() {
//  for (int i = 0; i < sliders.length; i++) {
//    sliders[i].isSelected = false;
//  }

//  saveButton.isClicked = false;
//  playButton.isClicked = false;
//}
