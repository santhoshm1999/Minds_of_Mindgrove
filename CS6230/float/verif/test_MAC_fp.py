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


def debug_print(msg=None):
    if args.debug:
        if msg is None:
            print('\n')
        else:
            print(f'DEBUG: {msg}')



BIAS = 127

async def reset(dut):
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)
    dut.RST_N.value=0
    await RisingEdge(dut.CLK)
    dut.RST_N.value=1
    await RisingEdge(dut.CLK)

def compliment(val):
    tmp = ''
    len_val = len(val)
    for i in range(len_val):
        if val[i] == '0':
            tmp += '1'
        else:
            tmp += '0'
    debug_print(f'(compliment) {tmp}')
    tmp_val = addition(tmp,'1')
    debug_print(f'(compliment) {tmp_val}')

def rounding(val, bit_length):
    val = val.ljust(bit_length+2, '0')
    debug_print(f'(rounding) ROUNDING Value: {val} and bit length {bit_length}  and len of val {len(val)}')
    if len(val) == bit_length:
        return val
    elif len(val) < bit_length:
        return val.ljust(bit_length,'0')
    else:
        if val[bit_length] == '0':
            debug_print(f'(rounding) RETURN FROM ROUND: {val[:bit_length]}')
            return val[:bit_length]
        else: # hits if rounding bit equals 1
            if (val[bit_length-1] != '1'  and int(val[bit_length+1:],2) == 0):
                # TODO: Check the return value below
                return val[:23]
            else:
                temp = addition(val[:bit_length+1], '1')[1:]
                debug_print(f'(rounding) RETURN FROM ROUND: {temp}')
                return temp


def float_2_bin(val):
    bin_fl = ''
    debug_print(f'(float_2_bin) float: {val}')
    while val != 0:
        val = val*2
        debug_print(f'(float_2_bin) val*2: {val}')
        if math.isinf(val):
            break
        dec = int(val)
        bin_fl += str(dec)
        val = val - dec
        debug_print(f'(float_2_bin) {bin_fl[:7]}')
    debug_print(f'(float_2_bin) float to bin: {bin_fl[:23]}')
    return (bin_fl).rstrip('0')

def addition_mantissa(val_a, val_b):
    debug_print(f'(addition_mantissa) VAL_A: {val_a}')
    debug_print(f'(addition_mantissa) VAL_B: {val_b}')
    if len(val_a) >= len(val_b):
        bin_len = len(val_a)
        val_b = val_b.ljust(bin_len, '0')
    else:
        bin_len = len(val_b)
        val_a = val_a.ljust(bin_len, '0')
    result = ['0']*bin_len
    carry = '0'
    for i in range(bin_len):
        result[bin_len-1-i] = str(int(val_a[bin_len-1-i]) ^ int(val_b[bin_len-1-i]) ^ int(carry))
        carry = str(int(val_a[bin_len-1-i]) & int(val_b[bin_len-1-i]) | (int(carry) & (int(val_a[bin_len-1-i]) ^ int(val_b[bin_len-1-i]))))
    res = "".join([str(item) for item in result])
    return carry+res

def addition(a, b):
    debug_print(f'(addition) VAL_A: {a}')
    debug_print(f'(addition) VAL_B: {b}')
    # a = bin(val_a).replace("0b","")
    # b = bin(val_b).replace("0b","")
    if len(a) >= len(b):
        bin_len = len(a)
        b = b.rjust(bin_len, '0')
    else:
        bin_len = len(b)
        a = a.rjust(bin_len, '0')
    debug_print(f'(addition) a: {a}')
    debug_print(f'(addition) b: {b}')
    result = ['0']*bin_len
    carry = '0'
    for i in range(bin_len):
        result[bin_len-1-i] = str(int(a[bin_len-1-i]) ^ int(b[bin_len-1-i]) ^ int(carry))
        carry = str(int(a[bin_len-1-i]) & int(b[bin_len-1-i]) | (int(carry) & (int(a[bin_len-1-i]) ^ int(b[bin_len-1-i]))))
    res = "".join([str(item) for item in result])
    debug_print(f'(addition) ADDITION RESULT: {res}')
    return carry+res

