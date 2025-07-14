`timescale 1ns / 1ps

module Port_B(B, B_cpu, group_control, control_logic
    );
        
    inout [7:0] B;
    inout [7:0] B_cpu;
    input group_control;// control on or out
    input control_logic; // to activate the port
        
        
    assign B = (!control_logic)? 8'bzzzz_zzzz : (!group_control)? B_cpu: 8'bzzzz_zzzz; // if group_control = 0 B is output
    assign B_cpu = (!control_logic)? 8'bzzzz_zzzz: (group_control)? B: 8'bzzzz_zzzz; // if control_group = 0 "reset" then B is input . if group_control = 1 B input  


endmodule
