#include <SoftwareSerial.h>
#include <Servo.h>

SoftwareSerial softSerial(11, 10);

Servo base;
Servo left;
Servo right;
Servo claw;

String received = "";

void setup()
{
  Serial.begin(9600);
  softSerial.begin(9600);

  base.attach(7);
  left.attach(6);
  right.attach(5);
  claw.attach(4);

  Serial.println("Starting...");
}

void loop()
{
  if (softSerial.available()) {
    received = softSerial.readStringUntil('\n');
  }

  if (!received.equals("")) {
    char *str = (char*)received.c_str();

    const size_t bufferSize = 5;
    int arr[bufferSize];

    char *p = strtok(str, " ");
    size_t index = 0;

    while (p != nullptr && index < bufferSize) {
      arr[index++] = atoi(p);
      p = strtok(NULL, " ");
    }

    Serial.println(arr[1]);

    left.attach(6);
    if (arr[0] != 2) {
//      base.write(arr[1]);
      left.write(arr[2]);
//      right.write(arr[3]);
//      claw.write(arr[4]);
    }
    left.detach();
  }
}
