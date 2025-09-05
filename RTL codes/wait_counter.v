`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2025 17:41:57
// Design Name: 
// Module Name: wait_counter
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


module wait_counter(
    input clk,input rst,
    input wait_counter_reset,
    input wait_counter_enable,
    output reg [13:0] wc
    );
    always@(posedge clk,posedge rst)
    begin
    if(rst)
    wc<= 14'd0;
    else if(wait_counter_enable)
    wc<=wc+1;
    else if(wait_counter_reset)
    wc<= 14'd0;
    end
  
  endmodule

