`timescale 1ns / 1ps

module Col_encoder_tb;
    // Clock and reset
    reg clk;
    reg rst_n;
    reg [1:0] pixel_in;
    wire [15:0] encoded_value;
    wire val_ready;
    
    // Clock period for 20MHz (50ns cycle time)
    localparam CLK_PERIOD = 50;
    
    // Instantiate the DUT (Device Under Test)
    Col_encoder_basic dut (
        .clk(clk),
        .rst_n(rst_n),
        .pixel_in(pixel_in),
        .encoded_value(encoded_value),
        .val_ready(val_ready)
    );
    
    // Clock generation
    always begin
        #(CLK_PERIOD / 2) clk = ~clk;
    end
    
    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        pixel_in = 0;
        
        // Hold reset for some cycles
        #(CLK_PERIOD * 5);
        rst_n = 1; // Release reset
        
        // Start feeding pixel data at 20MHz
        repeat (233) begin // Generate 20 pixel values
            @(posedge clk);
            
            pixel_in = $random % 4; // Generate random 2-bit values
        end
        
        repeat(100) begin
        	@(posedge clk);
        	
        	pixel_in = 0;
        end

        repeat(10) begin
        	@(posedge clk);
        	
        	pixel_in = 3;
        end

        // Wait for some cycles to observe output
        #(CLK_PERIOD * 10);
        
        // End simulation
        $stop;
    end
endmodule
