`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2017 09:33:42 AM
// Design Name: 
// Module Name: counter
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

//used to count things such as the number of rounds
//that have been won or the current position in the sequence
//if reset is high, counter will reset to 0
//if increment is high, counter will be incremented by 1

module counter(
    input clk,
    input increment,
    input reset,
    output reg[4:0] count
    );
    
    always @(posedge clk) begin
        if(reset) 
            count <= 5'b00000;
        else if(increment)
            count <= count + 5'b00001;
    end
endmodule