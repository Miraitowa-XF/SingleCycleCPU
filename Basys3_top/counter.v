`timescale 1ns / 1ps

module counter(
    input clk,
    input Reset,
    output reg[3:0] AN
    );
    reg [16:0] counter;
    parameter limit = 100000;
    initial begin
            counter <= 0;
            AN <= 4'b0111;
        end
            
        always@ (posedge clk)//????????
            begin
            if(Reset == 0) begin
              counter <= 0;
              AN <= 4'b0000;
            end else begin
                counter <= counter + 1;
                if(counter == limit)
                    begin
                        counter <= 0;
                        case(AN)
                            4'b1110 : begin
                                AN <= 4'b1101;
                            end
                            4'b1101 : begin
                                AN <= 4'b1011;
                            end
                            4'b1011 : begin
                                AN <= 4'b0111;
                            end
                            4'b0111 : begin
                                AN <= 4'b1110;
                            end
                           4'b0000 : begin
                                AN <= 4'b0111;
                           end
                        endcase
                    end
                end
            end
endmodule