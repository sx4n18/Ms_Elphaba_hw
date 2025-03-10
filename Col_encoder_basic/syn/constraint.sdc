###################################################
## This is the constraint file for synthesis stage
## Created on 21 Feb 2024
###################################################

# set current design
current_design Col_encoder_basic


# create clock and timing info
create_clock -name CLK -period 50 -waveform {0 25} [get_ports "clk"]
set_clock_transition -rise 0.5 [get_clocks "CLK"]
set_clock_transition -fall 0.5 [get_clocks "CLK"]
set_clock_uncertainty 0.01 [get_clocks "CLK"]

# set falth path for reset
set_false_path -from [get_ports rst_n]

# set input delay
set_input_delay -max 1.0 [get_ports "rst_n"] -clock [get_clocks "CLK"]
set_input_delay -max 1.0 [get_ports {pixel_in[0]}] -clock [get_clocks CLK]
set_input_delay -max 1.0 [get_ports {pixel_in[1]}] -clock [get_clocks CLK]



# set output delay
set_output_delay -max 1.0 [get_ports {encoded_value[0]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[1]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[2]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[3]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[4]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[5]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[6]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[7]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[8]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[9]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[10]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[11]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[12]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[13]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[14]}] -clock [get_clocks "CLK"]
set_output_delay -max 1.0 [get_ports {encoded_value[15]}] -clock [get_clocks "CLK"]

set_output_delay -max 1.0 [get_ports "val_ready"] -clock [get_clocks "CLK"]



