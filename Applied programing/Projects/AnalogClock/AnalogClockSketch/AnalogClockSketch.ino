/*
* Name: Analog Clock
* Author: Sydney Myrén
* Date: 2025-10-20
* Description: This project uses a ds3231 to measure time and displays the analog time to an 1306 oled display.
*/

// Include Libraries
#include <RTClib.h>
#include <Wire.h>
#include "U8glib.h"
#include <math.h>

// Init constants
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64

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
}

void loop() {
  oledAnalogClock(getHour(), getMinute(), getSecond());
}

int getHour(){
  DateTime now = rtc.now();
  return now.hour();
}

int getMinute(){
  DateTime now = rtc.now();
  return now.minute();
}

int getSecond(){
  DateTime now = rtc.now();
  return now.second();
}

void oledAnalogClock(int h, int m, int s) {
  int centerX = SCREEN_WIDTH / 2;
  int centerY = SCREEN_HEIGHT / 2;

  int secondRadius = SCREEN_HEIGHT / 2 - 5;
  int hourRadius = secondRadius/2;
  int minuteRadius = secondRadius*0.75;

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
    u8g.drawCircle(centerX, centerY, secondRadius);
    u8g.drawDisc(centerX, centerY, 2);

    u8g.drawLine(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, minuteX, minuteY);
    u8g.drawLine(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, hourX, hourY);
    u8g.drawLine(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, secondX, secondY);

  } while (u8g.nextPage());
}