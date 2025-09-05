`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2025 18:22:54
// Design Name: 
// Module Name: bin_to_bcd
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


module bin_to_bcd(
    input wire [7:0] bin,// 8-bit binary input
    output reg [3:0] ones,//ones place
    output reg [3:0] tens,//tens place
    output reg [3:0] hundreds,//hundreds place
    output reg [3:0] thousands//thousands place
    );
    always @(bin) begin
        ones = bin % 10;
        tens = (bin / 10) % 10;
        hundreds = (bin / 100) % 10;
        thousands = (bin / 1000) % 10;
    end
endmodule

