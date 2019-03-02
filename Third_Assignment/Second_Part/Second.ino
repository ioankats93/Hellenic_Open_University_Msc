/* 
This is the seconds part of the third assignment of the Degree Embedded system design and microcontroller applications for the Internet of Things.


Implement the circuit that includes the simple switch, the motor servo, the ldr resistor and the external led.
When the program is running, the servo will sweep from -90 degrees to +90 degrees and vice versa,
while the LED will remain off until the switch is pressed momentarily. When this is done, the servo
will stop, the LED will be triggered for 2 seconds, and we have to read the voltage at the edges of the ldr resistor
and print it on the serial console. Then the program will restart the servo until the switch will be pressed again.
*/

#include <Servo.h>

const int buttonPin = 5 ; // the number of the push Butoon pin 
const int ledPin = 0 ; // the number of LED pin
const int LDR_Pin = 7 ; // The number of LDR Pin

int buttonState = LOW ; // variable for reading the tactile sitch 
int sweepState = LOW ; // variable to know where the servo is heading to 90 or to -90
float ldrVoltage = 0 ; // variable for the LDR voltage 

Servo myservo;  // create servo object to control a servo
int pos = 0;    // variable to store the servo position

void setup() {
  myservo.attach(11);  // attaches the servo on pin 9 to the servo object
  pinMode(ledPin, OUTPUT) ; //Init the Led pin
  pinMode(buttonPin, INPUT) ; // Init the push Button pin as an input  
  Serial.begin(9600); // Init the Serial communication
}


void loop() {

buttonState = digitalRead(buttonPin); // Check if Button is pressed

/*  If tactile switch  is NOT pressed then the servo turns to sweepState direction with pace 1.
 *  checks again if the button is pressed.
 *  If servo reaches + 90 or -90 then the sweep state is changed to different direction.
 *  sweepState == LOW => servo moves to + 90 | sweepState == HIGH => servo moves to - 90.
 *  If the buttonState is TRUE (button is pressed) then the led is on and we can see the Voltage across the LDR
 *  on the Serial Screen.
 */ 
if (buttonState == LOW && pos < 180 && sweepState == LOW) {
   myservo.write(pos);  // tell servo to go to position in variable 'pos'
   delay(15); 
   pos += 1 ;
   buttonState = digitalRead(buttonPin); // Check if Button is pressed
   if (pos >= 180){
    sweepState = HIGH; 
   }
} else if (buttonState == LOW && sweepState == HIGH) {
   myservo.write(pos);  // tell servo to go to position in variable 'pos'
   delay(15);
   pos -= 1 ;
   buttonState = digitalRead(buttonPin); // Check if Button is pressed
   if (pos < -1 ){
    sweepState = LOW;
   }
} else if (buttonState == HIGH) { // This gets done if the button is pressed 
  digitalWrite(ledPin, HIGH); // Led is On for 2 seconds.
  delay(2000);
  digitalWrite(ledPin, LOW); // Led is off again.
  Serial.print("Value of LDR is : ");
  Serial.println(analogRead(LDR_Pin)) ; //print the values from LDR 
  ldrVoltage = analogRead(LDR_Pin) ;  // Read tje values from LDR
  float voltage = ldrVoltage * (5 /4040.0); // calculate to voltage
  Serial.print("The voltage across the LDR is: " ) ;
  Serial.print(voltage) ; 
  Serial.println(" Volts") ; //Print the vltage across the LDR
  }
 //Serial.println(pos); //print position of the Servo
}
