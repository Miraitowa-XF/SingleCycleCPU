`timescale 1ns / 1ps

module basys3(
    input clk,      //ʱ���ź�
    input [1:0] SW, //ѡ������ź�
    input Reset, //���ð�ť
    input Button, //���а�ť
    output [3:0] AN, //�����ѡ���ź�
    output [7:0] Out //����������ź�
    );
    
    wire [31:0] curPC;     //��ǰ��PC
    wire [31:0] DBData;    //DB����
    wire [31:0] Instruction; //��ǰ��ַ��ָ��
    wire [31:0] regRs;     //�Ĵ�����rs�Ĵ����ĵ�ַ
    wire [31:0] regRt;    //�Ĵ�����rt�Ĵ����ĵ�ַ
    wire [5:0] Opcode;    //ָ���OP��
    wire [31:0] Out1, Out2; //Out1Ϊrs�Ĵ����е�ֵ��Out2Ϊrt�Ĵ����е�ֵ
    wire [31:0] Result;   //ALU�����õ��Ľ��
    wire myCLK;          //��������ź�
    wire clk_sys;        //��Ƶ����ź�
    wire [3:0] store;    //��¼��ǰҪ��ʾλ��ֵ
    wire [31:0] nextPC;  //��һ��PC
    
    SingleCycleCPU my_SCPU(myCLK, Reset, regRs, regRt, Opcode, Out1, Out2, curPC, nextPC, Result, DBData, Instruction);  //CPU 
    CLK_slow cd(clk,Reset,clk_sys);   //��Ƶ
    Keyboard_CLK my_key(clk_sys, Reset, Button, myCLK);  //����
    counter my_ct(clk, Reset, AN);    //����
    Display_7SegLED led(store, Out);  //��ʾ
    change my_cg(myCLK, Reset, AN, SW, Result, curPC, nextPC, DBData, Out1, Out2, Instruction, store);    //ȡֵ
endmodule
