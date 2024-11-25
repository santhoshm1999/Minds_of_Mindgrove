import cocotb
from cocotb.clock import Clock, Timer
from cocotb.triggers import RisingEdge, ClockCycles
import logging as _log
from cocotb.regression import TestFactory

import math
import struct
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--debug', help='Debug flag', action='store_true')
parser.add_argument('--full', help='Debug flag', action='store_true')
args = parser.parse_args()


file1 = open('bf16_MAC/A_binary.txt')
fl_a = file1.readlines()
file1.close()

file1 = open('bf16_MAC/B_binary.txt')
fl_b = file1.readlines()
file1.close()

file1 = open('bf16_MAC/C_binary.txt')
fl_c = file1.readlines()
file1.close()

file1 = open('bf16_MAC/MAC_binary.txt')
fl_ref_ans = file1.readlines()
file1.close()

# file1 = open('test_cases/combined_AB_binary.txt')
# ref_mul = file1.readlines()
# file1.close()

file1 = open('int8_MAC/A_binary.txt')
int_a = file1.readlines()
file1.close()

file1 = open('int8_MAC/B_binary.txt')
int_b = file1.readlines()
file1.close()

file1 = open('int8_MAC/C_binary.txt')
int_c = file1.readlines()
file1.close()

file1 = open('int8_MAC/MAC_binary.txt')
int_ref_ans = file1.readlines()
file1.close()


async def reset(dut):
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)
    dut.RST_N.value=0
    await RisingEdge(dut.CLK)
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)


# async def test_1(dut, i, s):
@cocotb.test()
async def test_1(dut):
    i = 2
    s = 0

    if(s == 0):
        a_val = int(int_a[i][:-1],2)
        b_val = int(int_b[i][:-1],2)
        c_val = int(int_c[i][:-1],2)
        ref_ans_val = int_ref_ans[i][:-1]
    elif(s == 1):
        a_val = int(fl_a[i][:-1],2)
        b_val = int(fl_b[i][:-1],2)
        c_val = int(fl_c[i][:-1],2)
        ref_ans_val = fl_ref_ans[i][:-1]
    # if i != 0:
    #     i = i - 1
    # ref_mul_val = ref_mul[i][:-1]
    dut._log.info(f"a_val: {bin(a_val).replace('0b','').rjust(16,'0')}")
    dut._log.info(f"b_val: {bin(b_val).replace('0b','').rjust(16,'0')}")
    dut._log.info(f"c_val: {bin(c_val).replace('0b','').rjust(16,'0')}")
    
    cocotb.start_soon(Clock(dut.CLK, 1, units='ns').start())
    await reset(dut)
    dut._log.info("MAC started")

    while True:
        dut._log.info("Inside first loop")
        if (dut.RDY_get_s1_or_s2.value == 1):
            dut.EN_get_s1_or_s2.value = 1
            dut.get_s1_or_s2_s1_s2.value = s
            await RisingEdge(dut.CLK)
            dut.EN_get_s1_or_s2.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        dut._log.info("Inside first loop")
        if (dut.RDY_get_fl_a.value == 1):
            dut.EN_get_fl_a.value = 1
            dut.get_fl_a_a.value = a_val
            await RisingEdge(dut.CLK)
            dut.EN_get_fl_a.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        dut._log.info("Inside 2nd loop")
        if (dut.RDY_get_fl_b.value == 1):
            dut.get_fl_b_b.value = b_val
            dut.EN_get_fl_b.value = 1
            await RisingEdge(dut.CLK)
            dut.EN_get_fl_b.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        dut._log.info("Inside 3rd loop")
        if (dut.RDY_get_fl_c.value == 1):
            dut.get_fl_c_b.value = c_val
            dut.EN_get_fl_c.value = 1
            await RisingEdge(dut.CLK)
            dut.EN_get_fl_c.value = 0
            break
        await RisingEdge(dut.CLK)


    dut._log.info("Before answer loop")
    timeout = 50
    while True:
        dut._log.info("Inside answer loop")
        if (dut.RDY_get_end_res.value == 1) or (timeout == 0):
            await RisingEdge(dut.CLK)
            final_res = str(dut.get_end_res.value)
            dut._log.info(f"MAC Res: {final_res}")
            # mul(str(dut.get_result.value))
            break
        await RisingEdge(dut.CLK)
        timeout = timeout-1

    assert final_res == ref_ans_val,f'Got: {final_res} Actual: {ref_ans_val}    i = {i}'


    dut._log.info("MAC float Completed")



# Tf = TestFactory(test_1)
# Tf.add_option(name = "i",optionlist = list(range(1)))
# Tf.add_option(name = "s",optionlist = [0])
# Tf.generate_tests()
