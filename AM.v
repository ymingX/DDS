module AM (
    input [15:0]carrier,    input [3:0]ma,//[1,10] 调制度(x0.1)
    input [15:0]sig_mod,         input clk,
    output [15:0]sig_out
);
    //sigout=(32767+0.1ma*sig_mod(signed) )*carrier(signed)=(32767+temp)*carrier=sum*carrier
    //0.1ma*sig_mod=(ma*102*sig_mod)>>10
    
    wire[15:0] maa=ma*102;

    

    wire [15:0]carrier_s={!carrier[15],carrier[14:0]};
	wire [16:0]sig_mod_s={!sig_mod[15],!sig_mod[15],sig_mod[14:0]}; //无符号转有符号
    wire [31:0]temp;
    mult_s17x16_32	mult_s_inst (
	.dataa ( sig_mod_s ),
	.datab ( maa ),
	.result ( temp )
	);
	wire[16:0]sum={temp[31],temp[24:9]}+32767;

   wire [31:0]result;

    mult_s17x16_32	mult_s_inst2 (
	.dataa ( sum ),
	.datab ( carrier_s ),
	.result ( result )
	);
    assign sig_out=result[30:15]+32768;
endmodule