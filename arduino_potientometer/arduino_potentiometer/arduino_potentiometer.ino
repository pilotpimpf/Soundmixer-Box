#include "Joystick.h"
Joystick_ Joystick;

void setup()
{
  Serial.begin(9600);

  Joystick.begin();
  Joystick.setXAxisRange(0, 1023);
  Joystick.setYAxisRange(0, 1023);
  Joystick.setZAxisRange(0, 1023);
  Joystick.setThrottleRange(0,1023);
}

void loop()
{
  Joystick.setXAxis(analogRead(A0));
  Joystick.setYAxis(analogRead(A1));
  Joystick.setZAxis(analogRead(A2));
  Joystick.setThrottle(analogRead(A3));
}
