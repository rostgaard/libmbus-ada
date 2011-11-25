with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Exceptions;
with GNAT.Serial_Communications;

-- Local packages
with Mbus_Types;
with MBUS;
with Debug_Functions;
with UART_IO;

procedure Mbus_Logger is 
   use Ada.Text_IO;
   use Ada.Integer_Text_IO;
   use GNAT.Serial_Communications;
   
   use Mbus_Types;
   use Debug_Functions;
   
   task type UART_Rx_Type ;
   type UART_Rx_Type_Access is access UART_Rx_Type;
   
   Device_Name  : constant String(1 .. 12) := "/dev/ttyACM0";
   Buffer       : String (1 .. 2048) := (others => ' ');
   Filled       : Natural := 0;
   UART         : aliased Serial_Port;
   UART_Rx_Task : UART_Rx_Type_Access;
     
   
   task body UART_Rx_Type is
      -- For use of Float put function 
      package IEEE_Float_IO is new Float_IO(Float); use IEEE_Float_IO;   

      Dongle_Header : Dongle_Header_Type;
      MBUS_Header   : MBUS_Header_Type;
      Measurement   : Measurement_Type;
   begin
      loop
	 UART_IO.Get_Line ((UART'access),Buffer,Filled);
	 -- Only read if is an mbus message
	 if Filled > 4 and then Buffer(Buffer'First ..Buffer'First+4) = "MBUS:" then	 
	    MBUS.Parse_Line(Buffer(1..Filled), Dongle_Header, MBUS_Header, Measurement);
	    
	    --Print(Dongle_Header);
	    if Dongle_Header.Status = OK then
	       --Print(MBUS_Header);
	       --Print(Measurement);
	       Put(Item => Measurement.Uptime, Width => 0);
	       Put(" ");
	       Put(Item => Measurement.Power, Fore => 1, Aft => 3, Exp => 0);
	       
	       New_Line;
	    end if;
 	    
	 else 
	    Put_Line(Buffer(Buffer'First .. Buffer'First+Filled));
	 end if;
      end loop;
   exception
      when E : others =>
         Ada.Text_IO.Put ("UART_Rx: ");
         Ada.Text_IO.Put (Ada.Exceptions.Exception_Name(E));
   end UART_Rx_Type;
begin
   GNAT.Serial_Communications.Open (Port => UART, Name => Port_Name(Device_Name));
   UART_Rx_Task := new  UART_Rx_Type;
   
   
   loop
      Get_Line (Buffer,Filled);
      UART_IO.Put_Line(UART'access,Buffer(1..Filled));
   end loop;

exception
   when E : GNAT.SERIAL_COMMUNICATIONS.SERIAL_ERROR =>
      Put_Line("Error communicating with serial device (check presence and permissions)");
end Mbus_Logger;
   
   
