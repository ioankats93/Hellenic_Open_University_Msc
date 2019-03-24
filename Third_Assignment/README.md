
### Exercise 1
Write the assembly code of the ARM processor (Cortex M3) for the following tasks :

__a)__   Calculates the average number (integer) of a 32bit data structure. The numbers are located in a data area, the starting point of which is at the address _*seq*_ . The length of the data area is not known. So the average computation will stop when _*0x00*_ is entered.

__b)__  Implement a median filter with windows size of __3__. The value sequence _(32 bit integers)_ of inputs is addressed at _*src*_ location. The results are going to be stored at _*dest*_ location.

### Exercise 2
Implement a circuit that includes a tactile switch, servo motor, ldr resistor and an external led.  

When running the program, the servo will move from -90 degrees to +90 degrees and vice versa, while the LED will remain off until the switch is pressed momentarily. When it is done, the servo will stop, while the LED will light for 2 seconds, read the voltage at the ends of the ldr resistor and print it on the serial console. Then (after the end of 2 seconds) the program will restart the servo, until the switch is restarted.  


### Exercise 3
Implement a circuit that includes the DHT11 temperature / humidity sensor as well as the TMP36. Connect to a wifi network with ESP8266. Build your own account and channel in the thingspeak.
In your channel must be seen the underlying:

__A)__ Temperature from the DHT11 sensor.  
__B)__ Temperature from the TMP36 sensor.  
__C)__ The temperature difference of the two sensors.  
__D)__ Moisture from the DHT11 sensor.  

All of the above data, except for the channel of thingspeak, we want to appear on the serial console.

Also, in the console, we want the available wireless networks to appear when the code is started, as well as a successful connection to one of them.
