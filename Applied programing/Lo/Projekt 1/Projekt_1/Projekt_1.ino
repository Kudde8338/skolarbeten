int ledRed = 8;
int ledBlue = 9;
int buttonPin = 7;

int pause = 50;
bool on = false;
int pause2 = 50;

void setup() {
  pinMode(ledRed, OUTPUT);
  pinMode(ledBlue, OUTPUT);
  pinMode(buttonPin, INPUT);
}

void loop() {
  if (digitalRead(buttonPin) == HIGH && on == false) {
    on = true;
    delay(pause2);
  }

  if (digitalRead(buttonPin) == HIGH && on == true) {
    on = false;
    delay(pause2);
  }

  if (on == true) {
    digitalWrite(ledRed, HIGH);
    delay(pause);
    digitalWrite(ledBlue, HIGH);
    digitalWrite(ledRed, LOW);
    delay(pause);
    digitalWrite(ledBlue, LOW);
  }
}