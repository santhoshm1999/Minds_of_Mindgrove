import os
import random
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles
import logging as _log

# Ports:
# Name                         I/O  size props
# RDY_get_A                      O     1 const
# RDY_get_B                      O     1 const
# RDY_get_C                      O     1 const
# get_output                     O    32 reg
# RDY_get_output                 O     1 const
# CLK                            I     1 clock
# RST_N                          I     1 reset
# get_A_a                        I    16 reg
# get_B_b                        I    16 reg
# get_C_c                        I    32 reg
# EN_get_A                       I     1
# EN_get_B                       I     1
# EN_get_C                       I     1

async def reset(dut):
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)
    dut.RST_N.value=0
    await RisingEdge(dut.CLK)
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)

async def reset(dut):
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 0
    await RisingEdge(dut.CLK)
    dut.RST_N.value = 1
    await RisingEdge(dut.CLK)


async def give_input(dut):
    dut.get_A_a.value = 0b00100100
    dut.get_B_b.value = 0b10000001
    dut.get_C_c.value = 0b11111111111111111111111000001001
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 1
    dut.EN_get_B.value = 1
    dut.EN_get_C.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 0
    dut.EN_get_B.value = 0
    dut.EN_get_C.value = 0
    print("********************INPUT GIVEN****************************")

async def get_output(dut):
    await RisingEdge(dut.got_result)
    ans = dut.get_output.value
    ans = str(ans)
    ans = int(str(ans),2)
    print("******************OUTPUT RECEIVED**************************")
    return ans

@cocotb.test()
async def test_1(dut):

    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)

    await give_input(dut)
    
    await RisingEdge(dut.CLK)

    received_ans = await get_output(dut)

    expected_ans = 0b00100100 * 0b10000001 + 0b11111111111111111111111000001001
    print("***********************ASSERTION***************************")
    print(expected_ans, received_ans)
    assert received_ans == expected_ans



