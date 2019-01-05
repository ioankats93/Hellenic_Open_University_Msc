### This is the Second assignment of the Degree Embedded system design and microcontroller applications for the Internet of Things.

Implement an eight-LED sequential control circuit with Quartus.
It is going to be externally controlled by me via the GPIOs The GPIO[1] for example will be the reset and the GPIO[0] will be the signal.

When i change the GPIO [0] signal (from '0' to '1' and vice versa), the circuit will have to switch to the next among three states, defined as follows: 

A) The LED [0: 1] periodically flashes with a period of 2 seconds (stays on for 1 sec) while LED [3: 7] remains off.

B) LED [3: 4] flashes periodically for 6 sec (remain on for 3 sec) while LED [0: 2] and [5: 7] remain off.

C) LED [6: 7] flashes periodically with a period of 12 seconds (stays on for 6 sec), while LED [0: 5] remains off.
