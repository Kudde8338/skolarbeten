/*
* Name: Analog Clock
* Author: Sydney Myrén
* Date: 2025-10-20
* Description: This project uses a ds3231 to measure time and displays the analog time to an 1306 oled display. It also has a function for setting an alarm.
*/

// Include Libraries
#include <RTClib.h>
#include <Wire.h>
#include "U8glib.h"
#include <math.h>

// Init constants
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64

// Variables for alarmsetting
bool alarm = false;
int alarmHour = 0;
int alarmMinute = 0;

String hours[24] = { "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23" };
String minutes[60] = { "00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59" };

// Peripherals
const int buzzerPin = 6;
const int buttonPin = 7;

// Construct objects
RTC_DS3231 rtc;
U8GLIB_SSD1306_128X64 u8g(U8G_I2C_OPT_NONE);

void setup() {
  // init communication
  Serial.begin(9600);
  Wire.begin();

  u8g.setFont(u8g_font_unifont);

  // Init Hardware
  rtc.begin();

  // Settings
  rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));

  // Set buzzer as input
  pinMode(buzzerPin, OUTPUT);
  // Set button as input
  pinMode(buttonPin, INPUT);
}

void loop() {
  oledAnalogClock(getHour(), getMinute(), getSecond());
  if (digitalRead(buttonPin) == HIGH) {
    setAlarm();
    delay(100);
    Serial.println("Pressed");
  }
  if ((getHour() == alarmHour) && (getMinute() == alarmMinute)) {
    soundAlarm();
  }
}

//This function reads the hour from a ds3231
//Parameters: Void
//Returns: hour as int
int getHour() {
  DateTime now = rtc.now();
  return now.hour();
}

//This function reads the minute from a ds3231
//Parameters: Void
//Returns: minute as int
int getMinute() {
  DateTime now = rtc.now();
  return now.minute();
}

//This function reads the second from a ds3231
//Parameters: Void
//Returns: second as int
int getSecond() {
  DateTime now = rtc.now();
  return now.second();
}

//This function displays the time as an analog clock on a oled display
//Parameters: hour as int, minute as int, second as int
//Returns: void
void oledAnalogClock(int h, int m, int s) {
  int centerX = SCREEN_WIDTH / 2;
  int centerY = SCREEN_HEIGHT / 2;

  if (alarm == true) {
    centerX += 25;
  }

  int secondRadius = SCREEN_HEIGHT / 2 - 5;
  int hourRadius = secondRadius / 2;
  int minuteRadius = secondRadius * 0.75;

  // Calculate minute coords
  float mDeg = (m + s / 60.0) * 6 - 90;
  float minuteTheta = mDeg * M_PI / 180.0;

  int minuteX = centerX + minuteRadius * cos(minuteTheta);
  int minuteY = centerY + minuteRadius * sin(minuteTheta);

  // Calculate hour coords
  float hDeg = ((h % 12) + m / 60.0) * 30 - 90;
  float hourTheta = hDeg * M_PI / 180.0;

  int hourX = centerX + hourRadius * cos(hourTheta);
  int hourY = centerY + hourRadius * sin(hourTheta);

  // Calculate second coords
  float sDeg = map(s, 0, 60, 0, 360) - 90;
  float secondTheta = sDeg * M_PI / 180.0;

  int secondX = centerX + secondRadius * cos(secondTheta);
  int secondY = centerY + secondRadius * sin(secondTheta);

  u8g.firstPage();
  do {
    if (alarm == true) {
      u8g.drawStr(8, 22, "ALARM");
      u8g.drawStr(8, 38, hours[alarmHour].c_str());
      u8g.drawStr(23, 38, ":");
      u8g.drawStr(31, 38, minutes[alarmMinute].c_str());
    }
    u8g.drawCircle(centerX, centerY, secondRadius);
    u8g.drawDisc(centerX, centerY, 2);

    u8g.drawLine(centerX, centerY, minuteX, minuteY);
    u8g.drawLine(centerX, centerY, hourX, hourY);
    u8g.drawLine(centerX, centerY, secondX, secondY);

  } while (u8g.nextPage());
}

//This function sounds the alarm and disables it on a buttonpress
//Parameters: Void
//Returns: void
void soundAlarm() {
  while (digitalRead(buttonPin) != HIGH) {
    tone(buzzerPin, 1000);
    delay(200);
    noTone(buzzerPin);
    delay(200);
  }
  noTone(buzzerPin);
  alarm = false;
}

//This function sets the alarm
//Parameters: Void
//Returns: void
void setAlarm() {

  String HM = "hour";
  alarmHour = -1;
  alarmMinute = 0;


  while (HM == "hour") {
    if (digitalRead(buttonPin) == HIGH) {
      delay(700);
      if (digitalRead(buttonPin) == HIGH) {
        HM = "minute";
        delay(1500);
      } else {
        alarmHour += 1;
      }
    }

    u8g.firstPage();
    do {
      u8g.drawStr(42, 36, "ALARM");

      u8g.drawStr(42, 52, hours[alarmHour].c_str());
      u8g.drawStr(58, 52, ":");
      u8g.drawStr(66, 52, minutes[alarmMinute].c_str());
    } while (u8g.nextPage());
  }

  while (HM == "minute") {
    if (digitalRead(buttonPin) == HIGH) {
      delay(700);
      if (digitalRead(buttonPin) == HIGH) {
        HM = "done";
        alarm = true;
        delay(1500);
      } else {
        alarmMinute += 1;
      }
    }

    u8g.firstPage();
    do {
      u8g.drawStr(42, 36, "ALARM");

      u8g.drawStr(42, 52, hours[alarmHour].c_str());
      u8g.drawStr(58, 52, ":");
      u8g.drawStr(66, 52, minutes[alarmMinute].c_str());
    } while (u8g.nextPage());
  }
}