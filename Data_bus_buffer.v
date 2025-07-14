`timescale 1ns / 1ps
module Data_bus_buffer( control_logic, bus_cpu, bus);

    input control_logic;
    inout [7:0] bus_cpu;
    inout [7:0] bus;


    assign bus = (control_logic)? bus_cpu : 8'bzzzz_zzzz ; // if control = 1 A processor write on ports
    assign bus_cpu = (control_logic)? 8'bzzzz_zzzz : bus; // if control = 0 processor read from ports

    endmodule
