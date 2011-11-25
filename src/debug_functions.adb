package body Debug_Functions is
   
   procedure Print(Dongle_Header : in Mbus_Types.Dongle_Header_Type)  is
   begin
      New_Line;
      Put("Dongle Uptime: ");
      Put(Item => Dongle_Header.Uptime.Seconds, Width => 0);
      Put(".");
      Put(Item => Dongle_Header.Uptime.Milli_Seconds, Width => 0);      
      New_Line;
      
      Put("Chiprate: ");
      Put(Item => Dongle_Header.Chip_Rate, Width => 0);
      New_Line;
      
      Put("Status: ");
	    case Dongle_Header.Status is
	       when OK =>
		  Put("OK");
	       when READ_TIMEOUT =>
		  Put("READ_TIMEOUT");
	       when BAD_HEADER_CRC => 
		  Put("BAD_HEADER_CRC");
	       when READ_LENGTH_ERROR =>
		  Put("READ_LENGTH_ERROR");
	       when others =>
		  Put("UNDEFINED");
	    end case;
      
      New_Line;
      
      Put("Rssi Level: ");
      Put(Item => Dongle_Header.Rssi_Level, Width => 0);
      New_Line;
      
      Put("Message_Length: ");
      Put(Item => Dongle_Header.Length, Width => 0);
      New_Line;

   end Print;
   
   
   procedure Print(MBUS_Header : in MBUS_Header_Type) is
   begin
	 -- MBUS header part:
	 New_Line;
	 Put("Message length: ");
	 Put(Item => MBUS_Header.L_Field, Width => 0);
	 New_Line;
	 
	 Put("Message type: ");
	 Put(Item => MBUS_Header.C_Field, Width => 0);
	 New_Line;
	 
	 Put("Manufacturer: ");
	 Put(Item => MBUS_Header.Manufacturer_ID, Width => 0);
	 New_Line;
	 
	 Put("Unique device ID: ");
	 Put(Item => MBUS_Header.Unique_Device_ID, Width => 0);
	 New_Line;
	 
	 Put("Device Version: ");
	 Put(Item => MBUS_Header.Device_Version, Width => 0);
	 New_Line;
	 
	 Put("Device type: ");
	 Put(Item => MBUS_Header.Device_Type, Width => 0);
	 New_Line;
	 
	 Put("CRC: ");
	 Put(Item => MBUS_Header.Header_CRC, Width => 0);
	 New_Line;
	 
	
   end Print;
   
   procedure Print(Measurement : in Measurement_Type) is
   begin
      New_Line;
      Put("Voltage: ");
      Put(Item => Measurement.Voltage, Fore => 1, Aft => 3, Exp => 0);
      Put(" Current: ");
      Put(Item => Measurement.Current, Fore => 1, Aft => 3, Exp => 0);
      Put(" Power: ");
      Put(Item => Measurement.Power, Fore => 1, Aft => 3, Exp => 0);
      
   end Print;   
   
end Debug_Functions;
