module Col_encoder_3B (
	input clk,                           // Clock
	input rst_n,                         // Asynchronous reset active low
	input [2:0] pixel_in,                // Incoming 3-bit pixel values
	input data_valid,                    // Valid signal that flags the incoming pixel

	output reg [15:0] encoded_dat,       // encoded data in packets
	output reg data_ready               // data ready signal that flags the encoded data

	
);


// This is a column based encoder that takes in 3-bit pixel values
// It will have a builtin timer, which is 32-bit (at the moment)
// This will either encode the incoming pixel values raw in a 16 bit packet.
// When there are 5 consecutive zeros during raw encoding, The module will ditch the following 0
// And then comes back when with a preceding timestamp.


parameter IDLE = 0;
parameter SORT = 1;
parameter ZERO = 2;
parameter ALARM = 3;


reg [1:0] curr_state, next_state;
reg [31:0] time_cnt;
reg [2:0] zero_cnt;
reg [14:0] pre_sort_dat;
reg [2:0] buffer_cnt;
reg state_flag; // for Alarm state to mark up the returning state, 0 for ZERO, 1 for SORT.
reg [31:0] TS_resurrection; // only used when ZERO needs to be resurrected.
reg [1:0] resurr_cnt;

always @(posedge clk or negedge rst_n) begin : Internal_clock
	if(~rst_n) begin
		time_cnt <= 0;
	end else begin
		time_cnt <= time_cnt +1;
	end
end


always @(posedge clk or negedge rst_n) begin : Current_state_update
	if(~rst_n) begin
		curr_state <= IDLE;
	end else begin
		curr_state <= next_state;
	end
end


always @(posedge clk or negedge rst_n) begin : Internal_register_update
	if(~rst_n) begin
		zero_cnt <= 0;
		pre_sort_dat <= 0;
		data_ready <= 0;
		encoded_dat <= 0;
		buffer_cnt <= 0;
		state_flag <= 0;
		TS_resurrection <= 0;
		resurr_cnt <= 0;
	end else begin

		data_ready <= 0;

		case (curr_state)

			IDLE: 
			begin
				if (data_valid) begin
				 	pre_sort_dat <= {13'b0_0000_0000_0000, pixel_in};
				 	buffer_cnt <= buffer_cnt +1;
				 end 
			end

			SORT: 
			begin 
				if (time_cnt[15:0] == 16'hFFFF) begin
					// Switch to ALARM, clean up before switching
					encoded_dat <= {1'b0, pre_sort_dat};
					data_ready <= 1;
					state_flag <= 1;
				end
				else if (data_valid && (buffer_cnt < 3'b101)) begin
					pre_sort_dat <= {pre_sort_dat[12:0], pixel_in};
					buffer_cnt <= buffer_cnt +1;
				end
				else if (data_valid && buffer_cnt == 3'b101) begin
					// Accumulated 5 data to make a packet, clean up and accumulate again 
					encoded_dat <= {1'b0, pre_sort_dat};
					data_ready <= 1;
					pre_sort_dat <= {13'b0_0000_0000_0000, pixel_in};
					buffer_cnt <= 1;
				end

				if (data_valid && pixel_in == 0) begin
					/*
					Incoming data is 0
					*/
					if (zero_cnt < 5) begin
					/* 
					count up the zero if incoming pixel is 0 and
					the zero count is less than 5 
					*/
						zero_cnt <= zero_cnt + 1;
					end
					else begin 
						// Switch to ZERO, there is no need to clean up
						// Worst case is we are gonna lose a packet full of 0s
						// cases where there are actual numbers would have been sent off already
						zero_cnt <= 0;
						buffer_cnt <= 0;
					end
				end
				else if (data_valid && pixel_in != 0) begin
					/* 
					reset the zero counter whenever the incoming 
					pixel value is not 0 
					*/
					zero_cnt <= 0;
				end 
			end

			ZERO: 
			begin
				if (resurr_cnt == 0) begin // resurrection has not started
					if (data_valid && pixel_in != 0) 
					begin // only in this case that we will start resurrecting the state
					// slowly switch back to SORT, report the time stamp and start sorting
					pre_sort_dat <= {13'b0_0000_0000_0000, pixel_in};
					buffer_cnt <= 1;
					encoded_dat <= 16'h8000; // special packet, marks the process of resurrection
					data_ready <= 1;
					resurr_cnt <= 1;
					TS_resurrection <= time_cnt;
					end 
				end
				else if (resurr_cnt < 3) begin // resurrection has started, but the timestamp has not been fully sent off
					encoded_dat <= TS_resurrection [31:16];
					data_ready <= 1;
					resurr_cnt <= resurr_cnt +1;
					TS_resurrection <= TS_resurrection <<16;
					
					if (data_valid) begin
					pre_sort_dat <= {pre_sort_dat[12:0], pixel_in};
					buffer_cnt <= buffer_cnt + 1;
					end
				end
				else begin // Switch back to SORT properly
					resurr_cnt <= 0;

					if (data_valid) begin
					pre_sort_dat <= {pre_sort_dat[12:0], pixel_in};
					buffer_cnt <= buffer_cnt + 1;
					end
				end

				if (time_cnt[15:0] == 16'hFFFF) begin
					// switch to ALARM, flag the returning state
					state_flag <= 0;
				end
			end

			ALARM:
			begin 
				// by default it should report the timestamp
				encoded_dat <= {1'b1, time_cnt[30:16]};
				data_ready <= 1;

				// if there is incoming data in this state
				if (data_valid) begin					
						pre_sort_dat <= {13'b0_0000_0000_0000, pixel_in};
						buffer_cnt <= 1;
				end

			end
		
			default : /* default */;
		endcase
		 
	end
end


always @(*)
begin : Next_state_logic
	next_state = curr_state;

	case (curr_state)

		IDLE: 
		begin 
			if (data_valid) begin // Switch to SORT no so long as there is data
				next_state = SORT;
			end
		end

		SORT: 
		begin 
			if (data_valid && pixel_in == 0 && zero_cnt == 5 ) begin
				/* 
				switch the state to all ZERO if incoming pixel is 0
				and zero count is already 5
				*/
				next_state = ZERO;
			end
			else if (time_cnt[15:0] == 16'hFFFF) begin // ALARM went off
				next_state = ALARM;
			end
		end

		ZERO:
		begin 
			if (resurr_cnt == 2'd3) begin // Switch to SORT when resurrection finished
				// module finished outputting complete timestamp (3 clock cycles)
				next_state = SORT;
			end
			else if (time_cnt[15:0] == 16'hFFFF) begin // ALARM went off
				next_state = ALARM;
			end
		end

		ALARM:
		begin
			if (data_valid || state_flag) begin // Switch to SORT if there is incoming data or original state is SORT
			 	next_state = SORT; 
			 end 
			else
			begin 
				next_state = ZERO; // Switch to ZERO if the original state is ZERO.
			end
		end
	
		default : next_state = IDLE;
	endcase

end
endmodule