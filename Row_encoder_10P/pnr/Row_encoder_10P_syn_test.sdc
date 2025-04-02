## This is a test mode constraint SDC file
set_case_analysis 1 [get_ports SE]
## setup uncertainty should be around 10% of clock period or larger max
	## 5ns should do for low speed designs
	## hold uncertainty about the delay of an INHDX1 in typical opcond (1.8V/25C)
create_clock -name CLK -period 500 -waveform {0 250} [get_ports clk]
set_clock_latency 5 [get_clocks CLK]
set_clock_uncertainty -setup 2.5 [get_clocks CLK]
set_clock_uncertainty -hold 0.3 [get_clocks CLK]
## timing of the IO signals
## half way between the active clock edges is usually “the safe way”
## this has to be adapted to the required IO timing of course!
set_input_delay -clock [get_clocks CLK] -add_delay 125 [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 125 -clock CLK [all_outputs]
## environment of the IO signals
## assuming a weak driver from outside and a reasonable load (0.4 pf is
## approx.. 2 mm of wiring in 180nm). Here you should model the environment
## of your block if you know better
set_driving_cell -lib_cell INHDX1 [all_inputs]
set_load 0.4 [all_outputs]
