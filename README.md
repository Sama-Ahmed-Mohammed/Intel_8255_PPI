# Intel_8255_PPI
The Intel 8255 Programmable Peripheral Interface (PPI) is a used I/O device in microcontroller and early computer systems. It provides 24 programmable I/O pins, organized into three 8-bit ports: A, B, and C. Port A and B operate as standard input/output ports, while Port C can be configured as a full 8-bit port, split into two 4-bit ports, or used for handshaking with Ports A and B.

Ports are grouped as:

Group A: Port A + upper 4 bits of Port C

Group B: Port B + lower 4 bits of Port C

Data transfers are controlled via RD, WR, and A0/A1 address lines.

This repository contains a Verilog implementation of the Intel 8255A PPI.
