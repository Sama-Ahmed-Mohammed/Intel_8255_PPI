`timescale 1ns / 1ps

module Port_A(A, A_cpu, group_control, control_logic
    );
		
	inout  [7:0] A;
	inout  [7:0] A_cpu;
	input group_control;// control on or out
	input control_logic; // to activate the port

	assign A = (!control_logic)? 8'bzzzz_zzzz : (!group_control)? A_cpu: 8'bzzzz_zzzz; // if group_control = 0 A is output
	assign A_cpu = (!control_logic)? 8'bzzzz_zzzz: (group_control)? A: 8'bzzzz_zzzz; // if control_group = 0 "reset" then A is input . if group_control = 1 A input  

endmodule
