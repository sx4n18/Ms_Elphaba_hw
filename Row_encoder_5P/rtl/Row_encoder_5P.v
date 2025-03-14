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




endmodule