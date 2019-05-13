// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 10, 8, 7, 4);

// Temperature Pins
const int temperature_pin = A1;
int RawValue= 0;
double Voltage = 0;
double tempC = 0;

//LDR Pins
int LDR_sensor = A0 ;
int LDR_value = 0;

// 7 seg pins with multiplexer
int DS_14 = A2; //dataPin
int STCP_12 = A3; //clock
int SHCP_11 = A4; //latch

//int led = A5; // led for debug purpose

int k = 0; // count second digit 0-9
int i = 0; // hold temperature number in hex
int d = 0; //decade counter

void setup() {
  Serial.begin(9600);
  // set up the LCD's number of columns and rows:
  lcd.begin(16, 2);
  lcd.clear();
  lcd.print("Ioannis");
  lcd.setCursor(0, 1);
  lcd.print("Katsikavelas");
  delay(2000);
  lcd.clear();
  // set pin modes
  pinMode(STCP_12, OUTPUT);
  pinMode(DS_14, OUTPUT);
  pinMode(SHCP_11, OUTPUT);
  //pinMode(led, OUTPUT);
  // digitalWrite(led, HIGH);
  // delay(1000);
  // digitalWrite(led, LOW);
  // delay(1000);
  digitalWrite(SHCP_11, LOW);
  shiftOut(DS_14, STCP_12, MSBFIRST , 0);
  digitalWrite(SHCP_11, HIGH);
  delay(500);
}

void loop() {
  // set the cursor to column 0, line 1
  // (note: line 1 is the second row, since counting begins with 0):
  lcd.setCursor(0, 1);
  //Read values for the temperature sensor
  int RawValue = analogRead(temperature_pin);
  int tempC=(5.0*RawValue*1000.0)/(1024*10);
  // Serial print the values for debug purposes
  Serial.print("Raw Value = " );  // shows pre-scaled value
  Serial.print(RawValue);
  Serial.print("\t milli volts = "); // shows the voltage measured
  Serial.print(Voltage,0); //
  Serial.print("\t Temperature in C = ");
  Serial.println(tempC);
  Serial.println(int(tempC));

  // // just printing the digits
  // first_digit = int(tempC) / 10 ;
  // Serial.print("The first digit is :  " );
  // Serial.print(first_digit); // Get the first number for the seven seg display
  // second_digit = int(tempC) - (first_digit * 10) ;
  // Serial.print("\tThe second digit is : ");
  // Serial.println(second_digit);
  // Serial.println("\n");

  // Read values for the LDR sensor
  LDR_value = analogRead(LDR_sensor);
  //Print values to the LCD screen
  lcd.setCursor(0, 0);
  lcd.print("The value of LDR is :");
  lcd.setCursor(0, 1);
  lcd.print(LDR_value) ;
  
//  lcd.setCursor(7, 1);
//  lcd.print("T :");   // for debug purposes
//  lcd.print(tempC) ;
  delay(10);
  
  while ( d < tempC) {
    if (k < 9 ) {
      i += 1 ;
      k += 1;
      d +=1;
    }else {
      k = 0 ;
      i += 7 ;
      d += 1;
    }
  }
  digitalWrite(SHCP_11, LOW);
  shiftOut(DS_14, STCP_12, MSBFIRST , i);
  digitalWrite(SHCP_11, HIGH);

  delay(300000); // 5 min delay (60sec * 5 )
  // Turn diplay and 7 seg off
  lcd.noDisplay();
  digitalWrite(SHCP_11, LOW);
  shiftOut(DS_14, STCP_12, LSBFIRST , -1);
  digitalWrite(SHCP_11, HIGH);

  exit(0);

}
