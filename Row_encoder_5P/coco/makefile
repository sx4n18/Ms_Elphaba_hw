## This is the mkefile for the cocotb testbench

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../rtl/Row_encoder_5P.v
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = Row_encoder_5P

# MODULE is the basename of the Python test file
MODULE = Simple_coco_test

# Generate the waveform file
WAVES = 1
VCD_FILE = $(PWD)/Row_encoder_5P_coco.vcd

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
