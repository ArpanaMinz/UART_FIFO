`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2025 17:19:27
// Design Name: 
// Module Name: toggle_sync_edge_detect
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


module toggle_sync_edge_detect (
    input wire clk,            // 1 Hz clock
    input wire rst,
    input wire toggle_in,      // From UART domain
    output wire wr_en_pulse     // One-cycle write enable 
);
    reg toggle_sync_0, toggle_sync_1;
    reg toggle_sync_2;

    // Double flip-flop synchronization
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            toggle_sync_0 <= 0;
            toggle_sync_1 <= 0;
        end else begin
            toggle_sync_0 <= toggle_in;
            toggle_sync_1 <= toggle_sync_0;
        end
    end

    // Edge detection
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            toggle_sync_2 <= 0;
        end else begin
            toggle_sync_2 <= toggle_sync_1;
        end
    end
assign wr_en_pulse = (toggle_sync_2 ^ toggle_sync_1);  // Detect toggle
endmodule