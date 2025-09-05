`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2025 17:54:05
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clk,// 100 MHz input clock
    input rst,
    output reg slow_clk//Slower clock output (1hz in this case)
    );
     reg [25:0] counter;
     always @(posedge clk or posedge rst) 
     begin
        if (rst) begin
                counter <= 0;
                slow_clk <= 0;
            end 
            else if(counter == 26'd50_000_000-1)
            begin
                slow_clk<=~slow_clk;
                counter<=0;
            end
            else
                counter<=counter+1;
      end
endmodule