def multiplication(man_a, man_b):
    
    debug_print(f'(multiplication) MAN_A: {man_a}')
    debug_print(f'(multiplication) MAN_B: {man_b}')
    if float(man_a) == 0.0 or float(man_b) == 0.0:
        result = '0'
    else:
        if man_a[1] == '.':
            a = int((man_a[0]+man_a[2:]),2)
        else:
            a = int(man_a,2)
        if man_b[1] == '.':
            b = int((man_b[0]+man_b[2:]),2)
        else:
            b = int(man_b,2)

        result = 0
        if a == 1:
            result = b
        elif b == 1:
            result = a
        else:
            while b > 0:
                if b & 1:
                    result_bin = bin(result).replace("0b","")
                    debug_print(f'(multiplication) res: {result_bin}')
                    a_bin = bin(a).replace("0b","")
                    debug_print(f'(multiplication) a: {a_bin}')
                    result = addition(result_bin, a_bin)
                    debug_print(f'(multiplication) len_of_res: {len(result)}')
                    result = int(result,2)
                debug_print(f'(multiplication) RESULT in loop: {bin(result).replace('0b','')}')
                a <<= 1
                b >>= 1
        debug_print(f'(multiplication) RESULT BEFORE BIN: {result}')
        result = bin(result).replace("0b","").rjust(16, '0')
        # bin_place = result.index('.')
    debug_print(f'(multiplication) RESULT_BEFORE: {result}')
    result = result[:-15] + '.'+ result[-15:]
    # if (len(result) > 16 and result[0] == 1):
    # else:
    #     result = result[:1] + '.' + result[1:]
    # result = result[:dec_point] + '.' + result[dec_point:]
    debug_print(f'(multiplication) RESULT_AFTER: {result}')
    return result


def subtraction(val1 ,val2):
    debug_print(f'(subtraction) SUB: VAL_A: {val1}')
    debug_print(f'(subtraction) SUB: VAL_B: {val2}')
    a = bin(val1).replace("0b","")
    b = bin(val2).replace("0b","")
    temp = ''
    for i in range(len(a)):
        temp += '0' if (a[i] == '1') else '1'
    a = addition(int(temp,2), 1)[1:]
    temp = ''
    for i in range(len(b)):
        temp += '0' if (b[i] == '1') else '1'
    b = addition(int(temp,2), 1)[1:]
    return addition(int(a,2), int(b,2))[1:]

def extract_val(val, bin_len):
    debug_print(f'(extract_val) Binary val: {val}')
    # sign-1bit, exp-8bits, mantissa-7bits
    return (val[0], val[1:9], val[9:])


