package body Conversion_Utils is
   -- TODO change this to take the sign bit into account
   function Hex_String_To_Integer(Item : in String) return Integer is
      Offset : Integer := Item'First;
      Sum    : Integer := 0;
      Pos    : Natural := 0;
      Add    : Natural := 0;
   begin
      
      --Loop though every hex digit and add it
      for I in reverse Item'First .. Item'Last  loop 
	 case Item(I) is
	    when '0' .. '9' =>
	       Add := Integer'Value("0" & Item(I));
	    when 'A' =>
	       Add := 10;
	    when 'B' =>
	       Add := 11;
	    when 'C' =>
	       Add := 12;
	    when 'D' =>
 	       Add := 13;
	    when 'E' =>
	       Add := 14;
	    when 'F' =>
	       Add := 15;
	    when others =>
	      raise CONSTRAINT_ERROR;
	 end case;
	 Sum := Sum + Add*(16**Pos);
	 Pos := Pos +1;
	 
      end loop;
      return Sum;
   end Hex_String_To_Integer;
   
   
   
end Conversion_Utils;
