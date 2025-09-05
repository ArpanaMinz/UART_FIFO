`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2025 17:39:17
// Design Name: 
// Module Name: controller_rx
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


module controller_rx(
    input clk_r,
    input rst,
    input rx,
    input bit_index,
    input [13:0] wc,
    output reg rx_done,
    output reg bit_count_enable,
    output reg wait_counter_enable,
    output reg wait_counter_reset,
    output reg shift_right,
    output reg ld_sr,ld_rx
    );
   
   
    //wire [13:0] BDC;
    parameter BR=14'd9600;
    parameter clk_freq=100_000_000;
    parameter idle=3'b000;
    parameter synchronization=3'b001;
    parameter receive=3'b010;
  
    parameter check=3'b011;
    parameter r_wait=3'b100;
   
    parameter done=3'b101;
    parameter d_wait=3'b110; 
    reg [2:0] ns,ps;
   
    parameter BDC = clk_freq/BR;
   
    //register logic
    always@(posedge clk_r,posedge rst)
    begin
    if(rst)
    ps<=idle;
    else
    ps<=ns;
    end
   
    //state transition logic
    always@(ps,rx,wc,bit_index)
    begin
    case(ps)
    idle: ns=rx?idle:synchronization;
    synchronization: ns=(wc==(BDC/2)-1)?receive:synchronization;
     receive:ns=check;
     check:ns=(bit_index)?done:r_wait;
     r_wait:ns=(wc==BDC-1)?receive:r_wait;
     done:ns=d_wait;
     d_wait:ns=(rx)? d_wait:synchronization;
     default:ns=idle;
     endcase
     end
   
    //output logic
    always@(ps)
    begin
    case(ps)
    idle:begin
    wait_counter_enable=0;
    wait_counter_reset=0;
    bit_count_enable=0;
    ld_sr=0;
    shift_right=0;
    rx_done=0;
    ld_rx=0;
    end
    synchronization:begin
    wait_counter_enable=1;
    wait_counter_reset=0;
    bit_count_enable=0;
    ld_sr=0;
    shift_right=0;
    rx_done=0;
    ld_rx=0;
    end
    receive:begin
    wait_counter_enable=0;
    wait_counter_reset=1;
    bit_count_enable=1;
    ld_sr=1;
    shift_right=0;
    rx_done=0;
    ld_rx=0;
    end
    check:begin
    wait_counter_enable=0;
    wait_counter_reset=0;
    bit_count_enable=0;
    ld_sr=0;
    shift_right=1;
    rx_done=0;
    ld_rx=0;
    end
    r_wait:begin
    wait_counter_enable=1;
    wait_counter_reset=0;
    bit_count_enable=0;
    ld_sr=0;
    shift_right=0;//(wc==14'd10416);
    rx_done=0;
    ld_rx=0;
    end
    done:begin
    wait_counter_enable=0;
    wait_counter_reset=0;
    bit_count_enable=0;
    ld_sr=0;
    shift_right=0;
    rx_done=1;
    ld_rx=1;
    end
    d_wait:begin
    wait_counter_enable=0;
    wait_counter_reset=0;
    bit_count_enable=0;
    ld_sr=0;
    shift_right=0;
    rx_done=0;
    ld_rx=0;
    end
    
    default:begin
    wait_counter_enable=0;
    wait_counter_reset=0;
    bit_count_enable=0;
    ld_sr=0;
    shift_right=0;
    rx_done=0;
    ld_rx=0;
    end
    endcase
    end
always @(posedge clk_r) begin
  $display("Time=%t | ps=%0d | wc=%d | bit_index=%d | rx=%b | rx_done=%b | ld_rx=%b",
           $time, ps, wc, bit_index, rx, rx_done,ld_rx);
end


  

endmodule

