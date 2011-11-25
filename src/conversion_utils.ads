with Ada.Unchecked_Conversion;

package Conversion_Utils is
   function Hex_String_To_Integer(Item : in String) return Integer;
   
   
   function Int_To_Float is new Ada.Unchecked_Conversion (Source => Integer,
							  Target => Float);

end Conversion_Utils;
