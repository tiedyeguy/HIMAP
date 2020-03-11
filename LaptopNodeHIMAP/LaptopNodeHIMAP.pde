import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import processing.serial.*;
import cc.arduino.*;

ControlDevice ps4;
ControlIO control;
Arduino arduino;
Serial esp;

int action;
int leftX, leftY, rightX;
boolean prevSavePressed, prevPlayPressed;
boolean savePressed, playPressed;
int[] armPos;
int inByte;
boolean firstContact = false;

void setup() {
  control = ControlIO.getInstance(this);
  ps4 = control.getMatchedDevice("ps4");

  if (ps4 == null) {
    println("PS4 controller not connected.");
    System.exit(-1);
  }

  esp = new Serial(this, "COM12", 57600);
  arduino = new Arduino(this, "COM4", 57600);

  armPos = new int[4];

  frameRate(57600); //?????????????????????????????????????

  delay(1000);
}

void draw() {
  if (esp.available() > 0) {
    getUserInput();

    if (savePressed && !prevSavePressed)
      action = 1;
    else if (playPressed && !prevPlayPressed)
      action = 2;
    else
      action = 0;

    inByte = esp.read();

    if (inByte != 0)
      println(inByte);

    if (!firstContact) {
      if (inByte == 1) {
        esp.clear();
        firstContact = true;
      }
    } else {
      sendData();
    }

    prevSavePressed = savePressed;
    prevPlayPressed = playPressed;
  }
}

void getUserInput() {
  for (int i = 0; i < armPos.length; i++) {
    armPos[i] = arduino.analogRead(i) / 4;
  }

  leftX = int(100.0 * ps4.getSlider("leftX").getValue()) + 100;
  leftY = -int(100.0 * ps4.getSlider("leftY").getValue()) + 100;
  rightX = int(100.0 * ps4.getSlider("rightX").getValue()) + 100;

  savePressed = ps4.getButton("saveButton").pressed();
  playPressed = ps4.getButton("playButton").pressed();
}

void sendData() {
  esp.write(action);
  esp.write(leftX);
  esp.write(leftY);
  esp.write(rightX);
  esp.write(armPos[0]);
  esp.write(armPos[1]);
  esp.write(armPos[2]);
  esp.write(armPos[3]);
}
