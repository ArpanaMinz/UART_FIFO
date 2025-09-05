`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2025 17:42:59
// Design Name: 
// Module Name: Bit_counter
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

module Bit_counter(
    input clk,
    input rst,
    input bit_count_enable,
    output bit_index
    );
    reg [3:0] count;
  
    always@(posedge clk,posedge rst)
    begin
      if(rst||count==4'd10)
    count <=4'd0;
    else if(bit_count_enable)
         begin
           if(count < 4'd10)
         count<=count+1;
         end   
    end
  
     assign bit_index=(count==4'd10);
  always@(posedge clk) 
    begin
       $display("Time = %t | count = %b |bit_index=%d", $time, count,bit_index);
end
endmodule

