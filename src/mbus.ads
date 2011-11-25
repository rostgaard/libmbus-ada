with Mbus_Types;
with Conversion_Utils;
package MBUS is
   use Conversion_Utils;
   use Mbus_Types;

   
   procedure Parse_Line(Buffer        : in  String;
			Dongle_Header : out Dongle_Header_Type;
			MBUS_Header   : out MBUS_Header_Type;
			Measurement   : out Measurement_Type);
end MBUS;
