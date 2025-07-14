`timescale 1ns / 1ps

module Group_A_control(
 control_logic, //1 for control mode
 bus_cpu, // D6,D5,D4,D3
 port_control_A,
 port_control_C_U,
 bus,
 BSR_mode
    );
	
input control_logic; //1 for control mode
input [7:0] bus_cpu; // D6;D5;D4;D3
output reg port_control_A;
output reg port_control_C_U;
output reg [3:0] bus;
output reg BSR_mode;

	 

 
//assign bus_cpu = (!bus_cpu[7]&&control_logic)? bus : 8'bzzzz_zzzz;

always@(control_logic,bus_cpu)
		if (control_logic)
		begin
			
			if(bus_cpu[7])
			begin //mode select flag
				BSR_mode <= 1'b0;
				casez (bus_cpu[6:5])
				
					2'b00 : begin
					port_control_A <= (bus_cpu[4])? 1'b0 : 1'b1 ;
					port_control_C_U <= (bus_cpu[3])? 1'b0 : 1'b1 ;
					end
									
				endcase
			
			end //end of mode select
		else begin //BSR
			BSR_mode <= 1'b1;
			port_control_C_U <=1'b0;

				casez (bus_cpu[3:1])
					
					3'b111: bus <=(bus_cpu[0])? 4'b1zzz :4'b0zzz;
					3'b110: bus <=(bus_cpu[0])? 4'bz1zz :4'bz0zz;
					3'b101: bus <=(bus_cpu[0])? 4'bzz1z :4'bzz0z;
					3'b100: bus <=(bus_cpu[0])? 4'bzzz1 :4'bzzz0;
					default:bus <=4'bzzzz;
					
				endcase
			
			end //end of BSR 
		end // if
   
				
endmodule
