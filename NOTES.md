#Project Notes

This is a collection of thoughts and notes about the weather sensor project.

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
