
### Exercise 1
In ARLab, you can only practice with elements already connected to the Arduino board. Therefore, in the first question of this assignment, an alarm system using PIR, Ultrasonic and Gas sensors (not present in ARLab) is requested in the tinkercad, the components of which are shown in the figure below.

![alt text](https://github.com/ioankats93/Hellenic_Open_University_Msc/blob/master/Fourth_Assignment/readme_images/Screen%20Shot%202019-05-03%20at%2017.55.52.png)



### Exercise 2
Develop code for the ARL system :

__A)__ Reads the temperature sensor value and displays the integral part in the 7-segment display
__B)__ Reads the value of the LDR sensor and displays the measurement on the LCD screen.
__C)__ It will keep the readings constant for 5 minutes to prevent you get a screenshot (which you will hand in with your .ino code file)
__D)__ Turns off both the screen and both 7segment after the end of the above time
In other words, your code will read two analog values ​​and display them on the 7-segment and LCD screen, which will then go off. This is required to do it only once.


### Exercise 3
Use the ARL system at 194.24.226.110 and create a server that will provide a web page with a graphic command button.It will light up and turn off the blue LED connected to the system. You can implement a button that will make a transition to the led state (toggle), or two buttons that one will turn on and the other will turn off the led.

### Exercise 4
Use the ARL system at 194.24.226.110 to connect through the Ethernet network using the W5100 shield. Build your own account (of course you can use the account you opened for the implementation of Exercise 3 of GE3) and channel (new) in thingspeak and program the system to portray:
A) the temperature value obtained by the DHT22 sensor
B) the value of the moisture obtained from the DHT22 sensor

All of the above data, in addition to the thingspeak channel, should also be displayed on the serial console and on the LCD screen. Also, on the console, we want to display the IP address of the thingspeak server that your system connects to when you start the code.