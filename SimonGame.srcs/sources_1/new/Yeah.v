`timescale 1ns / 1ns

module Yeah(
    input clk,
    output [6:0] segs,
    output [3:0] ans,
    input status,
    input start
    );

    
localparam N=18;
reg [N-1:0] i;
reg [6:0] sseg;
reg [3:0] anode;

always@(posedge clk)
begin
if(start ==1) begin
if(i == 400000)
    i <= 0;
else
    i <= i + 1;
end
end

always@(*)
begin
if(start == 1) begin
if(status == 1)
begin
    case(i[N-1:N-2])
    0: begin
        anode = 4'b1110;
        sseg = 7'b0001001;
    end
    1: begin
        anode = 4'b1101;
        sseg = 7'b0001000;
    end
    2: begin
        anode = 4'b1011;
        sseg = 7'b0000110;
    end
    3: begin
        anode = 4'b0111;
        sseg = 7'b0010001;
    end
    default: begin
        anode = 4'b1111;
        anode = 7'b1111111;
    end
    endcase
end
else begin
    case(i[N-1:N-2])
    0: begin
        anode = 4'b1110;
        sseg = 7'b1000111;
    end
    1: begin
        anode = 4'b1101;
        sseg = 7'b1111001;
    end
    2: begin
        anode = 4'b1011;
        sseg = 7'b0001000;
    end
    3: begin
        anode = 4'b0111;
        sseg = 7'b0001110;
    end
    default: begin
        anode = 4'b1111;
        sseg = 7'b1111111;
    end
    endcase
    end
end
else begin
sseg = 7'b1111111;
anode = 4'b1111;
end
end

assign segs = sseg;
assign ans = anode;


endmodule