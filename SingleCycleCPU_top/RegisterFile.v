`timescale 1ns / 1ps

module RegisterFile(
    input CLK, RegDst, RegWre, DBDataSrc,
    input [4:0] rs, rt, rd,
    input [31:0] dataFromALU, dataFromRW,
    output reg [31:0] Data1, Data2,
    output [31:0] writeData
);
    wire [4:0] writeReg; // 要写的寄存器端口
    assign writeReg = RegDst ? rd : rt;

    // ALUM2Reg 为 0 时，使用来自 ALU 的输出；为 1 时，使用来自数据存储器（DM）的输出
    assign writeData = DBDataSrc ? dataFromRW : dataFromALU;

    // 初始化寄存器
    reg [31:0] register[0:31];
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) 
            register[i] = 32'b0; // 使用阻塞赋值初始化
    end

    // 输出：随寄存器变化而变化
    always @(*) begin
        Data1 = register[rs];
        Data2 = register[rt];
    end

    // 在时钟下降沿写入寄存器
    always @(negedge CLK) begin
        if (RegWre && (writeReg != 5'b00000)) // 避免写入寄存器 0
            register[writeReg] <= writeData;
    end

endmodule

