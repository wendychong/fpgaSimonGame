`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2017 10:41:49 AM
// Design Name: 
// Module Name: sequence
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

//this generates a random sequence for the game
//this uses a perpetually running linear feedback shift register for seeding gernator
//if randomize is high, it will use the current LFSR value as the seed.
//efectively this results in choosing a new random sequence.
//if start_over is high this module moves to the start of the random sequence
//if next is high, it moves to the next element of the sequence
//seq outputs the current element of the sequence using a one-hot encoding.

module sequence(
    input clk,
    input randomize,
    input next,
    input start_over,
    input btnC,
    output [1:0] seq,
    output leds
    );
    
    
    reg debug_led;
    reg [1:0] curr = 2'b01;
    reg [3:0] sequence;
    reg [17:0] counter = 18'b100110101011010111;
    reg [17:0] seed;
    reg [17:0] current;
    reg disp_start;
    reg over_start;
    
    
    always @(posedge clk) begin
        //debug_led = 1;
        counter <= {counter [15:0], counter [17:16] ^ counter[10:9]};
        if(randomize)begin        
            seed <= counter;
            //disp_start = 0;
        end
        if(start_over == 1)begin
             current <= seed;
        end
        else if(next) begin
            current <= {current [15:0], current [17:16] ^ current [10:9]};
        end
        curr = curr << current[0];
        end
               
    assign leds = next; //debug_led;        
    assign seq =  curr;

endmodule