def multiplier(val1, val2):
    if '1' not in val1  or '1' not in val2:
        return '0'*16
    
    a_sign, a_exp, a_mantissa = extract_val(val1, 16)
    a_sign = int(a_sign,2)
    a_exp = int(a_exp,2)
    a_mantissa = int(a_mantissa,2)

    b_sign, b_exp, b_mantissa = extract_val(val2, 16)
    b_sign = int(b_sign,2)
    b_exp = int(b_exp,2)
    b_mantissa = int(b_mantissa,2)

    if a_exp == 0xFF:
        if a_exp == 0 and a_sign == 0:
            return 'Inf'
        elif a_exp == '0' and a_sign == 1:
            return '-Inf'
        else:
            return 'Nan'

    if b_exp == 0xFF:
        if b_exp == 0 and b_sign == 0:
            return 'Inf'
        elif b_exp == '0' and b_sign == 1:
            return '-Inf'
        else:
            return 'Nan'

    debug_print(f'(multiplier) EXP_A: {a_exp}')
    debug_print(f'(multiplier) EXP_B: {b_exp}')

    sign_res = a_sign ^ b_sign
    a_exp_res = a_exp - BIAS
    b_exp_res = b_exp - BIAS
    debug_print(f'(multiplier) BIAS: {BIAS}')
    # exp = int(addition(a_exp_res, b_exp_res)[1:],2)
    exp = a_exp_res + b_exp_res
    debug_print(f'(multiplier) exp: {exp}')
    # exp = int(addition(exp, BIAS),2)
    exp = BIAS + exp
    debug_print(f'(multiplier) exp: {exp}')
    debug_print(f'(multiplier) ADDER RESULT: {exp}')

    # Perform multiplication of mantissas
    debug_print(f'(multiplier) (a_mantissa): {a_mantissa}')
    debug_print(f'(multiplier) (b_mantissa): {b_mantissa}')
    implicit_a = '0' if (val1 == 0.0) else '1' 
    implicit_b = '0' if (val2 == 0.0) else '1'
    bin_a_man = f'{implicit_a}.{bin(a_mantissa).replace("0b","").zfill(7)}'
    bin_b_man = f'{implicit_b}.{bin(b_mantissa).replace("0b","").zfill(7)}'
    debug_print(f'(multiplier) Binary format (a_mantissa): {bin_a_man}')
    debug_print(f'(multiplier) Binary format (b_mantissa): {bin_b_man}')
    man_res = multiplication(bin_a_man, bin_b_man)
    debug_print(f'(multiplier) Multiplication result (mantissa): {man_res}')
    if exp >=0 :
        if man_res[1] != '.':
            man_list = man_res.split('.')
            exp += len(man_list[0][1:])
            man_res = man_list[0][1:] + man_list[1]
            debug_print(f'(multiplier) MANRES1: {man_res}')
        elif man_res[1] == '.':
            temp = man_res[2:]
            man_res = temp
            debug_print(f'(multiplier) MANRES: {man_res}')
        # debug_print(f'(multiplier) Binary of exp: {exp_res}')
    else:
        man_list = man_res.split('.')
        man_res = man_list[0].zfill(abs(exp)) + man_list[1]
        exp = 1
    debug_print(f'(multiplier) EXP: {exp}')
    debug_print(f'(multiplier) MANRES: {man_res}')
    exp_res = bin(exp).replace('0b','')
    exp_res = rounding(exp_res, 8)
    man_res = rounding(man_res, 7)
    debug_print(f'(multiplier) EXP: {exp_res}')
        # if (len(man_res) != 23):
        #     exp = (addition(exp, len(man_res)-23)[1:],2)
        # exp_res = bin(exp).replace('0b','').rjust(8,'0')
        # debug_print(f'(multiplier) Binary of exp: {exp_res}')
    debug_print(f'(multiplier) Multiplication result (mantissa): {man_res}')
    man_res = man_res[:7]
    debug_print(f'(multiplier) Multiplication result (mantissa): {man_res}')

    # Prepare the result in binary form
    print(f'SIGN_RES: {sign_res}')
    print(f'EXP_RES: {exp_res}')
    print(f'MAN_RES: {man_res}')

    # assert '0' == str(sign_res),f'ACTUAL SIGN 0 but got {sign_res}'
    # assert '10101101' == str(exp_res),f'ACTUAL EXP 10101101 but got {exp_res}'
    # assert '0011010' == man_res,f'ACTUAL MANTISSA 0011010 but got {man_res}'

    res_mul = f"{sign_res}{exp_res}{man_res}"
    print(f'MULTIPLIER Result: {res_mul}')

    # fl_res = bin_to_float(res_mul)

    # assert res_mul == '01000100111101100100001010011001', f'01000100111101100100001010011001 not equals to {res_mul}'
    # assert res_mul == '01000011010010010000000000000000', f'{res_mul} not equals to 01000011010010010000000000000000'

    return res_mul


