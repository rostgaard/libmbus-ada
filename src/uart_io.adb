package body UART_IO is

   procedure Get_Line (Source : access Ada.Streams.Root_Stream_Type'Class;
                       Item   :    out String;
                       Last   :    out Natural) is
      Char : Character;
   begin
      Last := Item'First - 1;
      loop
         exit when Last >= Item'Last;
         Char := Character'Input (Source);
         case Char is
            when ASCII.CR =>
               null;
            when ASCII.LF =>
               return;
            when others =>
               Last := Last + 1;
               Item (Last) := Char;
         end case;
      end loop;
   end Get_Line; 
   
   procedure Put_Line (Target : access Ada.Streams.Root_Stream_Type'Class;
		       Item   : in     String) is
   begin
      for Index in Item'Range loop
         Character'Output (Target,
                           Item (Index));
      end loop; 
      -- The protocol waits for a CR
      Character'Output (Target,
			ASCII.CR);
   end Put_Line;

   
   
end UART_IO;
