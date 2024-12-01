`timescale 1ns / 1ps

module RegisterFile(
    input CLK, RegDst, RegWre, DBDataSrc,
    input [4:0] rs, rt, rd,
    input [31:0] dataFromALU, dataFromRW,
    output reg [31:0] Data1, Data2,
    output [31:0] writeData
);
    wire [4:0] writeReg; // Ҫд�ļĴ����˿�
    assign writeReg = RegDst ? rd : rt;

    // ALUM2Reg Ϊ 0 ʱ��ʹ������ ALU �������Ϊ 1 ʱ��ʹ���������ݴ洢����DM�������
    assign writeData = DBDataSrc ? dataFromRW : dataFromALU;

    // ��ʼ���Ĵ���
    reg [31:0] register[0:31];
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) 
            register[i] = 32'b0; // ʹ��������ֵ��ʼ��
    end

    // �������Ĵ����仯���仯
    always @(*) begin
        Data1 = register[rs];
        Data2 = register[rt];
    end

    // ��ʱ���½���д��Ĵ���
    always @(negedge CLK) begin
        if (RegWre && (writeReg != 5'b00000)) // ����д��Ĵ��� 0
            register[writeReg] <= writeData;
    end

endmodule

