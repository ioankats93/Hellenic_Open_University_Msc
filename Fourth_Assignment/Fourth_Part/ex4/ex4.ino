//open serial monitor to see what the arduino receives
//W5100 based ethernet shield is used

#include <SPI.h>
#include <Ethernet.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27,16,2);

#include <TroykaDHT.h>
#define DHTPIN 8
#define DHTTYPE DHT22

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED }; //physical mac address
IPAddress ip(194, 24, 226, 83);
IPAddress dnS(194, 24, 226, 35);
IPAddress gw(194, 24, 226, 65);
IPAddress mask(255, 255, 255, 192);
EthernetServer server(80); //server port

// ThingSpeak Settings
char thingSpeakAddress[] = "api.thingspeak.com";
String writeAPIKey = "JE4ARUGYOB0Y5Q1I";
const int updateThingSpeakInterval = 16 * 1000;
IPAddress tsip ; //thingspeak IP

// DHT
DHT dht(DHTPIN, DHTTYPE);
String temp ;
String hum ;
double temperature;
double humidity ;

// Variable to store the HTTP request
String header;

// Variable Setup
long lastConnectionTime = 0;
boolean lastConnected = false;
int failedCounter = 0;

// Auxiliar variables to store the current output state
String outputState = "off";
const int led = 9 ;
EthernetClient client = server.available();

void setup(){
  //start Ethernet
  Ethernet.begin(mac, ip, dnS, gw, mask);
  server.begin();
  delay(100);
  dht.begin();
  delay(100);
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0,0);
  lcd.print("Ioannis");
  lcd.setCursor(0,1);
  lcd.print("Katsikavelas");
  delay(1000);
  lcd.clear();
  lcd.setCursor(1,0);
  lcd.print("Fourth");
  lcd.setCursor(0,1);
  lcd.print("assignment");
  delay(1000);
  lcd.clear();
  //enable serial data print
  Serial.begin(57600);
  Serial.println("Ioannis Katsikavelas - 4th exercise from fourth assignment\n");
  Serial.print("The IP is : ");
  Serial.println(Ethernet.localIP());
  if (client.connect(thingSpeakAddress, 80)){
    tsip = client.remoteIP();
    Serial.print("ThingSpeak Server IP is : "); Serial.println(tsip);
    client.stop();
  }
  Serial.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
}

void loop(){
  // Create a client connection
  if (client.available()) {
    char c = client.read();
    Serial.write(c);
  }
  if(!client.connected() && lastConnected)
  {
    Serial.println("..disconnected");
    Serial.println("");

    client.stop();
  }
  // Update ThingSpeak
  if(!client.connected() && (millis() - lastConnectionTime > updateThingSpeakInterval))
  {
    dht.read();
    Serial.println("+++++++++++++++++++++++++++++++++++");
    Serial.print("Temperature = ");
    temperature =  dht.getTemperatureC();
    Serial.print(temperature);
    Serial.println(" C \t");
    Serial.print("Humidity = ");
    humidity = dht.getHumidity() ;
    Serial.print(humidity);
    Serial.println(" %");
    Serial.print("+++++++++++++++++++++++++++++++++++\n");
    delay(1000);
    temp = String(temperature);
    hum = String(humidity);
    String tsData = String("field1="+temp+"&field2="+hum);
    lcd.setCursor(0,0);   //Print temp and humidity on LCD
    lcd.print("Temp : ");lcd.print(temperature);lcd.print(" C ");
    lcd.setCursor(0,1);
    lcd.print("Humi : ");lcd.print(humidity);lcd.print(" % ");
    updateThingSpeak(tsData);
  }
}

void updateThingSpeak(String tsData)
{
  if (client.connect(thingSpeakAddress, 80))
  {
    client.print("POST /update HTTP/1.1\n");
    client.print("Host: api.thingspeak.com\n");
    client.print("Connection: close\n");
    client.print("X-THINGSPEAKAPIKEY: "+ writeAPIKey +"\n");
    client.print("Content-Type: application/x-www-form-urlencoded\n");
    client.print("Content-Length: ");
    client.print(tsData.length());
    client.print("\n\n");

    client.print(tsData);

    lastConnectionTime = millis();

    if (client.connected())
    {
      Serial.println("Connecting to ThingSpeak Server");
      Serial.println();

      failedCounter = 0;
    }
    else
    {
      failedCounter++;

      Serial.println("Connection to ThingSpeak failed ("+String(failedCounter, DEC)+")");
      Serial.println();
    }

  }
  else
  {
    failedCounter++;

    Serial.println("Connection to ThingSpeak Failed ("+String(failedCounter, DEC)+")");
    Serial.println();

    lastConnectionTime = millis();
  }
}
