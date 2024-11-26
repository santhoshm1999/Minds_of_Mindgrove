import cocotb
from cocotb.clock import Clock, Timer
from cocotb.triggers import RisingEdge, ClockCycles
import logging as _log
from cocotb.regression import TestFactory


file1 = open('test_cases/A_binary.txt')
a = file1.readlines()
file1.close()

file1 = open('test_cases/B_binary.txt')
b = file1.readlines()
file1.close()

file1 = open('test_cases/C_binary.txt')
c = file1.readlines()
file1.close()

file1 = open('test_cases/MAC_binary.txt')
ref_ans = file1.readlines()
file1.close()

file1 = open('test_cases/combined_AB_binary.txt')
ref_mul = file1.readlines()
file1.close()


async def reset(dut):
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)
    dut.RST_N.value=0
    await RisingEdge(dut.CLK)
    dut.RST_N.value=1
    await RisingEdge(dut.CLK) 


async def test_1(dut, i):
    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)

    a_val = int(a[i][:-1],2)
    b_val = int(b[i][:-1],2)
    c_val = int(c[i][:-1],2)
    dut._log.info(f"a_val: {bin(a_val).replace('0b','').rjust(16,'0')}")
    dut._log.info(f"b_val: {bin(b_val).replace('0b','').rjust(16,'0')}")
    dut._log.info(f"c_val: {bin(c_val).replace('0b','').rjust(16,'0')}")

    ref_ans_val = ref_ans[i][:-1]
    ref_ans_sign = ref_ans_val[0]
    ref_ans_exp = ref_ans_val[1:9]
    ref_ans_man = ref_ans_val[9:]

    while True:
        if (dut.RDY_get_input_a.value == 1):
            dut.get_input_a_a.value = a_val
            dut.EN_get_input_a.value = 1
            await RisingEdge(dut.CLK)
            dut.EN_get_input_a.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        if (dut.RDY_get_input_b.value == 1):
            dut.get_input_b_b.value = b_val
            dut.EN_get_input_b.value = 1
            await RisingEdge(dut.CLK)
            dut.EN_get_input_b.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        if (dut.RDY_get_input_c.value == 1):
            dut.get_input_c_c.value = c_val
            dut.EN_get_input_c.value = 1
            await RisingEdge(dut.CLK)
            dut.EN_get_input_c.value = 0
            break
        await RisingEdge(dut.CLK)

    while True:
        if dut.RDY_get_input_s.value == 1:
            dut.EN_get_input_s.value = 1
            await RisingEdge(dut.CLK)
            dut.EN_get_input_s.value = 0
            break
        await RisingEdge(dut.CLK)
    
    while True:
        if dut.RDY_get_MAC_result.value == 1:
            await RisingEdge(dut.CLK)
            final_res = str(dut.get_MAC_result.value)
            dut._log.info(f"MAC Res: {final_res}")
            break
        await RisingEdge(dut.CLK)

    assert final_res[0] == ref_ans_sign,f'sign not matched Got: {final_res[0]} Actual: {ref_ans_sign}    i = {i}'
    assert final_res[9:] == ref_ans_man,f'mantissa not matched Got: {final_res[9:]} Actual: {ref_ans_man}    i = {i}'
    assert final_res[1:9] == ref_ans_exp,f'exp not matched Got: {final_res[1:9]} Actual: {ref_ans_exp}    i = {i}'
    assert final_res == ref_ans_val,f'Got: {final_res} Actual: {ref_ans_val}    i = {i}'


Tf = TestFactory(test_1)
Tf.add_option(name = "i",optionlist = list(range(1000)))
Tf.generate_tests()