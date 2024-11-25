# CS6230_MAC_Unit_project

Assignment 1 -> Contains bsv design of MAC unit and its verification environment. <br>
Assignment 2 -> Contains bsv design of 4x4 systolic array and its verification environment.

Assignment 1:

1. int32 : <br>
a. pipelined design: code - completed, verification - completed <br>
b. unpipelined design : code - completed, verification - completed <br>

2. bfloat16: <br>
a. pipelined design: code - completed, verification - completed <br>
b. unpipelined design : code - completed, verification - completed <br>

Assignment 2: <br>

int32: code - Not completed, verification - Not completed <br>
bfloat16: code - Not completed, verification - Not completed <br>

Note: Steps to execute the code is present in READMEs present in respective directories. Reports for both assignments is also present in the respective directories.


# STEPS TO RUN PIPELINED MAC

1. Navigate to Pipelined/ directory
```
cd Pipelined/
```
2. activate pyenv
```
pyenv activate py38
```
3. compile and generate verilog from bsv
```
make generate_verilog
```
4. To simulate using cocotb, for int testcases run the following command
```
make simulate