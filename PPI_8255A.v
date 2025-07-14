`timescale 1ns / 1ps

module ppi_8255(D, PA, PB, PC, write, read, cs, reset, A_in);

    inout [7:0]D;
    inout [7:0]PA;
    inout [7:0]PB;
    inout [7:0]PC;
    input write;
    input read;
    input cs;
    input reset;
    input [1:0] A_in;

    wire control_to_buffer;
    wire [7:0] main_bus;
    wire [7:0] D_main;

    assign D_main =(!control_to_buffer)? D : 8'bzzzz_zzzz ;
    assign D =  (!control_to_buffer)? 8'bzzzz_zzzz : D_main;
    Data_bus_buffer buss_buffer (
        .control_logic(control_to_buffer), 
        .bus_cpu(main_bus), 
        .bus(D_main)
        );
    
        
    wire RD_n,WR_n,Reset,CS_n,group_control,port_control_A,port_control_B,port_control_C;
    wire [1:0] A;


    assign RD_n = read;
    assign WR_n = write;
    assign Reset = reset;
    assign CS_n = cs;
    assign A = A_in;	 
    
    
    Control_logic control (
        .RD_n(RD_n), 
        .WR_n(WR_n), 
        .A(A), 
        .Reset(Reset), 
        .CS_n(CS_n), 
        .data_bus(control_to_buffer), 
        .group_control(group_control), 
        .port_control_A(port_control_A), 
        .port_control_B(port_control_B), 
        .port_control_C(port_control_C)
        );
    wire [7:0] port_A;
    wire group_control_A;

    assign PA = (!group_control_A)? port_A : 8'bzzzz_zzzz;
    assign port_A = (group_control_A)? PA : 8'bzzzz_zzzz;

    Port_A port_a (
        .A(port_A), 
        .A_cpu(main_bus), 
        .group_control(group_control_A), 
        .control_logic(port_control_A)
        );

    wire [7:0] B;
    wire group_control_B;

    assign PB = (!group_control_B)? B : 8'bzzzz_zzzz;
    assign B = (group_control_B)? PB : 8'bzzzz_zzzz;


    Port_B port_b (
        .B(B), 
        .B_cpu(main_bus), 
        .group_control(group_control_B), 
        .control_logic(port_control_B)
        );


    wire [3:0] C_u;
    wire group_control_C_upper,BSR_mode_u;
    wire [3:0] BSR_u;

    assign PC[7:4] = (!group_control_C_upper)? C_u : 4'bzzzz;
    assign C_u = (group_control_C_upper)? PC[7:4] : 4'bzzzz;

    Port_C port_c_upper (
        .C(C_u), 
        .C_cpu(main_bus[7:4]), 
        .group_control(group_control_C_upper), 
        .control_logic(port_control_C), 
        .BSR(BSR_u), 
        .BSR_mode(BSR_mode_u)
        );
        

    wire [3:0] C_l;
    wire group_control_C_lower,BSR_mode_l;
    wire [3:0] BSR_l;

    assign PC[3:0] = (!group_control_C_upper)? C_l : 4'bzzzz;
    assign C_l = (group_control_C_upper)? PC[3:0] : 4'bzzzz;

    Port_C  port_c_lower (
        .C(C_l), 
        .C_cpu(main_bus[3:0]), 
        .group_control(group_control_C_lower), 
        .control_logic(port_control_C), 
        .BSR(BSR_l), 
        .BSR_mode(BSR_mode_l)
        );


    Group_A_control group_A (
        .control_logic(group_control), 
        .bus_cpu(main_bus), 
        .port_control_A(group_control_A), 
        .port_control_C_U(group_control_C_upper), 
        .bus(BSR_u), 
        .BSR_mode(BSR_mode_u)
        );



    Group_B_control group_B (
        .control_logic(group_control), 
        .bus_cpu(main_bus), 
        .port_control_B(group_control_B), 
        .port_control_C_L(group_control_C_lower), 
        .bus(BSR_l), 
        .BSR_mode(BSR_mode_l)
        );

    endmodule
