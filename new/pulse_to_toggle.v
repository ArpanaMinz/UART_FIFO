`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2025 17:14:42
// Design Name: 
// Module Name: pulse_to_toggle
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


module pulse_to_toggle (
    input clk,      // Fast clock (e.g., 100 MHz UART clock)
    input rst,
    input pulse,    // One-cycle pulse (rx_done)
    output reg toggle  // Toggles on every pulse
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            toggle <= 0;
        else if (pulse)
            toggle <= ~toggle;
    end
endmodule
