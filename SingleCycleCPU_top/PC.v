`timescale 1ns / 1ps

module PC(
    input CLK, Reset, PCWre,
    input [1:0] PCSrc, 
    input signed [15:0] Immediate,   //��ָ����ȡ��������չ����
    input [31:0] JumpPC,//��ת��ַ
    output reg signed [31:0] Address,
    output [31:0] nextPC,
    output [3:0] PC4
 );
 assign nextPC = (PCSrc[0]) ? Address + 4 + (Immediate << 2) : ((PCSrc[1]) ?  JumpPC : Address + 4);
 assign PC4 = Address[31:28];
 //��clock�½��ص�����Reset�½��ص���ʱ���Ե�ַ���иı��������
always @(posedge CLK or negedge Reset) begin     
    if(Reset == 0)
        Address = 0;
    else if(PCWre) begin//PCWreΪ1ʱ��������ĵ�ַ
        if(PCSrc[0])
            Address = Address + 4 + (Immediate << 2);//��ת
        else if(PCSrc[1])
            Address = JumpPC;
        else
            Address = Address + 4;//˳��ִ����һ��ָ��
    end
 end
 endmodule
