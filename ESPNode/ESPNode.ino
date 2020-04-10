#include <ESP8266WiFi.h>
#include <ESP8266WiFiMulti.h>
#include <Servo.h>

ESP8266WiFiMulti WiFiMulti;
WiFiClient client;

Servo base;
Servo left;
Servo right;
Servo claw;

String received = "";

void setup() {
  Serial.begin(9600);

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

  base.attach(5);
  left.attach(4);
  right.attach(14);
  claw.attach(12);
}


void loop() {
  received = client.readStringUntil('\n');
  Serial.println(received);

  if (!received.equals("")) {
    char *str = (char*)received.c_str();

    const size_t bufferSize = 4;
    int arr[bufferSize];

    char *p = strtok(str, " ");
    size_t index = 0;

    while (p != nullptr && index < bufferSize) {
      arr[index++] = atoi(p);
      p = strtok(NULL, " ");
    }

    base.write(arr[0]);
    left.write(arr[1]);
    right.write(arr[2]);
    claw.write(arr[3]);
  }

  delay(50);
}
