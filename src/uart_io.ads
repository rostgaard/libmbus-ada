with Ada.Streams;
with Mbus_Types;
package UART_IO is
   use Mbus_Types;
   
   -- A generic IO function from JSA's stream shortcuts.
   procedure Get_Line (Source : access Ada.Streams.Root_Stream_Type'Class;
                       Item   :    out String;
                       Last   :    out Natural);
   
   -- This one is more specific as it appends CR at the end of the string
   procedure Put_Line (Target : access Ada.Streams.Root_Stream_Type'Class;
		       Item   : in     String);
   
end UART_IO;
