import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from scipy.sparse import save_npz, load_npz
import numpy as np
from cocotb.regression import TestFactory
from cocotb.clock import Clock
from cocotb.utils import get_sim_time

## This testbench will test the 5P row encoder with the data from the quantised JC_gen_data
## And because the data is more than 5 Pixels, it will need to be split into 5 pixel chunks
## Correspondingly, the testbench shall run the test iteratively until all the data is processed

def split_data(data, batch_size):
    """
    Splits the data into chunks of the specified batch size.
    """
    split_data = []
    for i in range(0, len(data), batch_size):
        split_data.append(data[:,i:i + batch_size])
    return split_data

def get_data_ready_for_driver(data):
    """
    This function shall prepare the input data ready for the driver.

    This function expects the data to be a 1 by 5 numpy ndarray, where each element should be within the range of [0,7]
    This function will convert the data into a 15 bit binary number where each value will take up 3 bits.
    The data should be in the order of [4, 3, 2, 1, 0]
    """
    data_ready = 0
    for i in range(5):
        data_ready = (data_ready << 3) | int(data[4-i])
    return data_ready


## First, data needs to be load

Quan_data = load_npz("../../JC_gen_data/Quan_dat_files/ColB_quantised.npz").toarray()
datay, datax = np.shape(Quan_data)
print("The shape of the data is: ", datax, datay)

bathch_size = 5
num_iter = int(datax / bathch_size)
print("The number of iterations is: ", num_iter)
print("There will be ", datay, "rows of data to be processed")

# The data needs to be split into 5 pixel chunks
split_data = split_data(Quan_data, bathch_size)
input_data_lib = split_data[100:102]
print("The number of input data is: ", len(input_data_lib))
print("Input data size:", input_data_lib[0].shape)

# Open up the text file to record the monitored data
monitor_file = open("./monitor_data.txt", "w")
monitor_file.write("This is the monitored data for the 5P row encoder test\n")
monitor_file.write("The number of iterations is: " + str(num_iter) + "\n")
monitor_file.write("////////////////////////////////////////////////////\n")
monitor_file.close()



@cocotb.coroutine
async def monitor_data(dut, monitor_file):
    """
    Monitor the output data from the DUT.
    
    The output data encoded_data is the encoded data from the DUT, which will be flagged valid
    when data_valid is high.

    """
    while True:
        # Wait for the data_valid signal to be high
        await RisingEdge(dut.clk)
        if dut.data_ready.value == 1:
            # Read the output data
            encoded_data = int(dut.encoded_data.value)
            # Print the output data in hex format
            print(f"Encoded data: {encoded_data:04x}")
            # Write the output data to the text file in hex format
            monitor_file.write(hex(encoded_data) + "\n")

@cocotb.coroutine
async def tik_tok_increment(dut):
    """
    This function will increment the tik_tok signal at 20MHz
    """
    tik_tok_value = 0
    while True:
        await RisingEdge(dut.clk)
        dut.tik_tok.value = tik_tok_value
        await Timer(25, units='ns')
        tik_tok_value += 1



@cocotb.coroutine
async def test_5P_row_encoder(dut, input_data):
    """
    Test the 5P row encoder with the quantised data.
    where the module will be running at 40 MHz and the data_valid signal and pixel_in signal will be set at 20 MHz.
    """
    ## Set up the running clock
    cocotb.start_soon(Clock(dut.clk, 25, units='ns').start())

    ## open the specific text file
    # Open up the text file to record the monitored data
    sim_time = get_sim_time(units='us')
    print("The simulation time is: ", sim_time, "us")
    #monitor_file = open("./monitor_data"+str(int(sim_time))+".txt", "a")
    monitor_file = open("./monitor_data.txt", "a")
    monitor_file.write("The simulation time is: " + str(sim_time) + " us\n")
    monitor_file.write("This is loop: "+str(int(sim_time/51.060001)+1)+"\n")


    ## Fork the monitor coroutine
    cocotb.start_soon(monitor_data(dut, monitor_file))

    ## Fork the tik_tok increment coroutine
    cocotb.start_soon(tik_tok_increment(dut))


    ## reset the DUT and initiate all the signals
    dut.rst_n.value = 1
    dut.data_valid.value = 0
    dut.pixel_in.value = 0
    dut.tik_tok.value = 0
    await Timer(10, units='ns')
    dut.rst_n.value = 0
    await RisingEdge(dut.clk)
    await Timer(23, units='ns')
    dut.rst_n.value = 1
    await RisingEdge(dut.clk)

    await Timer(10, units='ns')
    ## set the data_valid signal and pixel_in signal every 50 ns
    for i in range(len(input_data)):
        # set the data_valid signal to 1
        dut.data_valid.value = 1
        # set the pixel_in signal to a random value
        dut.pixel_in.value = get_data_ready_for_driver(input_data[i])
        await Timer(25, units='ns')
        # set the data_valid signal to 0
        dut.data_valid.value = 0
        await Timer(25, units='ns')
    
    ## wait for a long gap before the next test kicks in
    await Timer(1000, units='ns')
    monitor_file.write("////////////////////////////////////////////////////\n")
    # close the text file
    monitor_file.close()





## Generate the test factory
tf = TestFactory(test_5P_row_encoder)
## Add the test case to the test factory using different test data
tf.add_option('input_data', split_data)
## Run the test factory
tf.generate_tests()
print("The test has finished")

