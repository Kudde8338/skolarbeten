
// MQTT Libraries
#include <WiFi.h>
#include "Adafruit_MQTT.h"
#include "Adafruit_MQTT_Client.h"
#include <ESP32Servo.h>

// MQTT Constants
const char *SSID = "MakarN.net";
const char *PASSWORD = "NasirForPresident2024";

const char *BROKER_IP = "192.168.1.131";
const int BROKER_PORT = 1883;
const char *CAPACITY_TOPIC = "trashcan/capacity";
const char *OPEN_TOPIC = "trashcan/open";

// The depth of the trash can when empty
const int emptyDistance = 30;

// Declare pins
// Open/Close sensor
const int openEcho = 32;
const int openTrig = 33;
// Capacity Sensor
const int capacityEcho = 25;
const int capacityTrig = 26;
// Servo signal pin
const int servoPin = 27;

bool isOpen = false;

// Create servo object to controll lid
Servo lidServo;

// Create an ESP32 WiFiClient class to connect to the MQTT server.
WiFiClient client;

// Setup the MQTT client
Adafruit_MQTT_Client mqtt(&client, BROKER_IP, BROKER_PORT);

// Setup the MQTT publisher
Adafruit_MQTT_Publish capacity_publisher = Adafruit_MQTT_Publish(&mqtt, CAPACITY_TOPIC);
Adafruit_MQTT_Publish open_publisher = Adafruit_MQTT_Publish(&mqtt, OPEN_TOPIC);

void setup() {
  Serial.begin(115200);
  while (!Serial) {delay(100);}

  // Initiate pins
  // Open/Close sensor
  pinMode(openEcho, INPUT);
  pinMode(openTrig, OUTPUT);
  // Capacity sensor
  pinMode(openEcho, INPUT);
  pinMode(openTrig, OUTPUT);
  // Servo pin
  //pinMode(servoPin, OUTPUT);
  lidServo.setPeriodHertz(50);
  lidServo.attach(servoPin);

  connectToWifi(SSID, PASSWORD);
  
}

void connectToWifi(const char *networkSSID, const char *networkPasskey) {
  WiFi.mode(WIFI_STA);

  WiFi.begin(networkSSID, networkPasskey);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("Connected");
}

void loop() {
  Serial.println(shouldOpen());
  if (shouldOpen() && !isOpen) {
    openLid();
    isOpen = true;
    publishOpen(isOpen);
    delay(10);
  } 
  if (!shouldOpen() && isOpen) {
    closeLid();
    publishCapacity(getCapacity());
    isOpen = false;
    delay(10);
  }
}

bool shouldOpen() {
  digitalWrite(openTrig, LOW);
  delayMicroseconds(2);
  digitalWrite(openTrig, HIGH);
  delayMicroseconds(10);
  digitalWrite(openTrig, LOW);

  float duration = pulseIn(openEcho, HIGH);
  float distance = (duration * .0343) / 2;

  isOpen = !isOpen;

  if (distance < 30) {
    return true;
  } else {
    return false;
  }
}

float getCapacity() {
  digitalWrite(capacityTrig, LOW);
  delayMicroseconds(2);
  digitalWrite(capacityTrig, HIGH);
  delayMicroseconds(10);
  digitalWrite(capacityTrig, LOW);

  float duration = pulseIn(capacityEcho, HIGH, 3000000);
  float distance = (duration * .0343) / 2;

  return ((emptyDistance - distance) / emptyDistance)*100;
}

void openLid() {
  lidServo.write(180);
  delay(500);
}

void closeLid() {
  lidServo.write(0);
  delay(500);
}

void screenData() {
  // report data to screen
}

void publishCapacity(float capacity) {
  char capacity2[40];
  sprintf(capacity2, "%.2f%", capacity);
  if (!capacity_publisher.publish(capacity2)) {
    Serial.println(F("Failed"));
  }
}

void publishOpen(float open) {
  if (!open_publisher.publish(open)) {
    Serial.println(F("Failed"));
  }
}

void MQTT_connect() {
  int8_t ret;

  // Stop if already connected.
  if (mqtt.connected()) {
    return;
  }

  Serial.print("Connecting to MQTT... ");

  uint8_t retries = 3;
  while ((ret = mqtt.connect()) != 0) { // connect will return 0 for connected
       Serial.println(mqtt.connectErrorString(ret));
       Serial.println("Retrying MQTT connection in 5 seconds...");
       mqtt.disconnect();
       delay(5000);  // wait 5 seconds
       retries--;
       if (retries == 0) {
         // basically die and wait for WDT to reset me
         while (1);
       }
  }
  Serial.println("MQTT Connected!");
}
