module Col_encoder_3B_plus_tb;

  reg clk;
  reg rst_n;
  reg [2:0] pixel_in;
  reg data_valid;
  reg [31:0] tik_tee_tok;
  wire [15:0] encoded_dat;
  wire data_ready;

  // Instantiate the DUT (Device Under Test)
  Col_encoder_3B_plus uut (
    .clk(clk),
    .rst_n(rst_n),
    .pixel_in(pixel_in),
    .data_valid(data_valid),
    .tik_tok(tik_tee_tok),
    .encoded_dat(encoded_dat),
    .data_ready(data_ready)
  );

  // Clock generation (20 MHz => 50 ns period)
  initial clk = 0;
  always #25 clk = ~clk;

  always @(posedge clk)
	begin
	   tik_tee_tok <= tik_tee_tok +1;
	end


  // Stimulus generation
  initial begin
    rst_n = 0;
    pixel_in = 3'b000;
    data_valid = 0;
   tik_tee_tok = 0;
    
    #100 rst_n = 1; // Release reset after 100 ns
    
    // Send pixel data with possible long 0 sequences
    repeat (200) begin
      pixel_in = $random % 8;
      data_valid = 1;
      #50;
      data_valid = 0;
      #50;
    end
    
    // Introduce long consecutive 0s
    repeat (20) begin
      pixel_in = 3'b000;
      data_valid = 1;
      #50;
    end

    repeat (203) begin
      pixel_in = $random % 8;
      data_valid = 1;
      #50;
      data_valid = 0;
      #50;
    end

     repeat (65536) begin
      pixel_in = $random % 8;
      data_valid = 1;
      #50;
      data_valid = 0;
      #50;
    end

    repeat (65500) begin
      pixel_in = 3'b000;
      data_valid = 1;
      #50;
    end
    
    $stop;
  end

endmodule
