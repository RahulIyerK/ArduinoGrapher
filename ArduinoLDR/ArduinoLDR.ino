void setup() {
  Serial.begin(9600);

}

void loop() {
  Serial.println(analogRead(0)); //print analog value from LDR over serial
  delay(2);
}
