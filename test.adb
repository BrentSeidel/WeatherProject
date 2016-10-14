with Ada.Text_IO;
with BBS.BBB.i2c;
with BBS.BBB.i2c.PCA9685;

procedure test is
   port : BBS.BBB.i2c.i2c_interface := BBS.BBB.i2c.i2c_new;
   servo : BBS.BBB.i2c.PCA9685.PS9685_ptr := BBS.BBB.i2c.PCA9685.i2c_new;
begin
   Ada.Text_IO.Put_Line("Test and calibration program");
   Ada.Text_IO.Put_Line("Configuring the i2c interface");
   port.configure("/dev/i2c-1", "/dev/null", "/dev/null");
end;
