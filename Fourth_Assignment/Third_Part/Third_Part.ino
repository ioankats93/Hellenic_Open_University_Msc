//open serial monitor to see what the arduino receives
//use the \ slash to escape the " in the html
//address will look like http://192.168.1.102:84/ when submited
//W5100 based ethernet shield is used

#include <SPI.h>
#include <Ethernet.h>

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED }; //physical mac address
IPAddress ip(194, 24, 226, 83);
IPAddress dnS(194, 24, 226, 35);
IPAddress gw(194, 24, 226, 65);
IPAddress mask(255, 255, 255, 192);
EthernetServer server(80); //server port

// Variable to store the HTTP request
String header;

// Auxiliar variables to store the current output state
String outputState = "off";
const int led = 9 ;

void setup(){

  pinMode(led, OUTPUT); //pin selected to control
  //start Ethernet
    Ethernet.begin(mac, ip, dnS, gw, mask);
  server.begin();

  //enable serial data print
  Serial.begin(9600);
  Serial.println("Ioannis Katsikavelas - 3rd exercise from fourth assignment\n");
  Serial.println("Server Started"); // so I can keep track of what is loaded
  Serial.print("The IP is : ");
  Serial.println(Ethernet.localIP());
  Serial.print("\nPlease visit\t");
  Serial.print(Ethernet.localIP());Serial.print(":");Serial.print("84\t");
  Serial.println("to control the outputs on the board");
  Serial.println("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
}

void loop(){
  // Create a client connection
  EthernetClient client = server.available();
  if (client) {
    String currentLine = "";
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
        Serial.println(c);
        header += c;

        if (c == '\n') {     // if the byte is a newline character
          // if the current line is blank, you got two newline characters in a row.
          // that's the end of the client HTTP request, so send a response:
          if (currentLine.length() == 0) {
            // HTTP headers always start with a response code (e.g. HTTP/1.1 200 OK)
            // and a content-type so the client knows what's coming, then a blank line:
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println("Connection: close");
            client.println();
            
            // turns the GPIOs on and off
            if (header.indexOf("GET /led/on") >= 0) {
              Serial.println("Led is on");
              outputState = "on";
              digitalWrite(led, HIGH);
            } else if (header.indexOf("GET /led/off") >= 0) {
              Serial.println("Led is off");
              outputState = "off";
              digitalWrite(led, LOW);
            }
             
                    // Display the HTML web page
            client.println("<!DOCTYPE html><html>");
            client.println("<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            client.println("<link rel=\"icon\" href=\"data:,\">");
            // CSS to style the on/off buttons 
            // Feel free to change the background-color and font-size attributes to fit your preferences
            client.println("<style>html { font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;}");
            client.println(".button { background-color: #4CAF50; border: none; color: white; padding: 16px 40px;");
            client.println("text-decoration: none; font-size: 30px; margin: 2px; cursor: pointer;}");
            client.println(".button2 {background-color: #555555;}</style></head>");
            
            // Web Page Heading
            client.println("<body><h1>Ioannis Katsikavelas </h1>");
            client.println("<body><h3>This is the 3rd exercise from fourth assignment </h3>");
            
            // Display current state, and ON/OFF buttons for GPIO 9
            // If the outputState is off, it displays the ON button       
            if (outputState=="off") {
              client.println("<p><a href=\"/led/on\"><button class=\"button\">ON</button></a></p>");
            } else {
              client.println("<p><a href=\"/led/off\"><button class=\"button button2\">OFF</button></a></p>");
            }  
               
            client.println("</body></html>");
            
            // The HTTP response ends with another blank line
            client.println();
            // Break out of the while loop
            break;
          } else { // if you got a newline, then clear currentLine
            currentLine = "";
          }
        } else if (c != '\r') {  // if you got anything else but a carriage return character,
          currentLine += c;      // add it to the end of the currentLine
        }
      }
    }
    // Clear the header variable
    header = "";
    // Close the connection
    client.stop();
    Serial.println("Client disconnected.");
    Serial.println("");
  }
}
