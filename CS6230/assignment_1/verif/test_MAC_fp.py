import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles
import logging as _log



# Ports:
# Name                         I/O  size props
# RDY_get_inp_b                  O     1 const
# RDY_get_inp_c                  O     1 const
# get_result                     O    32 reg
# RDY_get_result                 O     1 const
# CLK                            I     1 clock
# RST_N                          I     1 reset
# get_inp_b_inp_B                I    32 reg
# get_inp_c_inp_C                I    32 reg
# EN_get_inp_b                   I     1
# EN_get_inp_c                   I     1


async def reset(dut):
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)
    dut.RST_N.value=0
    await RisingEdge(dut.CLK)
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)

@cocotb.test()
async def test_1(dut):
    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
    dut.get_inp_b_inp_B.value = 0b0100000100101100
    dut.EN_get_inp_b.value = 1
    dut.get_inp_c_inp_C.value = 0b0101010011100101
    dut.EN_get_inp_c.value = 1
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    await RisingEdge(dut.CLK)
    # for _ in range(10):
    #     await RisingEdge(dut.CLK)
    while True:
        if dut.RDY_get_result.value == 1:
            dut._log.info(f"Res: {dut.get_result.value}")
            break
        await RisingEdge(dut.CLK)
