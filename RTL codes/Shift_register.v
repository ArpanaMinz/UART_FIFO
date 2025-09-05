`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2025 17:40:43
// Design Name: 
// Module Name: Shift_register
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


module Shift_register(
    input clk,
    input rst,
    input data_in,
    input ld_sr,
    input shift_right,
    input ld_rx,
    output reg [7:0] data_out
    );
    reg [9:0] data;
    //reg [7:0] out;
   
    always@(posedge clk,posedge rst)
    begin
    if(rst)begin
    data<=10'd0;
   data_out<= 8'd0;end
   else begin
  
     if(ld_sr)
    data<={data_in,data[8:0]};
    
     else if(shift_right)
     data<=data>>1;   
  
    else if(ld_rx)
    data_out<=data[7:0];
    end 
    end

  always @(posedge clk) begin
    $display("Time=%t | data_in=%b | ld_sr=%b | shift_right=%b |data=%b |ld_rx=%b | data_out=%b",
           $time, data_in,ld_sr,shift_right,data,ld_rx,data_out);
end
endmodule

