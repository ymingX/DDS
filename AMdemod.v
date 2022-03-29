module AMdemod (
    input clk,         input rst,
    input [15:0]sig_in, 
    input [15:0]carrier,      
    output [15:0]sig_out
);
    wire[31:0]sig_temp;wire[31:0]sig_temp2;
    wire[15:0]sig_in_s={!sig_in[15],sig_in[14:0]};
    wire[15:0]carrier_s={!carrier[15],carrier[14:0]};、

    /*将以调制信号与载波信号相乘，积化和差可得：
      [(1+ma*sin(w_s*t))*sin(w_c*t)]*sin(w_c*t)=f[ sin(2w_c*t),sin((2w_c+w_s)*t),sin(w_s*t) ]
      再通过低通滤波器滤去高频信号可得 sin(w_s*t)  */
    mult_s16x16_32	mult_s_inst (
	.dataa ( sig_in_s ),
	.datab ( carrier_s ),
	.result ( sig_temp )
	);
    filter filter_inst(
    .clk(clk),      .clk_enable(1'b1),
    .reset(rst),    .filter_in(sig_temp[30:15]),
    .filter_out(sig_temp2)
    );
    //assign sig_out=sig_temp2[30:15]+32768;
    assign sig_out=sig_temp2[15:0]+32768;

endmodule