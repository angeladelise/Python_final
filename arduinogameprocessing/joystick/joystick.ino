
const int switchPin = 2; // digital pin connected to switch output
const int xPin = 0; // analog pin connected to X output
const int yPin = 1; // analog pin connected to Y output
int led = 9;
 
void setup() {
  pinMode(switchPin, INPUT);
  pinMode(led, INPUT);
  digitalWrite(switchPin, HIGH);
  Serial.begin(250000);
}
 
void loop() {
  int xPos = map(analogRead(xPin), 0, 1023, -9, 10); 
  Serial.print(xPos);
  Serial.print("\n");
 int yPos = map(analogRead(yPin), 0, 1023, -9, 10); 
 Serial.print(yPos);
  Serial.print("\n");
  delay(500);

  if (xPos > 0){
    digitalWrite(led, HIGH);
    }
  else{
    digitalWrite(led, LOW);
    }
 
}
