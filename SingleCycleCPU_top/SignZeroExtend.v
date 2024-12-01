`timescale 1ns / 1ps

module SignZeroExtend(
    //��������ͨ·������?�����
    input wire [15:0] Immediate,
    input ExtSel,
    output wire [31:0] Out
);
 //��16λ�洢?����
    assign Out[15:0] = Immediate[15:0];
 //ǰ16λ����?������?��1��0�Ĳ���
    assign Out[31:16] = ExtSel == 1 ? {16{Immediate[15]}} : 16'b0;
endmodule
