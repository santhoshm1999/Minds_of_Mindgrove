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

file1 = open('int8_MAC/A_decimal.txt')
int_a = file1.readlines()
file1.close()

file1 = open('int8_MAC/B_decimal.txt')
int_b = file1.readlines()
file1.close()

file1 = open('int8_MAC/C_decimal.txt')
int_c = file1.readlines()
file1.close()

file1 = open('int8_MAC/MAC_decimal.txt')
int_ref_ans = file1.readlines()
file1.close()


async def reset(dut):
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)
    dut.RST_N.value=0
    await RisingEdge(dut.CLK)
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)


async def test_1(dut, i, s):

    if(s == 0):
        a_val = int(int_a[i][:-1])
        b_val = int(int_b[i][:-1])
        c_val = int(int_c[i][:-1])
        ref_ans_val = int(int_ref_ans[i][:-1])
        dut._log.info(f"int_a_val: {int_a[i][:-1]}")
        dut._log.info(f"int_b_val: {int_b[i][:-1]}")
        dut._log.info(f"int_c_val: {int_c[i][:-1]}")
        dut._log.info(f"int_ref_ans: {int_ref_ans[i][:-1]}")
    elif(s == 1):
        a_val = int(fl_a[i][:-1],2)
        b_val = int(fl_b[i][:-1],2)
        c_val = int(fl_c[i][:-1],2)
        ref_ans_val = fl_ref_ans[i][:-1]
        dut._log.info(f"fl_a_val: {fl_a[i][:-1]}")
        dut._log.info(f"fl_b_val: {fl_b[i][:-1]}")
        dut._log.info(f"fl_c_val: {fl_c[i][:-1]}")
        dut._log.info(f"fl_ref_ans: {fl_ref_ans[i][:-1]}")
    
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
        if (dut.RDY_get_mac_a.value == 1):
            dut.get_mac_a_a.value = a_val
            dut.EN_get_mac_a.value = 1
            await RisingEdge(dut.CLK)
            dut.EN_get_mac_a.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        dut._log.info("Inside 2nd loop")
        if (dut.RDY_get_mac_b.value == 1):
            dut.get_mac_b_b.value = b_val
            dut.EN_get_mac_b.value = 1
            await RisingEdge(dut.CLK)
            dut.EN_get_mac_b.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        dut._log.info("Inside 3rd loop")
        if (dut.RDY_get_mac_c.value == 1):
            dut.get_mac_c_c.value = c_val
            dut.EN_get_mac_c.value = 1
            await RisingEdge(dut.CLK)
            dut.EN_get_mac_c.value = 0
            break
        await RisingEdge(dut.CLK)


    dut._log.info("Before answer loop")
    # timeout = 50
    while True:
        # dut._log.info("Inside answer loop")
        if (dut.RDY_get_end_res.value == 1):
            await RisingEdge(dut.CLK)
            final_res = str(dut.get_end_res.value)
            dut._log.info(f"MAC Res: {final_res}")
            # mul(str(dut.get_result.value))
            break
        await RisingEdge(dut.CLK)
        # timeout = timeout-1

    if (s == 0):
        if(final_res[0] == "1"):
            ans = ((int(final_res,2) ^ 0xFFFFFFFF) + 1) * -1
        else:
            ans = int(final_res,2)
        assert ans == ref_ans_val,f'Got: {ans} Actual: {ref_ans_val}'
    else:
        assert final_res == ref_ans_val,f'Got: {final_res} Actual: {ref_ans_val}'

    dut._log.info("MAC float Completed")



Tf = TestFactory(test_1)
Tf.add_option(name = "i",optionlist = list(range(1000)))
Tf.add_option(name = "s",optionlist = [0,1])
Tf.generate_tests()
