module Row_encoder_5P (
	input clk,             // Clock
	input rst_n,           // Asynchronous reset active low
	input data_valid,      // data valid signal that indicates the validity of pixel values
	input [14:0] pixel_in,  // pixel in from pixel, 3 bit each, but there are 5 pixels.
	input [44:0] tik_tok,  // global timer, with 45 bit in total, which supports up to 488.67 hours

	output reg [15:0] encoded_data,   // encoded data, each packet contains 16 bits
	output reg data_ready			  // data ready signal flags the data validity
);



// This encoder module will take 5 pixels at a time so that it can pack the information
// into a 16-bit word:
// 1) Raw packing
// The packet will start with value 0, raw data of 5 pixels will be packed following the
// starting 0.
// 
// 0_xxx_xxx_xxx_xxx_xxx
//
// 2) Timestamp
// If there is any repeating pattern, the module will stop sending encoded data until 
// this pattern is broken. But before that, it will send a timestamp, this timestamp
// has a leading 1 and is followed by a 15-bit timestamp
// 
// 1_ttt_tttt_tttt_tttt
// 
// The following packet is reserved to report a loop around of the time, this shall be 
// sent every 2^15 cycles
// 
// 1000_0000_0000_0000


// registers declaration

reg [14:0] repeating_pixels;
reg [14:0] tok_record;
reg [1:0] curr_state, next_state;
reg data_flag, state_flag, wake_up_flag;
reg data_valid_x_1;
wire data_valid_rising;

always @(posedge clk)
begin
	data_valid_x_1 <= data_valid;
end


assign data_valid_rising = data_valid & (~data_valid_x_1);



parameter IDLE = 0;
parameter PUSH = 1;
parameter ALARM = 2;
parameter WAIT = 3;







always @(posedge clk, negedge rst_n)
begin: STATE_REG 
if (!rst_n) 
	curr_state <= IDLE;
else
	curr_state <= next_state;
end


always @(posedge clk or negedge rst_n) 
begin : REG_UPDATE
	if(~rst_n) begin
		repeating_pixels <= 0;
		data_flag <= 0;
		state_flag <= 0;
		wake_up_flag <= 0;
		tok_record <= 0;
	end else begin
		
		case (curr_state)

		IDLE: 
		begin 
			if (data_valid_rising) begin
				repeating_pixels <= pixel_in;
				data_flag <= 1;
			end
		end

		PUSH:
		begin
			// check if the state is just switched back from WAIT
			if (wake_up_flag) begin 
				wake_up_flag <= 0;
			end
			else 
			// push new data in the buffer if the input data is valid and different
			// set the flag so it can be output
			if (data_valid_rising && (repeating_pixels != pixel_in)) begin 
				repeating_pixels <= pixel_in;
				data_flag <= 1;
			end
			// if the input is not valid OR the input data is repeating, check the data flag
			// it should only last for one more cycle.
			else if (data_flag) begin
				data_flag <= 0;
			end
			 
			if (tik_tok[14:0] == 15'h7FFF) begin
			 	state_flag <= 1;
			end 

		end 

		ALARM:
		begin 
			if (data_flag) begin
				data_flag <= 0;
			end
			// if there is data coming in during ALARM
			else if (data_valid_rising && (repeating_pixels != pixel_in))begin 
				repeating_pixels <= pixel_in;
				data_flag <= 1;
			end

		 end 

		WAIT:
		begin 
			if (data_valid_rising && (repeating_pixels != pixel_in)) begin
				repeating_pixels <= pixel_in;
				data_flag <= 1;
				wake_up_flag <= 1;
				tok_record <= tik_tok [14:0];
			end

			else if (data_flag)
			begin 
				data_flag <= 0;	
			end

			if (tik_tok[14:0] == 15'h7FFF) begin
				state_flag <= 0;
			end

		 end 
		
		
		default : /* default */;
		endcase

	end
end


always @(*) 
begin : COMB_FSM

	next_state = curr_state;
	encoded_data = 0;
	data_ready = 0;
	case (curr_state)

		IDLE:
		begin 
			if (data_valid_rising) begin
				next_state = PUSH;
			end
		 end 

		PUSH:
		begin
			// if the state just switched back from WAIT, output timestamp first
			if (wake_up_flag) begin
				encoded_data = {1'b1, tok_record};
				data_ready = 1;
			end
			else
			// if the data flag is up, the data should be output
			// (input data is valid and different and has been saved in the buffer)
			if (data_flag)
			begin 
				encoded_data = {1'b0, repeating_pixels};
				data_ready = 1;
			end 

			// if the data is valid and repeating
			if (data_valid_rising && (repeating_pixels == pixel_in)) begin
				next_state = WAIT;
			end
			else if (tik_tok[14:0] == 15'h7FFF) begin
				next_state = ALARM;
			end

		end 

		ALARM: 
		begin
			if (data_flag) begin
			 	encoded_data = {1'b0, repeating_pixels};
			 	data_ready = 1;
			end
			else
			begin 
				encoded_data = 16'h8000;
				data_ready = 1;
				
				if (state_flag) 
				begin
					next_state = PUSH;
				end
				else
				begin 
					next_state = WAIT;
				end
			
			end 
			

			
		end


		WAIT: 
		begin
			// if the incoming data is not the same, we should switch to push 
			if (data_valid_rising && (repeating_pixels != pixel_in)) begin
				next_state = PUSH;
			end
			// else if there is an alarm
			else if (tik_tok[14:0] == 15'h7FFF) begin
				next_state = ALARM;
			end

		end

	
		default : next_state = IDLE;
	endcase

end

endmodule