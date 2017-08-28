`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2017 04:51:36 PM
// Design Name: 
// Module Name: Display
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

module Display(
input clk,
input start_over,
input t5_flag,
input t6_flag,
output [2:0] leds,
input [1:0] sequence
);

reg debug_light;
reg [1:0] lights;

always@(posedge clk)begin
     if(t5_flag == 1) lights <= 0;
     else if (~t6_flag) lights <= sequence;
end

assign leds [2:1] = sequence;
assign leds [0] = t6_flag;

endmodule