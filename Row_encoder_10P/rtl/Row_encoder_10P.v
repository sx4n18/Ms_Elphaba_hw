module Row_encoder_10P(

	input clk,
	input rst_n,

	input data_valid,		// data is valid when this flag is up
	input [29:0] pixel_in,		// the input 10 pixels value
	input [29:0] tik_tok,		// global absolute timer
	
	output reg [31:0] encoded_data,	// encoded data by this compression module
	output reg data_ready

);


/*
	This module is the extension to the 5 pixel row based compression module, it takes in 30-bit pixel values
	as well as the global absolute timer.

	Similarly, when the input pixel values are different, it will just output data at 20 MHz in the format:
		00_{dat, dat, dat, dat ... dat}

	When there is repeating pattern, it will stop outputting data until this pattern is broken.
	And because the module operates at the rate of 40 MHz, it will First output the timestamp of "pattern-broken-time"
	in the format:
		01_{minute, seconds}

	Whenever the tik tok global timer loops around, aka tik_tok = 30'h3FFF_FFFF, it will trigger a brief packet to send
	in the format:
		10_00_0000_0000_0000_0000_0000_0000_0000 --> 32'h8000_0000

	
	The prefix used are 00, 01, 10, 11 has not been used yet
*/


reg [29:0] repeating_pixels;
reg [1:0] next_state, curr_state;
reg wake_up_flag, state_flag, data_flag;
reg data_valid_1;
wire data_valid_rising;
reg [29:0] tok_record;


parameter IDLE = 0;
parameter PUSH = 1;
parameter WAIT = 2;
parameter ALARM = 3;



always @(posedge clk) begin
	data_valid_1 <= data_valid;
end

assign data_valid_rising = data_valid & (~data_valid_1);



always @(posedge clk, negedge rst_n)
begin: Current_state_update
	if(!rst_n)
	begin
		curr_state <= IDLE;
	end
	else
	begin
		curr_state <= next_state;
	end

end


always @(posedge clk, negedge rst_n)
begin: Internal_register_update

	if(!rst_n) //internal register reset
	begin
		repeating_pixels <= 0;
		wake_up_flag <= 0;	
		state_flag <= 0;
		data_flag <= 0;
		tok_record <= 0;

	end
	else
	begin
		case(curr_state)
		
		IDLE:
		begin
			if (data_valid_rising) begin
				repeating_pixels <=  pixel_in;
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

			if (tik_tok == 30'h3FFF_FFFF) begin
				state_flag <= 1;
			end
			
		end

		WAIT:
		begin
			if (data_valid_rising && (repeating_pixels != pixel_in)) begin
				repeating_pixels <= pixel_in;
				data_flag <= 1;
				wake_up_flag <= 1;
				tok_record <= tik_tok ;
			end

			else if (data_flag)
			begin 
				data_flag <= 0;	
			end

			
			if (tik_tok == 30'h3FFF_FFFF) begin
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

		default: /* */;
		endcase
	

	end

end



always @(*)
begin: Next_state_logic

// Default combinational assignment
next_state = curr_state;
encoded_data = 0;
data_ready = 0;

		case(curr_state)
		
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
				encoded_data = {2'b01, tok_record};
				data_ready = 1;
			end
			else
			// if the data flag is up, the data should be output
			// (input data is valid and different and has been saved in the buffer)
			if (data_flag)
			begin 
				encoded_data = {2'b00, repeating_pixels};
				data_ready = 1;
			end 

			// if the data is valid and repeating
			if (data_valid_rising && (repeating_pixels == pixel_in)) begin
				next_state = WAIT;
			end
			else if (tik_tok == 30'h3FFF_FFFF) begin
				next_state = ALARM;
			end

		end

		WAIT:
		begin
			// if the incoming data is not the same, we should switch to push 
			if (data_valid_rising && (repeating_pixels != pixel_in)) begin
				next_state = PUSH;
			end
			// else if there is an alarm
			else if (tik_tok == 30'h3FFF_FFFF) begin
				next_state = ALARM;
			end

		end

		ALARM:
		begin
			if (data_flag) begin
			 	encoded_data = {2'b00, repeating_pixels};
			 	data_ready = 1;
			end
			else
			begin 
				encoded_data = 32'h8000_0000;
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

		default: next_state = IDLE;
		endcase


end


endmodule
