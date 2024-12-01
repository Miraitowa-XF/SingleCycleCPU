`timescale 1ns / 1ps

module InstructionMemory(
    input [3:0] PC4,
    input [31:0] IAddr,
    input RW,//0 write, 1 read
    output [5:0] op,
    output [5:0] func,
    output [4:0] rs, rt, rd,
    output [15:0] Immediate,
    output [4:0] Sa,
    output [31:0] JumpPC,
    output reg [31:0] IDataOut
 );
//��Ϊʵ��Ҫ��ָ��洢�������ݴ洢����Ԫ���һ��ʹ��8λ��
//��˽�һ��32λ��ָ����4��8λ�Ĵ洢����Ԫ�洢
//���ļ���ȡ�������Ǻϲ�Ϊ32��ָ��
 reg [7:0] Mem[0:127];
 
 assign op = IDataOut[31:26];
 assign func = (IDataOut[31:26] == 6'b000000 ) ? IDataOut[5:0] : 6'bxxxxxx;
 assign rs = IDataOut[25:21];
 assign rt = IDataOut[20:16];
 assign rd = IDataOut[15:11];
 assign Immediate = IDataOut[15:0];
 assign Sa = IDataOut[10:6];
 assign JumpPC = {{PC4}, {IDataOut[25:0]}, {2'b00}};
 initial begin
    $readmemb("E:/vivado/Vivado_Project/Single-cycle_CPU/Instructions.txt", Mem);//���ļ��ж�ȡָ�
    IDataOut = 0;//ָ���ʼ��
end
 always @(IAddr or RW) begin
    if(RW == 1) begin
        IDataOut[7:0] = Mem[IAddr + 3];
        IDataOut[15:8] = Mem[IAddr + 2];
        IDataOut[23:16] = Mem[IAddr + 1];
        IDataOut[31:24] = Mem[IAddr];
    end
 end
 endmodule
