import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge



def read_testcases():
    program = []
    with open("program1.txt") as f:
        for line in f:
            instr = [int(c) for c in line]
            program.append(instr)

    return program

def bits_to_int(bit_list):
    res = 0
    for b in bit_list:
        res = res * 2 + b
    return res


async def reset(dut):
    dut.reset.value = 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    dut.reset.value = 0

@cocotb.test()
async def test_processor(dut):
    program = read_testcases()

    # Automatic clock (timescale is for VCD files)
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    # Reset DUT
    await reset(dut)
    result = 0

    for instr in program:
        dut.instruction.value = bits_to_int(instr)
        await RisingEdge(dut.clk)
    
    result = dut.result.value
    print(result)
    assert(result == 5) #test program computes 1 | 4
    
