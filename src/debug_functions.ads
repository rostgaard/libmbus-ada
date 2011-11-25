with Mbus_Types;
with Ada.Integer_Text_IO;
with Ada.Text_IO;

package Debug_Functions is
   use Ada.Integer_Text_IO;
   use Ada.Text_IO;
   use Mbus_Types;

   
   -- For use of Float put function 
   package IEEE_Float_IO is new Float_IO(Float); use IEEE_Float_IO;   

   
   procedure Print(Dongle_Header : in Dongle_Header_Type);
   
   procedure Print(MBUS_Header : in MBUS_Header_Type);
   
   procedure Print(Measurement : in Measurement_Type);
   
end Debug_Functions;
