package body MBUS is
      -- TODO rewrite this to be more scanner-like
   procedure Parse_Line(Buffer        : in  String;
			Dongle_Header : out Dongle_Header_Type;
			MBUS_Header   : out MBUS_Header_Type;
			Measurement   : out Measurement_Type) is
      Uptime      : Integer := 0;
      Milli       : Integer := 0;
   begin
 	 -- First part is the uptime. The only part which is not broken into bytesize
 	 Dongle_Header.Uptime.Seconds := 
 	   Hex_String_To_Integer(Buffer(Buffer'First+5..Buffer'First+12));
	 
 	 -- Next is the milli seconds part
 	 Dongle_Header.Uptime.Milli_Seconds := 
 	   Hex_String_To_Integer(Buffer(15..18));
	 
 	 --  Chiprate
 	 Dongle_Header.Chip_Rate :=
 	   Hex_String_To_Integer(Buffer(20..21));
	 
 	 -- Status
 	 case Hex_String_To_Integer(Buffer(23..24)) is
 	    when 16#00# =>
 	       Dongle_Header.Status := OK;
 	    when 16#FE# =>
 	       Dongle_Header.Status := READ_TIMEOUT;
 	    when 16#EC# => 
 	       Dongle_Header.Status := BAD_HEADER_CRC;
 	    when 16#EB# =>
 	       Dongle_Header.Status := READ_LENGTH_ERROR;
 	    when others =>
 	       Dongle_Header.Status := UNDEFINED;
 	 end case;
	 
 	 -- RSSI level
 	 Dongle_Header.Rssi_Level :=
 	   Hex_String_To_Integer(Buffer(26..27));
	 
 	 -- Length
 	 Dongle_Header.Length :=
 	   Hex_String_To_Integer(Buffer(29..30));
	 
 	 -- This is the mbus header part
 	 if Dongle_Header.Status = OK and Dongle_Header.Length >= 12 then
 	    -- This is the length of the message minus this field and the next
 	    MBUS_Header.L_Field := Hex_String_To_Integer(Buffer(32..33));
 	    MBUS_Header.C_Field := Hex_String_To_Integer(Buffer(35..36));
	    
 	    -- TODO, parse this right
 	    MBUS_Header.Manufacturer_ID := 
 	      Hex_String_To_Integer(Buffer(41..42) & Buffer(38 .. 39));
	    
 	    --  -- TODO: this causes an overflow
 	    --  -- Unique ID
 	    --  MBUS_Header.Unique_Device_ID := 
 	    --    Hex_String_To_Integer(Buffer(53 ..54) &
 	    --  			      Buffer(50 .. 51) &
 	    --    			      Buffer(47 .. 48) &
 	    --    			      Buffer(44 .. 45));
	    
 	    -- Device Version
 	    MBUS_Header.Device_Version := 
 	      Hex_String_To_Integer(Buffer(56 .. 57));
	    
 	    -- TODO: Convert this into a enum
 	    -- Device type
 	    MBUS_Header.Device_Type := 
 	      Hex_String_To_Integer(Buffer(59 .. 60)); -- part15
	    
 	    -- CRC of the mbus msg header
 	    MBUS_Header.Header_CRC := 
 	      Hex_String_To_Integer(Buffer(65..66) & Buffer(62 .. 63));
	    
 	    if(Type_Of(MBUS_Header.Device_Type) = Electricity) then
 	       -- TODO crc checking
	       
 	       if Dongle_Header.Length = 76 or Dongle_Header.Length = 80 then
 		  Measurement.Uptime := 
 		    Hex_String_To_Integer(Buffer(77 .. 78) &
 					    Buffer(74 .. 75) & 
 					    Buffer(71 .. 72));
 		  -- Voltage
 		  Measurement.Voltage := Int_To_Float(Hex_String_To_Integer
 							(Buffer(89 .. 90) &
 							   Buffer(86 .. 87) &
 							   Buffer(83 .. 84) &
 							   Buffer(80 .. 81)));
		  
 		  -- Current
 		  Measurement.Current := Int_To_Float(Hex_String_To_Integer
 							(Buffer(101 .. 102) &
 							   Buffer(98 .. 99) &
 							   Buffer(95 .. 96) &
 							   Buffer(92 .. 93)));
 		  -- Power
 		  Measurement.Power := Int_To_Float(Hex_String_To_Integer
 						      (Buffer(113 .. 114) &
 							 Buffer(110 .. 111) &
 							 Buffer(107 .. 108) &
 							 Buffer(104 .. 105)));
		  
 	       end if;
 	       --(65 .. 66) part18 contains 0xA0 (Manufacturer specific msg)
 	       --(68 .. 69) part19 ontime
 	       --(71 .. 72) part20 ontime
 	       --(74 .. 75) part21 ontime
 	    end if;
	    --  Device_Type : Integer;
	    --  Header_CRC : Integer;
 	    -- process data from the mbus msg header
	    
	    
      end if;
      
   end Parse_Line;
end MBUS;
