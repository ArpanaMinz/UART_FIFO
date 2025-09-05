`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2025 18:26:37
// Design Name: 
// Module Name: seven_segment_mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_segment_mux(
    input wire clk,// 100 MHz clock
    input wire rst,
    input wire [3:0] ones,// Ones place BCD digit
    input wire [3:0] tens,// Tens place BCD digit
    input wire [3:0] hundreds,// Hundreds place BCD digit
    input wire [3:0] thousands,// Thousands place BCD digit
    output wire [6:0] seg,// Seven-segment display output
    output reg [3:0] an // Anode control for display selection
    );
    reg [1:0] digit_select; // Refresh counter
    reg [3:0] digit; // Current digit being displayed
    reg [16:0] digit_timer;     // counter for digit refresh 
    
     always @(posedge clk or posedge rst) begin
        if(rst) begin
            digit_select <= 0;
            digit_timer <= 0; 
        end
        else                                        // 1ms x 4 displays = 4ms refresh period
            if(digit_timer == 99_999) begin         // The period of 100MHz clock is 10ns (1/100,000,000 seconds)
                digit_timer <= 0;                   // 10ns x 100,000 = 1ms
                digit_select <=  digit_select + 1;
            end
            else
                digit_timer <=  digit_timer + 1;
    end
    
    always @(posedge clk or posedge rst) begin
    if (rst) begin
        digit <= 4'd0;
        an <= 4'b1111;
    end else begin
        case (digit_select)
            2'b00: begin
                an <= 4'b1110;
                digit <= ones;
            end
            2'b01: begin
                an <= 4'b1101;
                digit <= tens;
            end
            2'b10: begin
                an <= 4'b1011;
                digit <= hundreds;
            end
            2'b11: begin
                an <= 4'b0111;
                digit <= thousands;
            end
        endcase
    end
end


    // Instantiate the seven-segment decoder
    seven_seg_decoder decoder (
        .bin(digit),
        .seg(seg)
    );
endmodule

