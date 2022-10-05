module vga (
    input CLK,
    output [7:0] R,
    output [7:0] G,
    output [7:0] B,
    output HS,
    output VS
);

wire [9:0] h_cnt;
wire [9:0] v_cnt;

wire next_line;

up_cnt_mod #(
    .MODULO(800),
    .W(10)
)
hor_cnt
(
    .CLK(CLK),
    .CE(1'd1),      
    .CLR(1'd0),
    .Q(h_cnt),
    .CO(next_line)
);

up_cnt_mod #(
    .MODULO(525),
    .W(10)
)
ver_cnt
(
    .CLK(CLK),
    .CE(next_line),
    .CLR(1'd0),
    .Q(v_cnt)
);

wire DRAW;

assign HS = h_cnt < 7'd96;

assign VS = v_cnt < 2'd2;

assign DRAW = (h_cnt > 8'd143 & h_cnt < 10'd785) & (v_cnt > 6'd34 &  v_cnt < 10'd516);

assign R = 8'd255;
assign G = 8'd127;
assign B = 8'd64;   

endmodule