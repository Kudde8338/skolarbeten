/*
* Name: övningsprojekt
* Author: Victor Huke
* Date: 2025-10-13
* Description: This project uses a ds3231 to measure time and displays the time to an 1306 oled display, 
* Further, it measures temprature with ds3231 and displays a mapped value to a 9g-servo-motor.
*/

// Include Libraries
#include <RTClib.h>
#include <Wire.h>
#include <Servo.h>
#include "U8glib.h"
#include <math.h>

// Init constants
#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64

// Init global variables
const float max_temp = 30.0;
const float min_temp = 20.0;

// Construct objects
RTC_DS3231 rtc;
Servo myservo;
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

  // Attach servo
  myservo.attach(9);
}

void loop() {
  //oledWrite("Time: " + String(getTime()), 0, 22, "Temp: " + String(getTemp()), 0, 44);   //remove comment when the function is written
  oledAnalogClock(1, 2, 3);
  servoWrite(getTemp());  //remove comment when the function is written

  Serial.println("Time: " + getTime() + " | " + "Temperature: " + getTemp());

  delay(200);
}



//This function reads time from an ds3231 module and package the time as a String
//Parameters: Void
//Returns: time in hh:mm:ss as String
String getTime() {
  DateTime now = rtc.now();
  return String(now.hour()) + ":" + String(now.minute()) + ":" + String(now.second());
}

/*
* This function takes temprature from ds3231 and returns as a float
*Parameters: Void
*Returns: temprature as float 
*/
float getTemp() {
  return rtc.getTemperature();
}

/*
* This function takes a string and draws it to an oled display
*Parameters: - text: String to write to display
*Returns: void
*/
void oledWrite(String time, int x, int y, String temp, int x2, int y2) {
  u8g.firstPage();
  do {
    u8g.drawStr(x, y, time.c_str());
    u8g.drawStr(x2, y2, temp.c_str());
  } while (u8g.nextPage());
}

/*
* takes a temprature value and maps it to corresppnding degree on a servo
*Parameters: - value: temprature
*Returns: void
*/
void servoWrite(float value) {
  myservo.write(map(value, min_temp, max_temp, 0, 180));
}

void oledAnalogClock(int h, int m, int s) {
  int centerX = SCREEN_WIDTH / 2;
  int centerY = SCREEN_HEIGHT / 2;
  int radius = SCREEN_HEIGHT / 2 - 5;

  float hDeg = map(s, 0, 60, 0, 360);

  float theta = hDeg * M_PI / 180.0;

  int x = centerX + radius * cos(theta);
  int y = centerY + radius * sin(theta);

  u8g.firstPage();
  do {
    u8g.drawCircle(centerX, centerY, radius);
    u8g.drawDisc(centerX, centerY, 2);
    u8g.drawLine(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, x, y);
  } while (u8g.nextPage());
}