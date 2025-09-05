`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2025 17:48:13
// Design Name: 
// Module Name: Top_module
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


module Top_module(
    input clk,
    input rst,
    input rx,
    output LED,
    output LED1,
    input btn,     // Pushbutton for read
    output full,         // FIFO full signal
    output empty,        // FIFO empty signal
    output [7:0] d_out,
    output [6:0] seg,    // 7-segment display output
    output [3:0] an      // 7-segment display anode control
    );
    wire slow_clk;
   wire bit_index;
    wire [13:0]wc;
    wire bit_count_enable,wait_counter_enable,wait_counter_reset,shift_right,ld_sr,ld_rx;
  wire rx_done;
  wire [7:0]data_out;
  wire [3:0]count;
  //wire [7:0] d_out;
     wire q3,q3bar,q4,q4bar,rd_pulse,wr_pulse,toggle;
//     reg [7:0] d_out_latched;

  
    clk_div clk_divider(
        .clk(clk),
        .rst(rst),
        .slow_clk(slow_clk)
    );

    Bit_counter bit_count(.clk(clk),
    .rst(rst),
    .bit_count_enable(bit_count_enable),
    .bit_index(bit_index));
   
    wait_counter wait_count(.clk(clk),.rst(rst),
    .wait_counter_reset(wait_counter_reset),
    .wait_counter_enable(wait_counter_enable),
    .wc(wc));
   
    Shift_register shift_reg(.clk(clk),
    .rst(rst),
    .data_in(rx),
    .ld_sr(ld_sr),
    .shift_right(shift_right),
    .ld_rx(ld_rx),
    .data_out(data_out));
     
    controller_rx control_rx(.clk_r(clk),
    .rst(rst),
    .rx(rx),
    .bit_index(bit_index),
    .wc(wc),
    .rx_done(rx_done),
    .bit_count_enable(bit_count_enable),
    .wait_counter_enable(wait_counter_enable),
    .wait_counter_reset(wait_counter_reset),
    .shift_right(shift_right),
    .ld_sr(ld_sr),
    .ld_rx(ld_rx));
    
    pulse_to_toggle p_to_togg(.clk(clk),
    .rst(rst),
    .pulse(rx_done),
    .toggle(toggle));
    
    toggle_sync_edge_detect dut(.clk(slow_clk),
    .rst(rst),
    .toggle_in(toggle),
    .wr_en_pulse(wr_pulse));
    
    assign LED=wr_pulse;
    
     // Debounce for Read btn
    dff dff1(.clk(slow_clk), .rst(rst), .d(btn), .q(q3), .qbar(q3bar));
    dff dff2(.clk(slow_clk), .rst(rst), .d(q3), .q(q4), .qbar(q4bar));
    assign rd_pulse = q3 & q4bar;

    assign LED1=rd_pulse;
    
    // FIFO Instance
    sync_fifo syncfifo (
        .slow_clk(slow_clk),
        .rst(rst),
        .rd_en(rd_pulse),
        .wr_en(wr_pulse),
        .data_in(data_out),  
        .data_out(d_out),
        .empty(empty),
        .full(full),
        .count(count)
    );
     seven_seg seg_inst(.bin(count), .seg(seg));

    assign an = 4'b1110; // Enable first digit
   
endmodule

