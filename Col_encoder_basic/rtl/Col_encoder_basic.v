module Col_encoder_basic
	(
		input clk,
		input rst_n, 
		input [1:0] pixel_in, 
		output reg [15:0] encoded_value,
		output reg val_ready
		);


/*
 This is the very basic column based encoder that will only do very basic encoding.

 Run-length encoding for zeros when there is at least 3 zeros.

	 This will start with a starting bit of 0.

 Raw encoding otherwise.
 	This will start with a starting bit of 1
*/



reg [14:0] zero_cnter;

reg [15:0] pre_out_data, pre_sort_data;

reg [2:0] buffer_cnt;


parameter IDLE = 2'b00, CNT = 2'b01, SORT = 2'b11;

/*
typedef enum logic [1:0] {
	IDLE, 
	CNT, 
	SORT
	} state_t;

state_t curr_state, next_state;
*/

reg [1:0] curr_state, next_state; 

always @(*)
begin
	
	next_state = curr_state;

	case(curr_state)

	IDLE: 
	begin 		
			next_state = SORT;
	end


	CNT:
	begin 
		if (pixel_in != 2'b00) begin
			next_state = SORT;
		end
	end 


	SORT: 
	begin
		if(zero_cnter == 3 && pixel_in == 2'b00)
		begin 
			next_state = CNT;
		end


	end

	default: next_state = IDLE;

	endcase
end




always @(posedge clk or negedge rst_n) begin  
	if(~rst_n) begin
		zero_cnter <= 0;
		curr_state <= IDLE;
		pre_sort_data <= 0;
		buffer_cnt <= 0;
		encoded_value <= 0;
		val_ready <=0;	
	end 
	else 
	begin
		curr_state <=  next_state;
		val_ready <= 0;
		 case (curr_state)

		 	IDLE: 
		 	begin 
		 		pre_sort_data <= {14'b11_1111_1111_1110, pixel_in};
		 	end
		 	

		 	CNT: 
		 	begin
		 	if (next_state == SORT) // pixel_in != 2'b00
		 		begin 
		 			encoded_value <= {1'b0, zero_cnter+1};
		 			val_ready <= 1;
		 			zero_cnter <= 0;
		 			pre_sort_data <= {14'b11_1111_1111_1110, pixel_in};
		 			//buffer_cnt <= buffer_cnt +1;
		 		end
		 		else if (zero_cnter == 15'b111_1111_1111_1111) begin
		 			encoded_value <= 16'h7FFF;
		 			val_ready <= 1;
		 			zero_cnter <= 0;
		 		end
		 		else
		 		begin 
		 			zero_cnter <= zero_cnter +1;
		 		end
		 	end



		 	SORT: 
		 	begin
		 		if (next_state == CNT) // zero_cnter == 3 && pixel_in == 2'b00)
		 		begin 
		 			zero_cnter <= 0;
		 			encoded_value <= pre_sort_data;
		 			val_ready <= 1;
		 			buffer_cnt <= 0;
		 		end
		 		else if (buffer_cnt < 6 )
		 		begin 
					pre_sort_data <= {pre_sort_data[13:0], pixel_in};
					buffer_cnt <= buffer_cnt +1;
		 		end
		 		else if (buffer_cnt == 6 )
		 		begin
		 			val_ready <= 1;
		 			encoded_value <= pre_sort_data;
		 			pre_sort_data <= {14'b11_1111_1111_1110, pixel_in};
		 			buffer_cnt <= 0;
		 		end

		 		if (pixel_in == 2'b00 && zero_cnter < 3)
		 		begin 
		 			zero_cnter <= zero_cnter +1;
		 		end
		 		else
		 		begin 
		 			zero_cnter <= 0;
		 		end


		 	end
		 
		 	default : 
		 	begin
		 		curr_state <= next_state;
		 		val_ready <= 0;
		 	end

		 endcase
	end
end


endmodule