#include <ESP8266WiFi.h>

char ssid[] = "HIMAP";
char pass[] = "sayhitohimap";

IPAddress server(192, 168, 4, 15);
WiFiClient client;

int inByte;
int serialInArray[8];
int serialCount = 0;
int action;
int leftX, leftY, rightX;
int armPos[4];

int responseInt;
String response;

void setup()
{
  Serial.begin(57600);
  establishContact();

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, pass);
}

void loop()
{
  if (Serial.available() > 0) {
    inByte = Serial.read();

    serialInArray[serialCount] = inByte;
    serialCount++;

    if (serialCount > 7) {
      action = serialInArray[0];
      leftX = serialInArray[1];
      leftY = serialInArray[2];
      rightX = serialInArray[3];
      armPos[0] = serialInArray[4];
      armPos[1] = serialInArray[5];
      armPos[2] = serialInArray[6];
      armPos[3] = serialInArray[7];

      Serial.write(action);

      serialCount = 0;

      client.connect(server, 80);

      sendData();

      response = client.readStringUntil('\r');
      responseInt = response.toInt();

      while (responseInt != action) {
        sendData();

        response = client.readStringUntil('\r');
        responseInt = response.toInt();
      }

      client.flush();
      //      client.stop();
    }
  }
}

void sendData() {
  client.print(String(action) + " " +
               String(leftX) + " " +
               String(leftY) + " " +
               String(rightX) + " " +
               String(armPos[0]) + " " +
               String(armPos[1]) + " " +
               String(armPos[2]) + " " +
               String(armPos[3]) + "\r");
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.write(1);
    delay(300);
  }
}
