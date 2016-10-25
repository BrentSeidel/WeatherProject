#Project Notes

This is a collection of thoughts and notes about the weather sensor project.

## 25-Oct-2016
After adding the C code to the project and running it in parallel with my Ada code,
I found that my code produced the same results as the C code.  This suggested that
the problem was elsewhere.  After some more searching, I discovered that one of
the calibration parameters for humidity was being read from the wrong location.
Correcting this produced reasonable results.  Another example where the problem
isn't necessarily where you think it is.

The software is basically done, except perhaps for some polishing.  Now to try
and build something to mount the hardware on.

## 24-Oct-2016
Adding a separate 5V power supply solved the problem with the servos.  Added the
initial code for the project (weather.adb).  Once everything is tested and working,
adding "/home/pi/Ada/WeatherProject/weather &" to /etc/rc.local will cause the
program to run when the Raspberry PI boots.  There are basically two things yet
to do for this project.

1. Solve the problem with the humidity value

2. Build and mount the hardware

## 21-Oct-2016
The humidity is still coming out at about 0.11%.  While I live in the desert
southwest, this is still a little lower that I would expect.  It does increase a
little when I breath on it so it seems to be doing something.

I updated the test program to add some more options.  You can now set the servos
to point to specific temperature, pressure, or humidity values.  There's also an
option to read the sensor values and set all three servos.  This is basically
what the final program will do in each processing frame.

With all three servos hooked up, operation is a bit erratic.  This is probably
because the 5V output on the Raspberry PI can't supply enough current.  I will
have to find an external 5V power supply to test.

## 20-Oct-2016
Added humidity calibration and it is giving reasonable numbers.  The air pressure
is still about 1% of what it should be.  There is definately something wrong here.

An important thing to keep in mind is to ensure that the value that you are
displaying is actually the value that you think you are displaying.  Once the
pressure and humidity routines were changed to return the calibrated values
rather than the raw values, the pressure is now reasonable, but humidity isn't.

## 19-Oct-2016
The temperature calibration seems to be working.  At least the results are reasonable.
The pressure calibration is giving results that are way off.  This will need some
work to figure out just where I deviated from the example code.  It's probably a
parenthesis out of place or switching a "/" and a "*".  Once I get this working I will
tackle the humidity calibration.

## 18-Oct-2016
Fortunately I had purchased two BME280 sensors.  I soldered the header onto the
second one and hooked it up and could talk to it.  Sadly the example code in the
datasheet for computing the calibrated values is not particularly clear C code so
converting it to Ada is rather tedious.  Still this shouldn't be technically
difficult.

The main remaining risk is having adequate drive current for the servos.  I have
been unable to find any hints of the current draw for them.  So I am hoping that
with small servos with little load, the 5V output pin on the Raspberry PI will
supply adequate current.  If not, an external supply would be needed.  This would
be ugly, but would work.

The last hurdle will be packaging this up nicely.  I have a couple of ideas, but
am not sure if they will work.

## 17-Oct-2016
I have been working on a set of I/O routines for the BeagleBone Black and
written in Ada (it's my project, I can write it in whatever language I want).
The BeagleBone Black and other similar boards are powerful enough computers to
run Linux and development tools.  So one can actually develop software directly
on the target system.  Most of the embedded I/O is done via the file system.
This means that one could write a library that was reasonably portable.

The Raspberry Pi has a somewhat simpler I/O system than the BeagleBone Black.
For example, there are no analog inputs or PWM outputs.  The I/O pins seem to
have only single functions so there is no ability to control a pins function.

Since the temperature, pressure, and humidity sensor has an I2C interface and
there is a PWM controller that also has an I2C interface, all the target
computer needs is an I2C bus.  Since the Raspberry Pi has an I2C bus and is
a little cheaper than the BeagleBone Black, I chose this to be the processor
for this project.  This also forces me to ensure that the I2C library works on
more than just the BeagleBone Black.

The project will measure temperature, pressure, and humidity approximately once
each second (the timing isn't really critical for this application).  The
measured values will be used to drive three servo motors to position pointers.

###Current project status
* My BME sensor module appears to be dead.  It doesn't even show up using
i2cdetect.  I will need to try another one.

* I have a simple test program running on the Raspberry Pi.  It is able to talk
to the PCA9685 PWM controller over the I2C bus.  This was the biggest risk.
Now that the I2C bus is working, all I need to do is get a working BME280 and
write the interface software for it.