def adder(res_mul, val3):
    if '1' not in res_mul:
        return val3
    elif '1' not in val3:
        return res_mul
    mul_sign, mul_exp, mul_mantissa = extract_val(res_mul,32)
    c_sign, c_exp, c_mantissa = extract_val(val3,32)

    debug_print(f'(adder) MUL_RES_EXP: {mul_exp}')
    debug_print(f'(adder) C_EXP: {c_exp}')
    # c_implicit = f'1{bin(c_mantissa).replace("0b","")}'
    # mul_implicit = f'1{bin(mul_mantissa).replace("0b","")}'
    c_implicit = f'1{c_mantissa}'
    mul_implicit = f'1{mul_mantissa}'
    debug_print(f'(adder) c_implicit: {c_implicit}')
    debug_print(f'(adder) mul_implicit: {mul_implicit}')
    c_mantissa = f'{c_implicit.rstrip("0")}'
    mul_mantissa = f'{mul_implicit.rstrip("0")}'
    debug_print(f'(adder) c_mantissa: {c_mantissa}')
    debug_print(f'(adder) mul_mantissa: {mul_mantissa}')
    if int(mul_exp, 2) > int(c_exp, 2):
        exp = int(mul_exp, 2)
        c_mantissa = c_mantissa.rjust(((int(mul_exp, 2) - int(c_exp, 2)) +len(c_mantissa)), '0')
        debug_print(f'(adder) C_MANTISSA: {c_mantissa}')
    elif int(mul_exp, 2) <= int(c_exp, 2):
        exp = int(c_exp, 2)
        mul_mantissa = mul_mantissa.rjust(((int(c_exp, 2) - int(mul_exp, 2)) +len(mul_mantissa)), '0')
        debug_print(f'(adder) MUL_MANTISSA: {mul_mantissa}')

    debug_print(f'(adder) OLD_EXP  : {exp}')
    debug_print(f'(adder) c_mantissa_new  : {c_mantissa}')
    debug_print(f'(adder) maul_mantissa_new: {mul_mantissa}')

    # fl_len = len(c_mantissa) if (len(c_mantissa) > len(mul_mantissa)) else len(mul_mantissa)

    # c_mantissa = c_mantissa.ljust(fl_len, '0')
    # mul_mantissa = mul_mantissa.ljust(fl_len, '0')
    debug_print(f'(adder) c_mantissa_new  : {c_mantissa}')
    debug_print(f'(adder) maul_mantissa_new: {mul_mantissa}')

    if c_sign == mul_sign:
        sign_res = c_sign
        man_res = addition_mantissa(c_mantissa, mul_mantissa)
        debug_print(f'(adder) MANTISSA ADDTION RESULT: {man_res}')
        if man_res[0] == '1':
            exp  = int(addition(bin(exp).replace('0b',''), '1')[1:],2)
        else:
            man_res = man_res[1:]
        debug_print(f'(adder) &&&&&&&&&&&&&&&&&&&&&&&&&&')
        debug_print(f'(adder) {man_res}')
        debug_print(f'(adder) &&&&&&&&&&&&&&&&&&&&&&&&&&')
        # man_res = man_res[:2] + '.' + man_res[2:]
    else:
        if (int(c_mantissa, 2) == int(mul_mantissa, 2)):
            man_res = '0'
        elif int(c_mantissa,2) > int(mul_mantissa,2):
                sign_res = c_sign
        else:
            sign_res = mul_mantissa
        man_res = subtraction(int(c_mantissa,2), int(mul_mantissa,2))
    man_res = rounding(man_res[1:],23)
    debug_print(f'(adder) MAN_RES:{man_res}')
    # man_res = man_res.lstrip('0')

    debug_print(f'(adder) MAN_RES:{man_res}')
    # if man_res[1] != '.':
    #     fl_split = man_res.split('.')
    #     exp += len(man_res[0][1:])
    #     man_res = man_res[0][1:] + man_res[1]
    # else:
    #     man_res = man_res[2:]
    # man_res = man_res.ljust(23,'0')
    debug_print(f'(adder) EXP: {exp}')
    exp_res = bin(exp).replace("0b","")
    
    print(f'SIGN {sign_res}')
    print(f'EXP {exp_res}')
    print(f'MAN {man_res}')

    res = f'{sign_res}{exp_res}{man_res}'
    print(f'RES: {res}')

    return res


def dec_2_ieee(num, num_len=7):
    rem = 0
    len_bias = 0
    debug_print(f'(dec_2_ieee) *************************************{num}')

    if num == 0.0 and num_len == 7:
        return '0' * 16
    elif num == 0.0 and num_len == 23:
        return '0' * 32
    
    # sign extraction
    if num >= 0:
        sign = '0'
    else:
        sign = '1'

    # Exponent extraction
    spli_val = str(num).split('.')
    top = int(spli_val[0])
    top_bin = bin(top).replace("0b","")
    debug_print(f'(dec_2_ieee) top: {top}')
    debug_print(f'(dec_2_ieee) top_bin: {top_bin}')
    rem = (num-top) if top else num
    debug_print(f'(dec_2_ieee) REMANING {rem}')

    # Extract Mantissa
    temp_man = float_2_bin(float(rem))
    binary_num = top_bin + "." + temp_man
    debug_print(f'(dec_2_ieee) BINARY NUM: {binary_num}')
    if top_bin == '0':
        temp = binary_num.replace('.','')
        i = 0
        while temp[0] == '0':
            i += 1
            temp = temp[1:]
            debug_print(f'(dec_2_ieee) TEMP: {temp}')
        mantissa = (temp[1:]).rjust(7,'0')

        # Extract Exponent
        debug_print(f'(dec_2_ieee) i: {i}')
        exp = BIAS - i
        debug_print(f'(dec_2_ieee) EXP: {exp}')
        exp = bin(exp).replace("0b","").rjust(8,'0')
        debug_print(f'(dec_2_ieee) EXP_BIN: {exp}')

    elif binary_num[1] != '.':
        temp = binary_num
        i = 0
        ind = temp.index('.')
        temp = binary_num.split('.')
        debug_print(f'(dec_2_ieee) BEFORE MANTISSA (temp) {temp}')
        mantissa = temp[0][1:] + temp[1]
        debug_print(f'(dec_2_ieee) BEFORE MANTISSA {mantissa}')

        mantissa = mantissa.rjust(7,'0')
    
        # Extract Exponent
        exp = bin(BIAS + len(temp[0][1:])).replace("0b","")

    debug_print(f'(dec_2_ieee) EXP: {exp}')
    debug_print(f"(dec_2_ieee) MANTISSA: {mantissa}")
    ieee = sign + exp + mantissa.ljust(num_len, '0')
    debug_print(f'(dec_2_ieee) ***********IEEE VALUE: {ieee} ******************')
    return ieee


