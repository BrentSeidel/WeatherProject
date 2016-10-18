with BBS.BBB;
with BBS.BBB.i2c.PCA9685;
with BBS.units;
package WeatherCommon is
   --
   -- This package contains assorted constants and procedures used by the
   -- Weather station project.
   --

   --
   -- Constants used for output.  The min and max values for the servos and the
   -- temperature, pressure, and humidity units are used to scale the servo
   -- positions.
   --
   servo_min : BBS.BBB.uint12 := 450;
   servo_max : BBS.BBB.uint12 := 2000;
   --
   temp_min : BBS.units.temp_c := 0.0;
   temp_max : BBS.units.temp_c := 100.0;
   --
   press_min : BBS.units.press_mb := 0.0;
   press_max : BBS.units.press_mb := 100.0;
   --
   hum_min : float := 0.0;
   hum_max : float := 100.0;
   --
   -- Channels used on the PWM controller.  Each parameter has a servo output
   -- and a LED used to indicate out of range conditions.
   --
   temp_chan : BBS.BBB.i2c.PCA9685.channel := 0;
   temp_range_chan : BBS.BBB.i2c.PCA9685.channel := 1;
   --
   press_chan : BBS.BBB.i2c.PCA9685.channel := 4;
   press_range_chan : BBS.BBB.i2c.PCA9685.channel := 5;
   --
   hum_chan : BBS.BBB.i2c.PCA9685.channel := 8;
   hum_range_chan : BBS.BBB.i2c.PCA9685.channel := 9;
end;
