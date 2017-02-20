module vending_machine_v(clk, reset, money, confirm, drink_selected, hex0,hex1,hex2,hex3,hex4,hex5);
	input clk, reset;
	//input one_yuan, five_yuan;
	input[3:0] money;
	input confirm;
	input[3:0] drink_selected;
	output[6:0] hex0,hex1,hex2,hex3,hex4,hex5;
	
	reg[3:0] sta;
	reg [3:0] select_sta, money_sum, money_input, change, out, total, changeOrTotal, drinkOrZero;
	reg isSelled, isEnough;
	reg [5:0] left1,left2,left3,left4;
	
	parameter S_select=4'b0000,S_confirm=4'b0001,S_allselled=4'b0010,S_money=4'b0011,  
            S_enough=4'b0100,S_requirechange=4'b0101,S_change=4'b0110,S_out=4'b0111,  
            S_init=4'b1000;  
	
	display output_display(money_input, changeOrTotal, drinkOrZero, hex0,hex1,hex2,hex3,hex4,hex5);
	
	initial  
	begin  
    sta=S_init;
	 left1 = 3;
	 left2 = 15;
	 left3 = 3;
	 left4 = 3;
	 //money_input = 4'd5;
	end
	
	/*always@(posedge one_yuan or posedge five_yuan)
	begin
		if(one_yuan)
			money_input = money_input + 1;
		else if(five_yuan)
			money_input = money_input + 5;
	end*/
	
	always@(*)
	begin
		if(isSelled)
			drinkOrZero = 0;
		else
			begin
				case(drink_selected)
				4'b0001:
				drinkOrZero = 1;
				4'b0010:
				drinkOrZero = 2;
				4'b0100:
				drinkOrZero = 3;
				4'b1000:
				drinkOrZero = 4;
				default:
				drinkOrZero = drink_selected;
				endcase
			end
	end
	
	always@(*)
	begin
		if(isEnough)
			changeOrTotal = change;
		else
			changeOrTotal = total;
	end
	
	always@(posedge reset or posedge clk)
	begin
		money_input = money;
		if(reset)
			sta=S_init;
		else //if(clk)
		begin
			case(sta)
			S_init:  
          begin  
            select_sta=4'b0000;  
            //timeCnting=0;  
            money_sum=0;
				total=0;
				//money_input = 0;		
            change=0;  
            out=0;  
            //opt=0;  
              
            sta=S_select;  
          end
			 
			S_select:
			begin
				select_sta=drink_selected|select_sta;
				if(confirm)
					sta=S_allselled;
			end
			
			S_allselled:
			begin
				isSelled=0;  
            if(select_sta[0]==1 && left1<=0)  
              isSelled=1;  
            if(select_sta[1]==1 && left2<=0)  
              isSelled=1;  
            if(select_sta[2]==1 && left3<=0)  
              isSelled=1;  
            if(select_sta[3]==1 && left4<=0)  
              isSelled=1;  
              
            if(isSelled)  
              begin
				    change = money_input;
                //select_sta=4'b0000;  
                sta=S_out;  
              end  
            else  
              begin   
                sta=S_money;  
              end  
			end
			
			S_money:
			begin
				if(confirm)
				begin
					money_sum = money_input;
					sta=S_enough;
				end
			end
			
			S_enough:
			begin
				if(select_sta[0]==1)
				begin
              //money_sum=money_sum-2;
				  total = total + 2;
				  //left1 = left1 - 1;
				end  
            if(select_sta[1]==1)
				begin
              //money_sum=money_sum-2;
				  total = total + 2;  
				  //left2 = left2 - 1;
				end
            if(select_sta[2]==1)
				begin
              //money_sum=money_sum-3;
				  total = total + 3; 
				  //left3 = left3 - 1;
				end 
            if(select_sta[3]==1)  
				begin
              //money_sum=money_sum-3;
				  total = total + 3; 
				  //left4 = left4 - 1;
				end 
                
            if(money_sum>=total)
				begin
				  
				  
					if(select_sta[0]==1)
						left1 = left1 - 1;
					if(select_sta[1]==1)
						left2 = left2 - 1;
					if(select_sta[2]==1)
						left3 = left3 - 1;
					if(select_sta[3]==1)  
						left4 = left4 - 1;
				  
				  
				  money_sum = money_sum - total;
              sta=S_requirechange;
				  isEnough = 1;
				end  
            else 
				begin
              sta=S_out;
				  isEnough = 0;
				end  
			end
			
			S_requirechange:  
         begin  
           if(money_sum==0)  
             sta=S_out;  
           else if(money_sum>0)  
             sta=S_change;  
         end  
         S_change:  
         begin  
           change=money_sum;  
           sta=S_out;  
         end  
         S_out:  
         begin  
           out=select_sta;  
           //sta=S_init;  
         end  
			endcase
		end
	end
endmodule

module display(in_port0, in_port1, out_port0, hex0,hex1,hex2,hex3,hex4,hex5);
	input[3:0] in_port0, in_port1;
	input[3:0] out_port0;
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
