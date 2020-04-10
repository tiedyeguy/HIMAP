/*
    This sketch sends a message to a TCP server

*/

#include <ESP8266WiFi.h>
#include <ESP8266WiFiMulti.h>
#include <SoftwareSerial.h>

ESP8266WiFiMulti WiFiMulti;
WiFiClient client;
SoftwareSerial softSerial(4, 5);

String line;

void setup() {
  Serial.begin(9600);
  softSerial.begin(9600);
  delay(10);

  // We start by connecting to a WiFi network
  WiFiMulti.addAP("NETGEAR82", "#$RT1975Kpmg$");

  Serial.println();
  Serial.println();
  Serial.print("Wait for WiFi... ");

  while (WiFiMulti.run() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  delay(500);

  const uint16_t port = 12345;
  const char * host = "67.220.19.208"; // ip or dns

  Serial.print("connecting to ");
  Serial.println(host);

  while (!client.connect(host, port)) {
    Serial.println("connection failed");
    Serial.println("wait 5 sec...");
    delay(5000);
    return;
  }
}


void loop() {
  line = client.readStringUntil('\n');
  Serial.println(line);
  softSerial.println(line);

  delay(50);
}
