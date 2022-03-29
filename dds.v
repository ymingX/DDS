module dds (
   input clk,          input rst,
   input [23:0]fc,/*载波频率*/     input [1:0]mode,/*输出模式*/
   input [23:0]fs,/*调制频率*/     input [3:0]ma,/*调制度*/
   input [15:0]fd,/*最大频偏*/
   output reg[15:0]sig_out/*输出数字信号*/
);
	wire [15:0]sig0;
	wire[15:0]sigAM;
	wire[15:0]sigFM;
	wire[15:0]sig_demod;
	wire [15:0]sig_mod;
   sin_fc	sin_fc_inst (
	.clk(clk),      .rst(rst),
	 .fc(fc),       .carrier(sig0)   
	);

    sin_fc	sin_fc_inst2 (//生成调制信号sig_mod
	.clk(clk),      .rst(rst),
	.fc(fs),       .carrier(sig_mod)   
	);
    AM  AM_inst(
        .carrier(sig0),     .ma(ma),
        .clk(clk),
        .sig_mod(sig_mod),      .sig_out(sigAM)
    );

    FM FM_inst(
	.clk(clk) ,	// input  clk_sig
	.rst(rst) ,	// input  rst_sig
	.fc(fc) ,	// input [23:0] fc_sig
	.fd(fd) ,	// input [15:0] fd_sig
	.sig_out(sigFM) 	// output [15:0] sig_out_sig
    );
    AMdemod AMdemod_inst(
        .clk(clk),      .rst(rst),
        .sig_in(sigAM),
        .carrier(sig0),
        .sig_out(sig_demod)
    );
    always @(*) begin
        case(mode)
        1:begin sig_out<=sigAM;    end
        2:begin sig_out<=sigFM;    end
        3:begin sig_out<=sig_demod;    end
		  default:begin sig_out<=sig0; end
        endcase
    end
endmodule
