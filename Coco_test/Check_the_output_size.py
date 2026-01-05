import os.path
import sys




## this is the script to check the output size of the encoder


Test_list = ['Row_5P_test', 'Row_10P_test']


print("The test results from the following tests will be counted:")
print(Test_list)


# check where the current directory is
current_directory = os.getcwd()
print("The current directory is: ", current_directory)

for test in Test_list:
    file_needs_open = "./Coco_test/" + test + "/monitor_data.txt"
    size_count = 0
    # Open the file to read
    file = open(file_needs_open, "r")
    # loop through the file line by line
    for line in file:
        # Check if the line starts with "0x"
        if line.startswith("0x"):
            # Increment the size count
            size_count += 1
    # Print the size count
    if test == "Row_5P_test":
        print("The number of 5P encoded data is: ", size_count)
        print("The size of the 5P encoded data is: ", size_count * 2, "bytes")
    elif test == "Row_10P_test":
        print("The number of 10P encoded data is: ", size_count)
        print("The size of the 10P encoded data is: ", size_count * 4, "bytes")
    # Close the file
    file.close()


