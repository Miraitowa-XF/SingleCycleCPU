module ControlUnit_sim();
    // Input signals
    reg [5:0] OpCode;
    reg [5:0] func;
    reg [5:0] sign;
    reg zero;
    // Output signals
    wire PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, InsMemRW, RD, WR, RegDst, ExtSel;
    wire [1:0] PCSrc;
    wire [2:0] ALUOp;
    // Instantiate the Unit Under Test (UUT)
    ControlUnit uut (
        .OpCode(OpCode),
        .func(func),
        .zero(zero),
        .sign(sign),
        .PCWre(PCWre),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .DBDataSrc(DBDataSrc),
        .RegWre(RegWre),
        .InsMemRW(InsMemRW),
        .RD(RD),
        .WR(WR),
        .RegDst(RegDst),
        .ExtSel(ExtSel),
        .PCSrc(PCSrc),
        .ALUOp(ALUOp)
    );
    // Testbench
    initial begin
        // Record waveforms
        $dumpfile("ControlUnit16.vcd");
        $dumpvars(0, ControlUnit_sim);
        // Initialize signals
        zero = 1'b0;
        // Test Case 1: ADD (R-type)
        OpCode = 6'b000000;
        func = 6'b100000;  // ADD
        #50;
        // Test Case 2: SUB (R-type)
        OpCode = 6'b000000;
        func = 6'b100010;  // SUB
        #50;
        // Test Case 3: ADDIU (I-type)
        OpCode = 6'b001001;
        func = 6'bxxxxxx;  // Ignored for I-type
        #50;
        // Test Case 4: ANDI (I-type)
        OpCode = 6'b001100;
        func = 6'bxxxxxx;
        #50;
        // Test Case 5: AND (R-type)
        OpCode = 6'b000000;
        func = 6'b100100;  // AND
        #50;
        // Test Case 6: ORI (I-type)
        OpCode = 6'b001101;
        func = 6'bxxxxxx;
        #50;
        // Test Case 7: OR (R-type)
        OpCode = 6'b000000;
        func = 6'b100101;  // OR
        #50;
        // Test Case 8: SLL (R-type)
        OpCode = 6'b000000;
        func = 6'b000000;  // SLL
        #50;
        // Test Case 9: SLTI (I-type)
        OpCode = 6'b001010;
        func = 6'bxxxxxx;
        #50;
        // Test Case 10: SW (I-type)
        OpCode = 6'b101011;
        func = 6'bxxxxxx;
        #50;
        // Test Case 11: LW (I-type)
        OpCode = 6'b100011;
        func = 6'bxxxxxx;
        #50;
        // Test Case 12: BEQ (I-type)
        OpCode = 6'b000100;
        func = 6'bxxxxxx;
        zero = 1'b1;  // Zero condition
        #50;
        // Test Case 13: BNE (I-type)
        OpCode = 6'b000101;
        func = 6'bxxxxxx;
        zero = 1'b0;  // Non-zero condition
        #50;
        // Test Case 14: BLEZ (I-type)
        OpCode = 6'b000110;
        sign = 1'b1;  // 
        #50;
        // Test Case 15: J (J-type)
        OpCode = 6'b000010;
        func = 6'bxxxxxx;  // Ignored for J-type
        #50;
        // Test Case 16: HALT
        OpCode = 6'b111111;
        func = 6'bxxxxxx;
        #50;
        // Stop simulation
        $stop;
    end
endmodule
