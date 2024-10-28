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


async def give_input(dut,A,B,C,S):
    dut.get_A_a.value = A
    dut.get_B_b.value = B
    dut.get_C_c.value = C
    dut.get_select_s.value = S
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 1
    dut.EN_get_B.value = 1
    dut.EN_get_C.value = 1
    dut.EN_get_select.value = 1
    await RisingEdge(dut.CLK)
    dut.EN_get_A.value = 0
    dut.EN_get_B.value = 0
    dut.EN_get_C.value = 0
    dut.EN_get_select.value = 0
    print("********************INPUT GIVEN****************************")

async def get_output(dut):
    await RisingEdge(dut.got_result) #11 awaits
    ans = dut.add_out.value
    print("******************OUTPUT RECEIVED**************************")
    str_ans = str(ans)
    if(str_ans[0] == "1"):
        ans = ((int(str_ans,2) ^ 0xFFFFFFFF) + 1) * -1
    else:
        ans = int(str(ans),2)
    return ans

@cocotb.test()
async def test_mul(dut):
    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)
    
    InpA = []
    InpB = []
    InpC = []
    Out = []
    
    dataA = open("int8MAC/A_decimal.txt","r")
    Avalue = dataA.readlines()
    dataB = open("int8MAC/B_decimal.txt","r")
    Bvalue = dataB.readlines()
    dataC = open("int8MAC/C_decimal.txt","r")
    Cvalue = dataC.readlines()
    dataO = open("int8MAC/MAC_decimal.txt","r")
    Ovalue = dataO.readlines()

    dataA.close()
    dataB.close()
    dataC.close()
    dataO.close()
    
    for i in range(len(Avalue)-1):
         InpA.append(eval(Avalue[i].strip().strip('\n')))
         
    for i in range(len(Bvalue)-1):
         InpB.append(eval(Bvalue[i].strip().strip('\n')))
         
    for i in range(len(Cvalue)-1):
         InpC.append(eval(Cvalue[i].strip().strip('\n')))
         
    for i in range(len(Ovalue)-1):
         Out.append(eval(Ovalue[i].strip().strip('\n')))
    
    
    for i in range(len(InpA)):
        await give_input(dut,InpA[i],InpB[i],InpC[i],0)
        rtl_output = await get_output(dut)
        print(f"{InpA[i]} {InpB[i]} {InpC[i]} {Out[i]} == {rtl_output}")
        assert rtl_output == Out[i]
