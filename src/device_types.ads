package Mbus_Types is
   
   type MBUS_Status_Type is 
     (OK, READ_TIMEOUT, BAD_HEADER_CRC, READ_LENGTH_ERROR, UNDEFINED);
   
   type Device_Type_Type is (Other,
			     Oil,
			     Electricity,
			     Gas,
			     Heat,
			     Steam,
			     Warm_Water, -- 30°C to 90°C
			     Water,
			     Heat_Cost_Allocator,
			     Compressed_Air,
			     Cooling_Load_Inlet,
			     Cooling_Load_Outlet,
			     Heat_Inlet,
			     Heat_Cooling_Load,
			     Bus_System_Component, -- Bus or system component
			     Unknown,
			     Hot_Water, -- above 90°C
			     Cold_Water,
			     Water_Dual_Register, -- Dual (hot/cold) Water meter
			     Pressure,
			     A_D_Converter,
			     Reserved);
   
   Type_Of : constant array (16#00# .. 16#FF# ) of Device_Type_Type :=
     ( 16#00# => Other,
       16#01# => Oil,
       16#02# => Electricity,       
       16#03# => Gas,       
       16#04# => Heat,	      
       16#05# => Steam,
       16#06# => Warm_Water,
       16#07# => Water,
       16#08# => Heat_Cost_Allocator,
       16#09# => Compressed_Air,
       16#0A# => Cooling_Load_Inlet,
       16#0B# => Cooling_Load_Outlet,
       16#0C# => Heat_Inlet,
       16#0D# => Heat_Cooling_Load,
       16#0E# => Bus_System_Component,
       16#0F# => Unknown,
       --  Reserved range from 16#10# to 16#14#
       16#15# => Hot_Water,  
       16#16# => Cold_Water,         
       16#17# => Water_Dual_Register,
       16#18# =>Pressure,
       16#19# =>A_D_Converter,
       Others => Reserved);
end Mbus_Types;
