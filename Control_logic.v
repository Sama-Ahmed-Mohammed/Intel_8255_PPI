`timescale 1ns / 1ps

module Control_logic(
	input RD_n, 				//read bit
	input WR_n, 				// write bit
	input [1:0] A,				// port select
	input Reset,				// reste 1 clear all
	input CS_n,					// the chip operats only if this bit is 0
	output reg data_bus,			// control the data bus buffer
	output reg group_control,	// control both group control A and B 1 for control
	output reg port_control_A, 		// 1 act the port is active
	output reg port_control_B,
	output reg port_control_C	
    );
	 
	 
		


	always@(Reset,RD_n,WR_n,A,CS_n)
	begin
		if (!CS_n)
		begin	
			if (Reset)
			begin
				port_control_A <= 0;
				port_control_B <= 0;
				port_control_C <= 0;
				group_control <= 0;
				
			end
			else begin
				
				case (A)
					
					2'b00: begin
						port_control_A <= 1;
						port_control_B <= 0;
						port_control_C <= 0;
						group_control <= 0;
					end
					
					2'b01: begin
						port_control_A <= 0;
						port_control_B <= 1;
						port_control_C <= 0;
						group_control <= 0;
					end
					
					2'b10: begin
						port_control_A <= 0;
						port_control_B <= 0;
						port_control_C <= 1;
						group_control <= 0;
					end
					
					2'b11: begin
						port_control_A <= 0;
						port_control_B <= 0;
						port_control_C <= 0;
						group_control <= 1;
					end
					
				endcase
				
				if (RD_n && !WR_n)
				begin
					data_bus <= 1 ;
				end
				else if (!RD_n && WR_n)
				begin
					data_bus <= 0 ;
				end
			end
			
		end

	end

	endmodule
