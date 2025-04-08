import cocotb
from cocotb.triggers import RisingEdge, FallingEdge, Timer
from scipy.sparse import save_npz, load_npz
import numpy as np

## This testbench will test the 5P row encoder with the data from the quantised JC_gen_data
## And because the data is more than 5 Pixels, it will need to be split into 5 pixel chunks
## Correspondingly, the testbench shall run the test iteratively until all the data is processed

def split_data(data, batch_size):
    """
    Splits the data into chunks of the specified batch size.
    """
    split_data = []
    for i in range(0, len(data), batch_size):
        split_data.append(data[i:i + batch_size])
    return split_data


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


@cocotb.coroutine
async def monitor_data(dut):
    """
    Monitor the output data from the DUT.
    
    The output data encoded_data is the encoded data from the DUT, which will be flagged valid
    when data_valid is high.

    """



@cocotb.test()
async def test_5P_row_encoder(dut):