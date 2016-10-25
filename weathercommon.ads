with BBS.BBB;
with BBS.BBB.i2c;
with BBS.BBB.i2c.PCA9685;
with BBS.units;
use type BBS.units.temp_c;
use type BBS.units.press_p;
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
   servo_min : constant BBS.BBB.uint12 := 450;
   servo_max : constant BBS.BBB.uint12 := 2000;
   --
   temp_min : constant BBS.units.temp_c := 10.0;
   temp_max : constant BBS.units.temp_c := 40.0;
   --
   press_min : constant BBS.units.press_p := 80_000.0;
   press_max : constant BBS.units.press_p := 120_000.0;
   --
   hum_min : constant float := 0.0;
   hum_max : constant float := 100.0;
   --
   -- Channels used on the PWM controller.  Each parameter has a servo output
   -- and a LED used to indicate out of range conditions.
   --
   temp_chan : constant BBS.BBB.i2c.PCA9685.channel := 0;
   temp_range_chan : constant BBS.BBB.i2c.PCA9685.channel := 1;
   --
   press_chan : constant BBS.BBB.i2c.PCA9685.channel := 4;
   press_range_chan : constant BBS.BBB.i2c.PCA9685.channel := 5;
   --
   hum_chan : constant BBS.BBB.i2c.PCA9685.channel := 8;
   hum_range_chan : constant BBS.BBB.i2c.PCA9685.channel := 9;
   --
   -- Procedures to set the servos to point to the sensor values.
   --
   procedure show_temp(servo: BBS.BBB.i2c.PCA9685.PS9685_ptr; temp : BBS.units.temp_c);
   procedure show_press(servo: BBS.BBB.i2c.PCA9685.PS9685_ptr; press : BBS.units.press_p);
   procedure show_hum(servo: BBS.BBB.i2c.PCA9685.PS9685_ptr; hum : float);

end;
