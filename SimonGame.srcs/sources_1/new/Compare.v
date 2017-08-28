`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2017 12:09:31 PM
// Design Name: 
// Module Name: Compare
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


module Compare(
    input clk,
    input [3:0] seq,
    input [3:0] btns,
    input failed,
    input cmp,
    output cmprd,
    output correct
    );

    
    reg corr, cmpd;
    
always@(posedge clk)begin
if (cmp == 1 && failed == 0) begin
    cmpd = 1;
    if (seq == btns)
        corr = 1;
    else corr = 0;
end
else cmpd = 0;
end

assign correct = corr;
assign cmprd = cmpd;

endmodule
    