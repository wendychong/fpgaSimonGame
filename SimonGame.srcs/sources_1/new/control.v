`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2017 01:00:20 PM
// Design Name: 
// Module Name: control
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


module control(
input clk,
input btnC,
input btnR,
input btnL,
output [15:0] led,
output [6:0] seg,
output [3:0] an
);


//Debug Lights from other modules
reg [4:0] debug_lights;
wire seq_led;
wire [2:0] leds;

//Used for Seven Segment Display
wire [6:0] segs;
wire [3:0] ans;

//Used for Compare
wire [3:0] btn;
wire failed;
wire ended;
wire compd;
wire correct;

//Used for Sequence Generator
wire [1:0] seq;
wire randomize;
wire new_game;
wire start_over;
wire next;

//Used for timer
wire start_time;
wire t4_flag, t5_flag, t6_flag, t30_flag;

/*Used for Sequence Generator*/
reg game_new;
reg random;

/*Used for button assignment*/
reg [2:0] btn_flag = 0;
reg a,b,c,d,e,f;


always@(posedge clk)begin
if(btnC == 1)begin
    game_new = 1;
    random = 1;
    e = 0;
    debug_lights [2] = 1;
end
else begin
    game_new = 0;
    random = 0;
end
end

always@(*)begin
if(t4_flag ==1)begin
    debug_lights [4] = 1;
    if (t30_flag && ~e) f=1;
    else if(~e) begin 
        case(btn_flag)
        0: begin
            debug_lights [3] = 1;
            e = 0;
            btn_flag = 1;
            if(btnL) a = 1;
            else if(btnR) a = 0;
            else begin 
                e = 1;
                f = 1;
            end            
        end
        1: begin
            e = 0;
            btn_flag = 2;
            if(btnL)b = 1;
            else if(btnR)b = 0;
            else begin
                f = 1;
                e = 1;
            end
        end
        2: begin
            e = 0;
            btn_flag = 3;
            if(btnL) c = 1;
            else if(btnR) c = 0;
            else begin 
                f = 1;
                e = 1;
            end
        end
        3: begin
            e = 1;
            btn_flag = 0;
            if(btnL) d = 1;
            else if(btnR) d = 0;
            else f = 1;
        end
        default: btn_flag = 0;
        endcase
    end
end
end

    /*Button sequence assignments*/
    assign btn[3] = a;
    assign btn[2] = b;
    assign btn[1] = c;
    assign btn[0] = d;   
    assign failed = f;
    assign ended = e;
    
    /*Sequence inputs*/
    assign start_over = btnC;
    assign new_game = game_new;
    assign randomize = random;
    
    /*Seven Segment Display*/
    assign an = ans;
    assign seg = segs;
    
    /*Debug lights*/
    assign led [5] = t30_flag; //Debug light
    assign led [13:12] = seq; //Sequence (for debug)
    assign led [8:7] = leds [2:1]; //Also sequence
    assign led [4:1] = debug_lights [4:1]; //Debug lights from control
    assign led [0] = t4_flag;
    assign led [6] = t5_flag;


/*Module Instantiations*/
    timer(.clk(clk), .start_over(start_over), .t4_flag(t4_flag), .t5_flag(t5_flag), . t6_flag(t6_flag), .t30_flag(t30_flag));
    Display(.clk(clk),.start_over(start_over),.t5_flag(t5_flag),.t6_flag(t6_flag), .leds(leds), .sequence(seq));
    sequence(.clk(clk), .randomize(randomize),.next(t5_flag),.start_over(start_over), .seq(seq), .leds(seq_led));
    Yeah(.clk(clk), .segs(segs), .ans(ans),.status(correct), .start(compd));
    Compare(.clk(clk), .seq(seq), .btns(btn), .failed(failed), .cmp(ended), .cmprd(compd), .correct(correct));

endmodule
