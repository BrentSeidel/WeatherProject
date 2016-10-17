--
-- Standard Ada packages
--
with Ada.Text_IO;
with Ada.Integer_Text_IO;
--
-- Other packages
--
with BBS.BBB.i2c;
with BBS.BBB.i2c.PCA9685;
with WeatherConstants;

procedure test is
   port : BBS.BBB.i2c.i2c_interface := BBS.BBB.i2c.i2c_new;
   servo : BBS.BBB.i2c.PCA9685.PS9685_ptr := BBS.BBB.i2c.PCA9685.i2c_new;
   selection : integer;
   error : integer;
   channel : integer;
   time_on : integer;
   time_off : integer;
begin
   Ada.Text_IO.Put_Line("Test and calibration program");
   Ada.Text_IO.Put_Line("Configuring the i2c interface");
   port.configure("/dev/i2c-1", "/dev/null", "/dev/null");
   servo.configure(port, BBS.BBB.i2c.PCA9685.addr_0, error);
   for channel in BBS.BBB.i2c.PCA9685.channel loop
      servo.set_servo_range(channel, WeatherConstants.servo_min,
                            WeatherConstants.servo_max);
   end loop;
   loop
      Ada.Text_IO.Put_Line("Options are:");
      Ada.Text_IO.Put_Line("  0 - Exit");
      Ada.Text_IO.Put_Line("  1 - All off");
      Ada.Text_IO.Put_Line("  2 - All on");
      Ada.Text_IO.Put_Line("  3 - Set channel");
      Ada.Text_IO.Put_Line("  4 - Sleep on");
      Ada.Text_IO.Put_Line("  5 - Sleep off");
      Ada.Text_IO.Put("Select option: ");
      Ada.Integer_Text_IO.Get(selection);
      exit when selection = 0;
      case selection is
         when 1 =>
            servo.set_full_on(BBS.BBB.i2c.PCA9685.ALL_CHAN, error);
         when 2 =>
            servo.set_full_off(BBS.BBB.i2c.PCA9685.ALL_CHAN, error);
         when 3 =>
            Ada.Text_IO.Put("Enter channel number: ");
            Ada.Integer_Text_IO.Get(channel);
            Ada.Text_IO.Put("Enter time on: ");
            Ada.Integer_Text_IO.Get(time_on);
            Ada.Text_IO.Put("Enter time off: ");
            Ada.Integer_Text_IO.Get(time_off);
            servo.set(BBS.BBB.i2c.PCA9685.channel(channel),
                      BBS.BBB.uint12(time_on), BBS.BBB.uint12(time_off), error);
         when 4 =>
            servo.sleep(true, error);
         when 5 =>
            servo.sleep(false, error);
         when others =>
            Ada.Text_IO.Put_Line("Unknown option, try again");
      end case;
   end loop;
   Ada.Text_IO.Put_Line("Good-bye.");
end;
