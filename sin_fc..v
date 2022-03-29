module sin_fc (//频率可调的载波生成模块，1k-10M正弦波，精度10Hz
    input clk,         input rst,
    input [23:0]fc,//载波频率
    output [15:0]carrier//正弦载波数字信号
);
    reg [32:0]phase;
    wire [43:0]k=((fc-1000)*703687>>13)+85899;
    /*  k'=2^12/100M*fc, delta(fc)=10Hz ,delta(k')=4.096*(10^-4); 
        先放大2^21倍最后在截取末尾21位：k:=2^21*k', delta(k)=858.993;
        k与fc一次函数关系，取一点(f0,k0), k=(fc-f0)/10*858.993+k0; 
        用*703687>>13=85.89929 代替/10*859 
        经计算，取f0=1000Hz,k0=85899时误差较小    */
    always @(posedge clk or negedge rst) begin
       if(!rst)
            phase<=0;
        else
            phase<=phase+k[32:0];
    end

   rom_sin	rom_sin_inst (
	.address ( phase[32:21] ),
	.clock ( clk ),
	.q ( carrier )
	);
 
endmodule