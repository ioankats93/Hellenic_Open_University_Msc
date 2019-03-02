
### Exercise 2
Implement a circuit that includes a tactile switch, servo motor, ldr resistor and an external led.  

When running the program, the servo will move from -90 degrees to +90 degrees and vice versa, while the LED will remain off until the switch is pressed momentarily. When it is done, the servo will stop, while the LED will light for 2 seconds, read the voltage at the ends of the ldr resistor and print it on the serial console. Then (after the end of 2 seconds) the program will restart the servo, until the switch is restarted.  


### Exercise 3
Implement a circuit that includes the DHT11 temperature / humidity sensor as well as the TMP36. Connect to a wifi network with ESP8266. Build your own account and channel in the thingspeak.
In your channel must be seen the underlying:

A) temperature from the DHT11 sensor.
B) temperature from the TMP36 sensor.
C) the temperature difference of the two sensors.
D) Moisture from the DHT11 sensor.

All of the above data, except for the channel of thingspeak, we want to appear on the serial console.

Also, in the console, we want the available wireless networks to appear when the code is started, as well as a successful connection to one of them.
