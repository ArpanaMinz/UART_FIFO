`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2025 16:40:00
// Design Name: 
// Module Name: bin_bcd
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


module bin_bcd (
    input wire [9:0] bin, // 10-bit binary input
    output reg [3:0] ones, // Ones place
    output reg [3:0] tens,  // Tens place
    output reg [3:0] hundreds,
    output reg [3:0] thousands 
);
    always @(bin) begin
        ones = bin % 10;
        tens = (bin / 10) % 10;
        hundreds = (bin / 100) % 10;
        thousands = (bin / 1000) % 10;
    end
endmodule
