#include <ESP32Servo.h>

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
  
}

void loop() {
  Serial.println(shouldOpen());
  if (shouldOpen() && !isOpen) {
    openLid();
    isOpen = true;
    delay(10);
    mqttData();
  } 
  if (!shouldOpen() && isOpen) {
    closeLid();
    isOpen = false;
    delay(10);
    mqttData();
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

void mqttData() {
  // report data via mqtt
}
