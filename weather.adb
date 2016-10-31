--
-- Standard Ada packages
--
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with Ada.Calendar;
--
-- Other packages
--
with BBS.BBB.i2c;
with BBS.BBB.i2c.PCA9685;
with BBS.BBB.i2c.BME280;
with BBS.units;
with WeatherCommon;

procedure weather is
   port : BBS.BBB.i2c.i2c_interface := BBS.BBB.i2c.i2c_new;
   servo : BBS.BBB.i2c.PCA9685.PS9685_ptr := BBS.BBB.i2c.PCA9685.i2c_new;
   sensor : BBS.BBB.i2c.BME280.BME280_ptr := BBS.BBB.i2c.BME280.i2c_new;
   error : integer;
   debug : constant boolean := false;
   press : BBS.units.press_p;
   temp : BBS.units.temp_c;
   hum : float;
   state : boolean := false;
begin
   BBS.BBB.i2c.debug := false;
   if (debug) then
      Ada.Text_IO.Put_Line("Test and calibration program");
      Ada.Text_IO.Put_Line("Configuring the i2c interface");
   end if;
   port.configure("/dev/i2c-1");
   servo.configure(port, BBS.BBB.i2c.PCA9685.addr_0, error);
   sensor.configure(port, BBS.BBB.i2c.BME280.addr, error);
   for channel in BBS.BBB.i2c.PCA9685.channel loop
      servo.set_servo_range(channel, WeatherCommon.servo_min,
                            WeatherCommon.servo_max);
   end loop;
   loop
      if (debug) then
         Ada.Text_IO.Put_Line("Processing loop");
      end if;
      sensor.start_conversion(error);
      loop
         exit when sensor.data_ready(error);
      end loop;
      sensor.read_data(error);
      temp := sensor.get_temp;
      press := sensor.get_press;
      hum := sensor.get_hum;
      if (debug) then
         Ada.Text_IO.Put("Temperature: ");
         Ada.Float_Text_IO.Put(float(temp), fore => 3, aft => 2, exp => 0);
         Ada.Text_IO.Put_Line("C");
         Ada.Text_IO.Put("Pressure: ");
         Ada.Float_Text_IO.Put(float(press), fore => 6, aft => 2, exp => 0);
         Ada.Text_IO.Put_Line("Pa");
         Ada.Text_IO.Put("Humidity: ");
         Ada.Float_Text_IO.Put(float(hum), fore => 3, aft => 2, exp => 0);
         Ada.Text_IO.Put_Line("%");
      end if;
      WeatherCommon.show_temp(servo, temp);
      WeatherCommon.show_press(servo, press);
      WeatherCommon.show_hum(servo, hum);
      if (state) then
         servo.set_full_on(WeatherCommon.act_1, error);
         servo.set_full_off(WeatherCommon.act_2, error);
         state := false;
      else
         servo.set_full_on(WeatherCommon.act_2, error);
         servo.set_full_off(WeatherCommon.act_1, error);
         state := true;
      end if;
      delay 1.0;
   end loop;
end;
