#include <LiquidCrystal.h>
LiquidCrystal lcd(12,11,5,4,3,2);
int inputPin = 9 ,outputPin = 10;
void setup() {
//  put your setup code here, to run once:
  pinMode(inputPin,INPUT);
  pinMode(outputPin,OUTPUT);
  lcd.begin(16,2);
  delay(1000);
}
void loop() {
  // put your main code here, to run repeatedly:
   digitalWrite(outputPin,LOW);
   delayMicroseconds(2);
   digitalWrite(outputPin,HIGH);
   delayMicroseconds(10);
   digitalWrite(outputPin,LOW);
   int distance = pulseIn(inputPin,HIGH);
   distance = distance/58;
   lcd.clear();
    lcd.print ("Distance");
    lcd.setCursor(0,1);
   lcd.print (distance);
   lcd.print ("CM");
   delay(2000);
}
