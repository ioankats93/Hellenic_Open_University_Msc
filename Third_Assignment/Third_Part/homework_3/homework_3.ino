int RawValue= 0;
double Voltage = 0;   // init values for TMP36 
double tempC = 0;
double tempF = 0;

double DHT11tempF = 0;
double DHT11tempC = 0 ; // init values for DHT11
double DHT11Humidity = 0;
float CelciusDiff = 0 ;

float FahrDiff = 0 ;  // init sensor difference values

unsigned long myChannelNumber = 706790;     // ThingSpeak channel
String apiKey = "83Q0AKCZCCOBH005";  // ThingSpeak API
const char* server = "api.thingspeak.com";

#include "ESP8266WiFi.h"
#include <ESP8266WebServer.h>
#include <dht.h>            // include libraries for ESP8266, DHT

WiFiClient client ;
dht DHT; 

#define DHT11_PIN 2


// TMP36 Pin Variables
int analogIn = 0;

const char* ssid     = "Wu-Tang LAN";         // The SSID (name) of the Wi-Fi 
const char* password = "password";     // The password of the Wi-Fi network

void setup() {
  Serial.begin(115200);
  delay(10);
  
  String thisBoard= ARDUINO_BOARD;  // Get name of board that i being used 
  Serial.print("The board is : ");
  Serial.println(thisBoard);  Serial.print(" ");

  // Set WiFi to station mode and disconnectif it was previously connected
  WiFi.mode(WIFI_STA);
  WiFi.disconnect();
  delay(100);

  Serial.println("Setup done\n");
  Serial.println("Wifi Scanning...");
  // WiFi.scanNetworks will return the number of networks found an then print them
  int n = WiFi.scanNetworks();
  Serial.println("scan done");
  if (n == 0) {
    Serial.println("no networks found");
  } else {
    Serial.print(n);
    Serial.println(" networks found");
    for (int i = 0; i < n; ++i) {
      // Print SSID and RSSI for each network found
      Serial.print(i + 1);
      Serial.print(": ");
      Serial.print(WiFi.SSID(i));
      Serial.print(" (");
      Serial.print(WiFi.RSSI(i));
      Serial.print(")");
      Serial.println((WiFi.encryptionType(i) == ENC_TYPE_NONE) ? " " : "*");
      delay(100);
    }
  }
  Serial.println("");
  WiFi.begin(ssid, password);             // Connect to the network
  Serial.print("Connecting to ");
  Serial.print(ssid); Serial.println(" ...");
  int i = 0;
  while (WiFi.status() != WL_CONNECTED) { // Wait for the Wi-Fi to connect
    delay(1000);
    Serial.print(++i); Serial.print(' ');
  }
  
  Serial.println('\n');
  Serial.println("Connection established!");  Serial.println(" ");
  Serial.print("IP address:\t"); Serial.println(" ");
  Serial.println(WiFi.localIP());         // Send the IP address of the ESP8266 to the computer
  delay(500);
  
  Serial.println("Programm is Starting."); Serial.println("The Temperature updates every 16 sec..."); Serial.println(" ");
}

void loop() {
  
  RawValue = analogRead(A0); 
  Voltage = (RawValue / 1024.0) * 3300; // 3300 to get millivots.
  tempC = (Voltage-500) * 0.1; // 500 is the offset
  tempF = (tempC * 1.8) + 32; // conver to F 
  Serial.println("-------------------- TMP36 Sensor --------------------"); 
  Serial.println("TMP36 Sensor : ");     
  Serial.print("\t Temperature in C = ");
  Serial.print(tempC,1);Serial.print(" C");
  Serial.print("\t Temperature in F = "); 
  Serial.print(tempF,1); Serial.print(" F");
  Serial.print("\t Raw Value = " );  // shows pre-scaled value                    
  Serial.println(RawValue); 
  Serial.println(" ");

  Serial.println("-------------------- DHT11 Sensor --------------------");
  Serial.println("DHT11 Sensor : ");
  int chk = DHT.read11(DHT11_PIN);
  DHT11tempC = DHT.temperature ;
  Serial.print("\t Temperature in C = ");
  Serial.print(DHT11tempC); Serial.print(" C");
  DHT11tempF = (DHT11tempC * 1.8) + 32; // convert to F
  Serial.print("\t Temperature in F = "); 
  Serial.print(DHT11tempF); Serial.print(" F");
  DHT11Humidity = DHT.humidity ;
  Serial.print("\t Humidity % = ");
  Serial.print(DHT11Humidity); Serial.println(" %");
  delay(1000);
  Serial.println(" ");
  Serial.println("-------------------- Difference Between Sensors --------------------");
  float  diff = SensorDiff (tempC, tempF, DHT11tempC, DHT11tempF);

  Serial.println("-------------------- Uploading to ThingSpeak --------------------");
  //Connect to host, host(web site) is define at top 

    WiFiClient client;          
    const int httpPort = 80; //Port 80 is commonly used for www
   //---------------------------------------------------------------------
   //Connect to host, host(web site) is define at top 
   if(!client.connect(server, httpPort)){
     Serial.println("Connection Failed");
     delay(300);
     return; //Keep retrying until we get connected
   }
 
    String tsData1;
    String tsData2;
    String tsData3;
    String tsData4;
    
    tsData1 = String(DHT11tempC);
    tsData2 = String(tempC);
    tsData3 = String(diff);
    tsData4 = String(DHT11Humidity);
    
    String Link1 ="GET /update?api_key="+apiKey+"&field1=0"+tsData1+"&field2=0" + tsData2+"&field3=0" + tsData3+"&field4=0" + tsData4;
    Link1 = Link1 + " HTTP/1.1\r\n" + "Host: " + server + "\r\n" + "Connection: close\r\n\r\n";
    client.print(Link1);
    delay(100);

    int timeout=0;
     while((!client.available()) && (timeout < 1000))     //Wait 5 seconds for data
     {
       delay(10);  //Use this with time out
       timeout++;
     }
     
     //If data is available before time out read it.
     if(timeout < 500)
     {
         while(client.available()){
            Serial.println(client.readString()); //Response from ThingSpeak       
         }
     }
     else
     {
         Serial.println("Request timeout..");
     }
     
     delay(15000); 
     Serial.println(" ");
}

float SensorDiff(double tempC, double tempF, double DHT11tempC, double DHT11tempF)
{
  CelciusDiff = tempC - DHT11tempC ;
  float FahrDiff = tempF - DHT11tempF ;
  Serial.print("\t The Difference is : "); Serial.print(fabs(CelciusDiff)); Serial.println(" C - Absolute Value");
  Serial.print("\t The Difference is : "); Serial.print(fabs(FahrDiff)); Serial.println(" F - Absolute Value");
  Serial.println("\n");
  return fabs(CelciusDiff) ;
  delay(1000);
}
