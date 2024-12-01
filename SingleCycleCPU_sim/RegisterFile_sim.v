`timescale 1ns / 1ps

module RegisterFile_sim();
    //inputs
    reg CLK, RegDst, RegWre, DBDataSrc;
    reg [4:0] rs, rt, rd;
    reg [31:0] dataFromALU, dataFromRW;
    //ouputs
    wire [31:0] Data1;
    wire [31:0] Data2;
    wire [31:0] writeData;
    RegisterFile uut(
        .CLK(CLK),
        .RegDst(RegDst),
        .RegWre(RegWre),
        .DBDataSrc(DBDataSrc),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .dataFromALU(dataFromALU),
        .dataFromRW(dataFromRW),
        .Data1(Data1),
        .Data2(Data2),
        .writeData(writeData)
    );
    always #15 CLK = !CLK;
    initial begin
        //record
        $dumpfile("RegisterFile.vcd");
        $dumpvars(0, RegisterFile_sim);
        //��ʼ��
        CLK = 0;
        RegDst = 0;
        RegWre = 0;
        DBDataSrc = 0;
        rs = 5'b0;
        rt = 5'b0;
        rd = 5'b0;
        dataFromALU = 32'b0;
        dataFromRW = 32'b0;
        //Test1
        #10;
        RegDst = 1;//����R��ָ��
        RegWre = 1;//����д�Ĵ���
        DBDataSrc = 0;//ʹ������ALU�����
        rs = 5'b00000;
        rt = 5'b00001;
        rd = 5'b00010;
        dataFromALU = 32'd1;//����ALU�����
        dataFromRW = 32'd2;//����RW�����
        //Test2
        #50;
        RegDst = 0;//����R��ָ��
        RegWre = 1;//����д�Ĵ���
        DBDataSrc = 1;//ʹ������ALU�����
        rs = 5'b00011;
        rt = 5'b00100;
        rd = 5'b00101;
        dataFromALU = 32'd3;//����ALU�����
        dataFromRW = 32'd4;//����RW�����
        //stop����Ҫ�Ĳ�����debug�׶���д
        #100;
        $stop;
    end
 endmodule