int led=8,beep = 7,btn=5;
void setup() {
  // put your setup code here, to run once:
  pinMode(beep,OUTPUT);
  pinMode(led,OUTPUT);  
}

void loop() {
  // put your main code here, to run repeatedly:
  int val=analogRead(btn);
  if(val>1000){
    digitalWrite(led,HIGH);
    for (int i=0;i<100;i++){
      digitalWrite(beep,HIGH);delay(2);
      digitalWrite(beep,LOW);delay(2);
    }
  }else{
    digitalWrite(led,LOW);
    digitalWrite(beep,LOW);
  }
}
