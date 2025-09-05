`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2025 18:21:39
// Design Name: 
// Module Name: dff
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


module dff(
    input clk,
    input rst,
    input d,
    output reg q,
    output wire qbar
    );
    always@(posedge clk,posedge rst)
    begin
    if(rst)
    q<=0;
    else
    q<=d;
    end 
    assign qbar=~q;
endmodule
