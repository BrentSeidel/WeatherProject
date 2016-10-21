package body WeatherCommon is
   procedure show_temp(servo: BBS.BBB.i2c.PCA9685.PS9685_ptr; temp : BBS.units.temp_c) is
      servo_value : float := float((temp - temp_min)/(temp_max - temp_min));
      error : integer;
   begin
      if (servo_value < 0.0)
      then
         servo_value := 0.0;
         servo.set_full_on(temp_range_chan, error);
      elsif (servo_value > 1.0) then
         servo_value := 1.0;
         servo.set_full_on(temp_range_chan, error);
      else
         servo.set_full_off(temp_range_chan, error);
      end if;
      servo_value := servo_value*2.0 - 1.0;
      servo.set_servo(temp_chan, BBS.BBB.i2c.PCA9685.servo_range(servo_value), error);
   end;
   --
   procedure show_press(servo: BBS.BBB.i2c.PCA9685.PS9685_ptr; press : BBS.units.press_p) is
      servo_value : float := float((press - press_min)/(press_max - press_min));
      error : integer;
   begin
      if (servo_value < 0.0)
      then
         servo_value := 0.0;
         servo.set_full_on(press_range_chan, error);
      elsif (servo_value > 1.0) then
         servo_value := 1.0;
         servo.set_full_on(press_range_chan, error);
      else
         servo.set_full_off(press_range_chan, error);
      end if;
      servo_value := servo_value*2.0 - 1.0;
      servo.set_servo(press_chan, BBS.BBB.i2c.PCA9685.servo_range(servo_value), error);
   end;
   --
   procedure show_hum(servo: BBS.BBB.i2c.PCA9685.PS9685_ptr; hum : float) is
      servo_value : float := float((hum - hum_min)/(hum_max - hum_min));
      error : integer;
   begin
      if (servo_value < 0.0)
      then
         servo_value := 0.0;
         servo.set_full_on(hum_range_chan, error);
      elsif (servo_value > 1.0) then
         servo_value := 1.0;
         servo.set_full_on(hum_range_chan, error);
      else
         servo.set_full_off(hum_range_chan, error);
      end if;
      servo_value := servo_value*2.0 - 1.0;
      servo.set_servo(hum_chan, BBS.BBB.i2c.PCA9685.servo_range(servo_value), error);
   end;
   --
end;
