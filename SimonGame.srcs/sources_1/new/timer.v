`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2017 09:00:35 AM
// Design Name: 
// Module Name: timer
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


module timer(
    input clk,
    input start_over,
    output t4_flag,
    output t5_flag,
    output t6_flag,
    output t30_flag
    );
    
    parameter MAX = 99_999_999;
    wire counter_en = 0;
    reg [26:0]  counter_100M = 0;
    reg [4:0]   counter_30 = 0;
    reg [2:0]   counter_6 = 0;
    reg [2:0]   counter_4 = 0;
    reg t4, t5, t6, t30;
    
    always@(posedge clk)begin
        if(start_over == 1) counter_100M =0;
        if(counter_30 == 30) counter_100M =0;
        if(counter_100M == MAX) begin
             counter_100M =0;       
             //debug_light = 0;
        end
        else begin
         counter_100M = counter_100M + 1'b1;
         //debug_light = 0;
         end
     end
    
     assign counter_en = (counter_100M == 0); 
    
    always@(posedge clk)begin
    if(counter_30 == 30) counter_6 = 0;
    if(start_over) counter_6 = 0;
    else begin
            t5 = 0;
            t6 = 0;
        if(counter_6 == 5) t5 = 1;
        else if (counter_6 == 6) begin
            t6 = 1;
            counter_6 = 0;
        end
        if(counter_100M == MAX)
            counter_6 = counter_6 + 1'b1;
     end
 end
 
 always@(posedge clk)begin
 if(counter_30 == 30) counter_4 = 0;
 if(start_over) counter_4 = 0;
 else begin
    t4 = 0;
    if(counter_4 == 4)begin
        counter_4 = 0;
        t4 = 1;
    end
    if(counter_6 == 6) counter_4 = counter_4 + 1'b1;
 end
 end
 
always@(posedge clk) begin
if(start_over) counter_30 =0;
t30 = 0;
if(counter_30 == 30) begin
    t30 = 1;
    counter_30 = 0;
end
if(counter_4 == 4) counter_30 = counter_30 + 1'b1;
end
    
 assign t4_flag = t4;
 assign t5_flag = t5;
 assign t6_flag = t6;
 assign t30_flag = t30;
 
 
endmodule
