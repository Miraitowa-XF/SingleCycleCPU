`timescale 1ns / 1ps

 module IM_sim;
 //inputs
 reg [31:0] IAddr;
 reg RW;
 reg [3:0] PC4;
 //output
 wire [5:0] op;
 wire [5:0] func;
 wire [4:0] rs, rt, rd;
 wire [15:0] Immediate;
 wire [4:0] Sa;
 wire [31:0] JumpPC;
 
 InstructionMemory uut(
    .IAddr(IAddr),
    .RW(RW),
    .PC4(PC4),
    .op(op),
    .func(func),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .Immediate(Immediate),
    .Sa(Sa),
    .JumpPC(JumpPC)
 );
 initial begin
    //record
    $dumpfile("IM.vcd");
    $dumpvars(0, IM_sim);
    //initial 
    #10;
    RW = 0;
    PC4 = 4'b0010;
    IAddr[31:0] = 32'd0;
    //read instruction
    #50;
    RW = 1;
    IAddr[31:0] = 32'd0;
    //read instruction
    #50;
    RW = 1;
    IAddr[31:0] = 32'd4;
    //read instruction
    #50;
    RW = 1;
    IAddr[31:0] = 32'd8;
    
    #50;
    RW = 1;
    IAddr[31:0] = 32'd12;
    //read instruction
    #50;
    RW = 1;
    IAddr[31:0] = 32'd16;
    //read instruction
    #50;
    RW = 1;
    IAddr[31:0] = 32'd20;
    //finish
    #10;
    $stop;
 end
 endmodule
