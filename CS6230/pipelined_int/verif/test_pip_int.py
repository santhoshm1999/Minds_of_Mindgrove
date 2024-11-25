import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles
import logging as _log

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


async def send_val(dut,A,B,C,S):
    dut.get_A_a.value = A
    dut.get_B_b.value = B
    dut.get_C_c.value = C
    dut.get_select_select.value = S
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
    print("********************GIVEN****************************")

async def receive_val(dut):
    # await RisingEdge(dut.got_result) #11 awaits
    while True:
        if(dut.RDY_get_output.value):
            dut.EN_get_output.value = 1
            ans = dut.get_output.value
            await RisingEdge(dut.CLK)
            break
        await RisingEdge(dut.CLK)
    print("******************RECEIVED***************************")
    str_ans = str(ans)
    if(str_ans[0] == "1"):
        ans = ((int(str_ans,2) ^ 0xFFFFFFFF) + 1) * -1
    else:
        ans = int(str_ans,2)
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
        await send_val(dut,InpA[i],InpB[i],InpC[i],0)
        rec_out = await receive_val(dut)
        print(f"{InpA[i]} {InpB[i]} {InpC[i]} {Out[i]} == {rec_out}")
        assert rec_out == Out[i]