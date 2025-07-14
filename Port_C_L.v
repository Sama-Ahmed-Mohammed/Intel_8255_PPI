`timescale 1ns / 1ps

module Port_C(C, C_cpu, group_control, control_logic, BSR, BSR_mode
    );
        
    inout  [3:0] C;
    inout  [3:0] C_cpu;
    input group_control;// control on or out
    input control_logic; // to activate the port
    input [3:0] BSR;
    input BSR_mode;

    assign C = (BSR_mode)? BSR :(!control_logic)? 4'bzzzz : (!group_control)? C_cpu: 4'bzzzz; // if group_control = 0 A is output
    assign C_cpu =(BSR_mode)? 4'bzzzz : (!control_logic)? C : (group_control)? C: 4'bzzzz; // if control_group = 0 "reset" then A is input . if group_control = 1 A input  


endmodule
