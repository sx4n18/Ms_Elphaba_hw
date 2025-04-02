`timescale 1ns/1ps

module tb_Row_encoder_10P;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg data_valid;
    reg [29:0] pixel_in;
    reg [29:0] tik_tok;
    wire [31:0] encoded_data;
    wire data_ready;



    // Parameters
    localparam CLK_PERIOD_40MHZ = 25;   // 40MHz clock period -> 1/40MHz = 25ns
    localparam CLK_PERIOD_20MHZ = 50;   // 20MHz clock period -> 1/20MHz = 50ns
    real HALF_CLK_PERIOD_40MHZ = 12.5;


    // Instantiate the Row_encoder_10P module
    Row_encoder_10P uut (
        .clk(clk),
        .rst_n(rst_n),
        .data_valid(data_valid),
        .pixel_in(pixel_in),
        .tik_tok(tik_tok),
        .encoded_data(encoded_data),
        .data_ready(data_ready)
    );

    // Clock generation for 40 MHz
    always begin
        #(HALF_CLK_PERIOD_40MHZ) clk = ~clk;  // 40 MHz clock (25 ns period)
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        data_valid = 0;
        pixel_in = 30'd0;
        tik_tok = 30'd0;

        // Apply reset
        $display("Applying reset...");
        #25 rst_n = 1;   // Release reset after 25 ns (1 clock cycle)

        // Repeat the data sending process 500 times
        $display("Sending data 500 times...");
        repeat (500) begin
            #(CLK_PERIOD_40MHZ) data_valid = 1; pixel_in = $random; tik_tok = tik_tok + 1;  // Increment tik_tok at 20 MHz rate
            #(CLK_PERIOD_40MHZ) data_valid = 0;  // Deassert data_valid after 1 clock cycle
            #(CLK_PERIOD_40MHZ);  // Wait for 1 clock cycle before sending next data
        end



        // Stimulate signals
        repeat (32700) begin
            // Generate 20MHz `data_valid` and `pixel_in`
            data_valid = 1;
            pixel_in = $random;    // Random 15-bit pixel value
            tik_tok = tik_tok + 1;         // Increment timer

            #(CLK_PERIOD_40MHZ);           // Wait for 20MHz cycle
            data_valid = 0;

            #(CLK_PERIOD_40MHZ);           // Low phase
        end

        repeat (69) begin
            // Generate 20MHz `data_valid` and `pixel_in`
            data_valid = 1;
            pixel_in = 30'h14AA_24BB;    // Random 15-bit pixel value
            tik_tok = tik_tok + 1;         // Increment timer

            #(CLK_PERIOD_40MHZ);           // Wait for 20MHz cycle
            data_valid = 0;

            #(CLK_PERIOD_40MHZ);           // Low phase
        end

         // Stimulate signals
        repeat (32700) begin
            // Generate 20MHz `data_valid` and `pixel_in`
            data_valid = 1;
            pixel_in = $random;    // Random 15-bit pixel value
            tik_tok = tik_tok + 1;         // Increment timer

            #(CLK_PERIOD_40MHZ);           // Wait for 20MHz cycle
            data_valid = 0;

            #(CLK_PERIOD_40MHZ);           // Low phase
        end

        // End simulation after sending 500 data points
        #100 $finish;
    end

    // Monitor output signals
    initial begin
        $monitor("At time %t, rst_n = %b, data_valid = %b, pixel_in = %h, tik_tok = %h, encoded_dat = %h, data_ready = %b", 
                  $time, rst_n, data_valid, pixel_in, tik_tok, encoded_data, data_ready);
    end

endmodule

