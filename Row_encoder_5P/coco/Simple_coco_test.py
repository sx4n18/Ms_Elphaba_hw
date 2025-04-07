from random import randint

from cocotb.triggers import RisingEdge, FallingEdge, Timer
import cocotb
from cocotb.clock import Clock

## This is a very simple testbench written to test the functionality of the 5P encoder
## The module has the port list as below
## module Row_encoder_5P (
##	input clk,             // Clock
##	input rst_n,           // Asynchronous reset active low
##	input data_valid,      // data valid signal that indicates the validity of pixel values
##	input [14:0] pixel_in,  // pixel in from pixel, 3 bit each, but there are 5 pixels.
##	input [44:0] tik_tok,  // global timer, with 45 bit in total, which supports up to 488.67 hours

##	output reg [15:0] encoded_data,   // encoded data, each packet contains 16 bits
##	output reg data_ready			  // data ready signal flags the data validity
## );
## The clock runs at 40MHz, while the pixel_in and data valid signal are generated at 20MHz.
## In the meantime, tik_tok increment at 20MHz, which is the same as the pixel_in and data valid signal.




@cocotb.test()
async def test_5P_encoder(dut):
    """
    Test the 5P encoder.
    """

    # Create a clock signal that runs at 40MHz
    cocotb.start_soon(Clock(dut.clk, 25, units='ns').start())

    # Reset the DUT and initiate all the signals
    dut.rst_n <= 1
    dut.data_valid.value = 0
    dut.pixel_in.value = 0
    dut.tik_tok.value = 0
    await Timer(10, units='ns')
    await RisingEdge(dut.clk)
    dut.rst_n <= 0
    await RisingEdge(dut.clk)
    # wait for 23 ns seconds
    await Timer(23, units='ns')
    dut.rst_n <= 1
    await RisingEdge(dut.clk)
    await Timer(50, units='ns')
    tik_tok = 0
    await FallingEdge(dut.clk)

    # set the data_valid signal and pixel_in signal every 50 ns
    # set the tik_tok signal every 50 ns
    # set the data_valid signal to 1
    # set the pixel_in signal to a random value

    for _ in range(20):
        dut.data_valid.value = 1
        # set the pixel_in signal to a random value
        dut.pixel_in.value = randint(0, 0b111_1111_1111_1111)
        # set the tik_tok signal to a random value
        dut.tik_tok.value = tik_tok
        tik_tok += 1
        await Timer(25, units='ns')
        dut.data_valid.value = 0
        await Timer(25, units='ns')








