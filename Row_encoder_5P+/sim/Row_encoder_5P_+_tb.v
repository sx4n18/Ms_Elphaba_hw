`timescale 1ns/1ps

module Row_encoder_5P_plus_tb;

	// Parameters
	localparam CLK_PERIOD_40MHZ = 25;   // 40MHz clock period -> 1/40MHz = 25ns
	localparam CLK_PERIOD_20MHZ = 50;   // 20MHz clock period -> 1/20MHz = 50ns
	real HALF_CLK_PERIOD_40MHZ = 12.5;

	// Signals
	reg clk = 0;
	reg rst_n = 0;
	reg data_valid = 0;
	reg [14:0] pixel_in = 0;
	reg [44:0] tik_tok = 0;

	wire [15:0] encoded_data;
	wire data_ready;

	// Instantiate the DUT (Device Under Test)
	Row_encoder_5P_plus uut (
		.clk(clk),
		.rst_n(rst_n),
		.data_valid(data_valid),
		.pixel_in(pixel_in),
		.tik_tok(tik_tok),
		.pixel_mask(5'b10111),
		.encoded_data(encoded_data),
		.data_ready(data_ready)
	);

	// Clock Generation (40 MHz)
	always #(HALF_CLK_PERIOD_40MHZ) clk = ~clk;

	// Generate 20 MHz signals
	initial begin
		// Reset the system
		rst_n = 0;
		#(5 * CLK_PERIOD_40MHZ);  // Hold reset low for some cycles
		rst_n = 1;

		// Stimulate signals
		repeat (20) begin
			// Generate 20MHz `data_valid` and `pixel_in`
			data_valid = 1;
			pixel_in = $random % 32768;    // Random 15-bit pixel value
			tik_tok = tik_tok + 1;         // Increment timer

			#(CLK_PERIOD_40MHZ);           // Wait for 20MHz cycle
			data_valid = 0;

			#(CLK_PERIOD_40MHZ);           // Low phase
		end

		// Stimulate signals
		repeat (32700) begin
			// Generate 20MHz `data_valid` and `pixel_in`
			data_valid = 1;
			pixel_in = $random % 32768;    // Random 15-bit pixel value
			tik_tok = tik_tok + 1;         // Increment timer

			#(CLK_PERIOD_40MHZ);           // Wait for 20MHz cycle
			data_valid = 0;

			#(CLK_PERIOD_40MHZ);           // Low phase
		end

		repeat (69) begin
			// Generate 20MHz `data_valid` and `pixel_in`
			data_valid = 1;
			pixel_in = 15'h24BB;    // Random 15-bit pixel value
			tik_tok = tik_tok + 1;         // Increment timer

			#(CLK_PERIOD_40MHZ);           // Wait for 20MHz cycle
			data_valid = 0;

			#(CLK_PERIOD_40MHZ);           // Low phase
		end


		// Stimulate signals
		repeat (32770) begin
			// Generate 20MHz `data_valid` and `pixel_in`
			data_valid = 1;
			pixel_in = $random % 32768;    // Random 15-bit pixel value
			tik_tok = tik_tok + 1;         // Increment timer

			#(CLK_PERIOD_40MHZ);           // Wait for 20MHz cycle
			data_valid = 0;

			#(CLK_PERIOD_40MHZ);           // Low phase
		end


		// Finish simulation
		#(100 * CLK_PERIOD_40MHZ);
		$stop;
	end

	// Monitor outputs
	initial begin
		//$monitor("Time = %0t | rst_n = %b | data_valid = %b | pixel_in = %h | tik_tok = %h | encoded_data = %h | data_ready = %b", 
		//	$time, rst_n, data_valid, pixel_in, tik_tok, encoded_data, data_ready);
		$dumpfile("waveform.vcd");
		$dumpvars(0, Row_encoder_5P_plus_tb);

	end

endmodule