#include "Joystick.h"
Joystick_ Joystick; 
int inp = 0;
void setup() {
Serial.begin(9600);

Joystick.begin();
Joystick.setXAxisRange(0, 1023);
}

void loop() {
  inp = analogRead(A0);
  Serial.println(inp);
  Joystick.setXAxis(inp);


}