def MAC(val1, val2, val3, ref_val, ref_mul):
    # val1 = dec_2_ieee(val1, 7)
    # assert val1[:17] == '0011111100000000', f'{val1[:17]} not equal to 0100000001100000'
    # exit(1)
    # val2 = dec_2_ieee(val2)
    # assert val2[:17] == '0100000000000000', f'{val2[:17]} not equal to 0100000000000000'
    # val3 = dec_2_ieee(val3)
    print('******************')
    # val1 = '0100000100101100'
    # val2 = '0100000011111101'
    # val3 = '0100000000000000'
    print(val1)
    print(val2)
    print(val3)
    print('******************')

    res_mul = multiplier(val1, val2)
    debug_print(f'(MAC) ******************')
    debug_print(f'(MAC) {res_mul}')
    debug_print(f'(MAC) ******************')
    # exit(1)
    # res_mul = dec_2_ieee(res_mul)
    print('******************')
    print(f'MULTIPLY_RESULT: {res_mul}')
    if not args.full:
        assert res_mul == ref_mul, f'Actual: {ref_mul} Got: {res_mul}'
    else:
        if (res_mul == ref_mul):
            print('MUL_PASS')
        else:
            print(f'ref_mul: {ref_mul}    res_mul: {res_mul}')
            print('MUL_FAIL')

    debug_print(f'(MAC) *************************************MULTIPLICATION DONE************************************************************')
    debug_print(f'(MAC) ***************************************ADDITION STARTED*************************************************************')
    # res_mul = '0110010011100000'
    res_add = adder(res_mul, val3.ljust(32,'0'))
    print(f'ADD RESULT: {res_add}')
    print('******************')
    print(f'REFERNCE value: {ref_val}')

    if not args.full:
        assert ref_val == res_add,f'{ref_val} != {res_add}'
    else:
        if (ref_val == res_add):
            print('ADD_PASS')
        else:
            print(f'ref_val: {ref_val}    res_add: {res_add}')
            print('ADD_FAIL')


async def test_1(dut, i):
    clock = Clock(dut.CLK, 10, units="us")  
    cocotb.start_soon(clock.start(start_high=False))
    await reset(dut)

    while True:
        if(dut.RDY_get_start.value == 1):
            dut.get_start_start.value = 1
            dut.EN_get_start.value = 1
            dut._log.info("MAC started")            
            break
        await RisingEdge(dut.CLK)
    a_val = int(a[i][:-1],2)
    b_val = int(b[i][:-1],2)
    c_val = int(c[i][:-1],2)
    dut._log.info(f"a_val: {bin(a_val).replace('0b','').rjust(16,'0')}")
    dut._log.info(f"b_val: {bin(b_val).replace('0b','').rjust(16,'0')}")
    dut._log.info(f"c_val: {bin(c_val).replace('0b','').rjust(16,'0')}")

    while True:
        if (dut.RDY_get_input_a.value == 1):
            dut.get_input_a_a.value = a_val
            dut.EN_get_input_a.value = 1
            break
        await RisingEdge(dut.CLK)

    while True:
        if (dut.RDY_get_input_b.value == 1):
            dut.get_input_b_b.value = b_val
            dut.EN_get_input_b.value = 1
            break
        await RisingEdge(dut.CLK)

    while True:
        if (dut.RDY_get_input_c.value == 1):
            dut.get_input_c_c.value = c_val
            dut.EN_get_input_c.value = 1
            break
        await RisingEdge(dut.CLK)

    ref_ans_val = ref_ans[i][:-1]
    ref_ans_sign = ref_ans_val[0]
    ref_ans_exp = ref_ans_val[1:9]
    ref_ans_man = ref_ans_val[9:]

    while True:
        if dut.RDY_get_input_s.value == 1:
            dut.EN_get_input_s.value = 1
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

    while True:
        if (dut.get_stop.value == 0):
            break
        await RisingEdge(dut.CLK)
    dut._log.info("MAC float Completed")



Tf = TestFactory(test_1)
Tf.add_option(name = "i",optionlist = list(range(2)))
Tf.generate_tests()