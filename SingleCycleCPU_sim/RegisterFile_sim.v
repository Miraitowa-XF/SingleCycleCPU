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
        //初始化
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
        RegDst = 1;//处理R型指令
        RegWre = 1;//允许写寄存器
        DBDataSrc = 0;//使用来自ALU的输出
        rs = 5'b00000;
        rt = 5'b00001;
        rd = 5'b00010;
        dataFromALU = 32'd1;//来自ALU的输出
        dataFromRW = 32'd2;//来自RW的输出
        //Test2
        #50;
        RegDst = 0;//处理R型指令
        RegWre = 1;//允许写寄存器
        DBDataSrc = 1;//使用来自ALU的输出
        rs = 5'b00011;
        rt = 5'b00100;
        rd = 5'b00101;
        dataFromALU = 32'd3;//来自ALU的输出
        dataFromRW = 32'd4;//来自RW的输出
        //stop，需要的测试在debug阶段再写
        #100;
        $stop;
    end
 endmodule