`timescale 1ns / 1ps

module Port_C_U(C, C_cpu, group_control, control_logic);
		
	inout  [3:0] C;
	inout  [3:0] C_cpu;
	input group_control;// control on or out
	input control_logic; // to activate the port

	
    // Drive from C_cpu to C (Output mode)
    assign C = (control_logic && !group_control) ? C_cpu : 4'bz;

    // Drive from C to C_cpu (Input mode)
    assign C_cpu = (control_logic && group_control) ? C : 4'bz;


	endmodule
