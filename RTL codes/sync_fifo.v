`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2025 17:50:07
// Design Name: 
// Module Name: sync_fifo
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


module sync_fifo(
    input slow_clk,
    input rst,
    input rd_en,
    input wr_en,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output empty,
    output full,
    output reg [3:0] count
    );
    reg [7:0] mem [0:7];
    reg [2:0] rd_ptr;
    reg [2:0] wr_ptr;




assign empty= (count==0);
assign full= (count==4'b1000);

//count logic
always@(posedge slow_clk,posedge rst)
begin
if(rst)
count<=4'b0000;
else if ((rd_en && !empty) && (wr_en && !full))
count<=count;
else if (rd_en && !empty)
count<=count-1;
else if (wr_en && !full)
count<=count+1;
else 
count<=count;
end

//write logic
always@(posedge slow_clk,posedge rst)
begin
if(rst)
wr_ptr<=3'b000;
else if(wr_en && !full)
begin
mem[wr_ptr]<=data_in;
wr_ptr<=wr_ptr+1;
end
end

//read logic
always@(posedge slow_clk,posedge rst)
begin
if(rst) begin
rd_ptr<=3'b000;
data_out<=8'd0;
end
else if(rd_en && !empty)
begin
data_out<= mem[rd_ptr];
rd_ptr<=rd_ptr+1;
end
end

endmodule

