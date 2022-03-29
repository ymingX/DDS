module FM (
    input clk,      input rst,
    input[23:0]fc,  input[15:0]fd,
    output[15:0]sig_out
);
    wire[15:0]sig;
    sin_fc	sin_fc_inst (
	.clk(clk),      .rst(rst),
	 .fc(1000),       .carrier(sig)   
	);
    wire[15:0]sig_s={!sig[15],sig[14:0]};
    wire[31:0]temp;
    mult_s16x16_32	mult_s_inst (
	.dataa ( fd ),
	.datab ( sig_s ),
	.result ( temp )
	);
    wire[23:0]temp2={temp[31],temp[31],temp[31],temp[31],temp[31],temp[31],temp[31],temp[31],temp[30:15]};
    //位数不同的有符号数相加，为避免出错，先扩展至相同位数
    wire [23:0]frec=fc+temp2;

    sin_fc	sin_fc_inst1 (
	.clk(clk),      .rst(rst),
	 .fc(frec),       .carrier(sig_out)   
	);
endmodule