# WeatherProject
Weather Station Project

This is a complete project to use a Raspberry Pi, some sensors, and some servo
motors to display temperature, humidity, and air pressure.  The software will be
written in Ada.  This repository will contain the software, notes, and possibly
photos of the project.  The is really a demonstration of how to use some of the
Ada libraries that I've writen to build a complete system.

For more information, refer to the PARTS.md and NOTES.md files.

## Note before starting this project
You should be familiar with the following

1. Soldering - some of the components may require a bit of soldering
2. Linux - this software runs on top of Linux
3. Raspberry PI - This is based on a Raspberry PI

This is not a getting started tutorial.  This is the next step for once you've
already done your "Hello World!" project and are looking for other ideas.

##To get started:

1. install Raspberrian on a micro SD card and install it in your Raspberry Pi.
I am using a Pi 3 which is overkill.

2. use your favorite package manager to install gnat-gps, gprbuild, and i2ctools.

3. (optional) created a directory "Ada" for all the Ada stuff

4. download the WeatherProject, BBS-Ada and BBS-BBB-Ada projects from GitHub.

5. Build a case for the project and install the components.  I am not a cabinet
maker and my case is rather crude.  I wouldn't necessarily recommend it to anyone.

6. Wire everything up and use the test program to check that everything works.

7. Using the test program, you can set the temperature, pressure, and humidity
servos to known value.  These can be used to mark your scale.

8. Add the weather program to /etc/rc.local so that it will automatically start
when the system boots up.

9. Congratulations!  You're finished.

10. Going further.  There are a number of things that you can do to extend this
project in many ways.  A couple of suggestions are logging the data for later
review, or broadcasting the data over your local network for display on other
systems.

## Some pictures have been added.
![Front of project](Front.JPG)

The front panel of the project.  I haven't yet added scales for the pointers.  The
pointers are just bits of wire zip tied to the servo actuators.

![Back of project](Back.JPG)

The back of the project showing the instillation and wiring.  Note that the
Raspberry PI is in a separate case and not mounted to the project.  This would
change if I wanted to dedicate one.  I also used a small breadboard as it made
it easier to make wiring changes during development.  For a more perminant installation,
you may want to do more soldering.

![Wiring detail](Wiring,JPB)

This shows some details of the wiring on the breadboad.  The large blue board
is the 16 channel PWM controller.  The small blue board is the temperature,
pressure, and humidity sensor.
