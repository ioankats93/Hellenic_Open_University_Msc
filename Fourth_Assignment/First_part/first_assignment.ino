/*
	### Εργασία 4η - Άσκηση 1η ###
    # Κατσικαβέλας Ιωάννης #

  The circuit:
 * LCD RS pin to digital pin 12
 * LCD Enable pin to digital pin 11
 * LCD D4 pin to digital pin 5
 * LCD D5 pin to digital pin 4
 * LCD D6 pin to digital pin 3
 * LCD D7 pin to digital pin 2
 * LCD R/W pin to ground
 * LCD VSS pin to ground
 * LCD VCC pin to 5V
 * 10K resistor:
 * ends to +5V and ground
 * wiper to LCD VO pin (pin 3)

 http://www.arduino.cc/en/Tutorial/LiquidCrystal
 */

// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// GAS Warnign LEDs
int const GAS_PIN = A1;
int LED_GREEN = 10;
int LED_YELLOW = 9;
int LED_RED = 8;

// PIR Sensor Pins
int LED_FOR_PIR = 13;
int PIR_INPUT = 7 ;

int val = 0;

// Ultrasonic Sensor
int cm = 0;
int const ULTRASONIC_PIN = 6 ;

// function for unltrasonic sensor
long readUltrasonicDistance(int pin)
{
  pinMode(pin, OUTPUT);  // Clear the trigger
  digitalWrite(pin, LOW);
  delayMicroseconds(2);
  // Sets the pin on HIGH state for 10 micro seconds
  digitalWrite(pin, HIGH);
  delayMicroseconds(10);
  digitalWrite(pin, LOW);
  pinMode(pin, INPUT);
  // Reads the pin, and returns the sound wave travel time in microseconds
  return pulseIn(pin, HIGH);
}

void setup(){
  	pinMode(LED_FOR_PIR, OUTPUT); // declare LED as OUTPUT
  	pinMode(PIR_INPUT, INPUT);

  	pinMode(LED_GREEN, OUTPUT);
    pinMode(LED_YELLOW, OUTPUT);
    pinMode(LED_RED, OUTPUT);

    pinMode(ULTRASONIC_PIN, INPUT);

    Serial.begin(9600);
  	Serial.println("ALARM is ON");
  	// set up the LCD's number of columns and rows:
  	lcd.begin(16, 2);
  	// Print a message to the LCD.
    lcd.setCursor(2, 0);
  	lcd.print("ALARM is ON");
    delay(700);
    lcd.clear();
    delay(10);
}

void loop(){
    val = digitalRead(PIR_INPUT);
    if (val == HIGH) {
      digitalWrite(13, HIGH);
      lcd.setCursor(0, 0);
      lcd.print("PIR ON ");
      Serial.println("\n");
      Serial.println("WARNING: The PIR Sensor got Triggered, possible Violation");
      delay(800);
      }else {
      digitalWrite(13, LOW);
      lcd.setCursor(0, 0);
      lcd.print("PIR OFF");
      delay(10);
      }

    int valor = analogRead(GAS_PIN);
    valor = map(valor, 300, 750, 0, 100);
    if (valor >= 40 && valor <= 60)
    {
      digitalWrite(LED_YELLOW, HIGH);
      digitalWrite(LED_RED, LOW);
      lcd.setCursor(8, 0);
      lcd.print("GAS WARNING");
      Serial.println("\n");
      Serial.println("WARNING: The GAS Sensor got Triggered, possible Gas leakage");
    }else if (valor > 60){
      digitalWrite(LED_YELLOW, HIGH);
      digitalWrite(LED_RED, HIGH);
      lcd.setCursor(8, 0);
      lcd.print("GAS DANGER");
      Serial.println("\n");
      Serial.println("WARNING: The GAS Sensor got Triggered, Gas leakage");
    }else {
      digitalWrite(LED_GREEN, HIGH);
      digitalWrite(LED_YELLOW, LOW);
      digitalWrite(LED_RED, LOW);
      lcd.setCursor(8, 0);
      lcd.print("GAS OK  ");
    }
  	delay(10);

    // measure the ping time in cm
    cm = 0.01723 * readUltrasonicDistance(6);
    lcd.setCursor(0, 1);
    lcd.print("Distance=");
    lcd.setCursor(9, 1);
    lcd.print(cm);
    lcd.print(" cm");
    if (cm <= 40){
      digitalWrite(13, HIGH);
      delay(500);
      Serial.println("WARNING: The Ultrasonic Sensor got Triggered, possible Violation");
      Serial.println("The distance is " + cm);
    }
    delay(10); // Wait for 10 millisecond(s)
}
