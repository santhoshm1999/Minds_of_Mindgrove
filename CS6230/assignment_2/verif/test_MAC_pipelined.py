# Ports:
# Name                         I/O  size props
# RDY_get_A                      O     1
# RDY_get_B                      O     1
# RDY_get_C                      O     1
# RDY_get_select                 O     1
# output_MAC                     O    32
# RDY_output_MAC                 O     1
# CLK                            I     1 clock
# RST_N                          I     1 reset
# get_A_a                        I    16
# get_B_b                        I    16
# get_C_c                        I    32
# get_select_select              I     1
# EN_get_A                       I     1
# EN_get_B                       I     1
# EN_get_C                       I     1
# EN_get_select                  I     1
# EN_output_MAC                  I     1

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


@cocotb.test()
async def test_sample(dut):
    cocotb.start_soon(Clock(dut.CLK, 1, units='ns').start())
    await reset(dut)


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
        if (dut.RDY_get_select.value == 1):
            dut.EN_get_select.value = 1
            dut.get_select_select.value = s
            await RisingEdge(dut.CLK)
            dut.EN_get_select.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        dut._log.info("Inside second loop")
        if (dut.RDY_get_A.value == 1):
            dut.EN_get_A.value = 1
            dut.get_A_a.value = a_val
            await RisingEdge(dut.CLK)
            dut.EN_get_A.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        dut._log.info("Inside 3rd loop")
        if (dut.RDY_get_B.value == 1):
            dut.EN_get_B.value = 1
            dut.get_B_b.value = b_val
            await RisingEdge(dut.CLK)
            dut.EN_get_B.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        dut._log.info("Inside 4th loop")
        if (dut.RDY_get_C.value == 1):
            dut.EN_get_C.value = 1
            dut.get_C_c.value = c_val
            await RisingEdge(dut.CLK)
            dut.EN_get_C.value = 0
            break
        await RisingEdge(dut.CLK)


    dut._log.info("Before answer loop")
    timeout = 50
    while True:
        dut._log.info("Inside answer loop")
        if (dut.RDY_output_MAC.value == 1) or (timeout == 0):
            await RisingEdge(dut.CLK)
            dut.EN_output_MAC.value = 1
            final_res = str(dut.output_MAC.value)
            dut.EN_output_MAC.value = 1

            dut._log.info(f"MAC Res: {final_res}")
            # mul(str(dut.get_result.value))
            break
        await RisingEdge(dut.CLK)
        timeout = timeout-1

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
