`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2017 10:30:30 AM
// Design Name: 
// Module Name: button_sync
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

//This module is used for sycronizing the keys to the clock.
//The key input is active low, like the keys on the board.
//This module inverts the buttons so that the pressed output is active high
//button_down is high if any of the buttons are pressed

module button_sync(
    input clk,
    input [3:0] key,
    output button_down,
    output reg [3:0] pressed
    );
    
    // used to avoid metastability
    reg [3:0] key1;
    
    assign button_down = |pressed;
    
    always @(posedge clk) begin
        pressed <= key1;
        key1 <= key;
    end
endmodule
