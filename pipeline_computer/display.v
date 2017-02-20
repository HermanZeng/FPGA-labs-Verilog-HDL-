module display(in_port0, in_port1, out_port0, hex0,hex1,hex2,hex3,hex4,hex5);
	input[3:0] in_port0, in_port1;
	input[31:0] out_port0;
	output[6:0] hex0,hex1,hex2,hex3,hex4,hex5;
	wire out_adapt;
	//assign out_adapt = out_port0[3:0];
	wire	[3:0]	in0_high;
	wire	[3:0]	in0_low;
	wire	[3:0]	in1_high;
	wire	[3:0]	in1_low;
	wire	[3:0]	out0_high;
	wire	[3:0]	out0_low;
	
	assign in0_low = in_port0 % 10;
	assign in0_high = in_port0 / 10;
	assign in1_low = in_port1 % 10;
	assign in1_high = in_port1 / 10;
	assign out0_low = out_port0 % 10;
	assign out0_high = out_port0 / 10;
	
	sevenseg	LED8_in0_low ( in0_low, hex0 );
	sevenseg	LED8_in0_high ( in0_high, hex1 );
	sevenseg	LED8_in1_low ( in1_low, hex2 );
	sevenseg	LED8_in1_high ( in1_high, hex3 );
	sevenseg	LED8_out0_low ( out0_low, hex4 );
	sevenseg	LED8_out0_high ( out0_high, hex5 );
endmodule

module	sevenseg ( data, ledsegments); 
	input [3:0] data;
	output ledsegments; 
	reg [6:0] ledsegments;
	
	always @ (*)
		case(data)
			0: ledsegments = 7'b100_0000;
			1: ledsegments = 7'b111_1001; 
			2: ledsegments = 7'b010_0100; 
			3: ledsegments = 7'b011_0000; 
			4: ledsegments = 7'b001_1001; 
			5: ledsegments = 7'b001_0010;
			6: ledsegments = 7'b000_0010; 
			7: ledsegments = 7'b111_1000; 
			8: ledsegments = 7'b000_0000; 
			9: ledsegments = 7'b001_0000;
			default: ledsegments = 7'b111_1111;
		endcase
endmodule