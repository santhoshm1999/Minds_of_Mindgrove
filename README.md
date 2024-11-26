```
.
├── CS6230
│   ├── assignment_1
│   │   ├── float
│   │   │   ├── intermediate
│   │   │   │   ├── MAC_unpipelined_float_add.bo
│   │   │   │   ├── MAC_unpipelined_float.bo
│   │   │   │   ├── MAC_unpipelined_float_mul.bo
│   │   │   │   ├── mkUnpipelined_float_add.ba
│   │   │   │   ├── mkUnpipelined_float_add.sched
│   │   │   │   ├── mkUnpipelined_float.ba
│   │   │   │   ├── mkUnpipelined_float_mul.ba
│   │   │   │   ├── mkUnpipelined_float_mul.sched
│   │   │   │   └── mkUnpipelined_float.sched
│   │   │   ├── MAC_unpipelined_float_add.bsv
│   │   │   ├── MAC_unpipelined_float.bsv
│   │   │   ├── MAC_unpipelined_float_mul.bsv
│   │   │   ├── Makefile
│   │   │   ├── test_cases
│   │   │   │   ├── A_binary.txt
│   │   │   │   ├── A_decimal.txt
│   │   │   │   ├── B_binary.txt
│   │   │   │   ├── B_decimal.txt
│   │   │   │   ├── C_binary.txt
│   │   │   │   ├── C_decimal.txt
│   │   │   │   ├── combined_AB_binary.txt
│   │   │   │   ├── MAC_binary.txt
│   │   │   │   └── MAC_decimal.txt
│   │   │   ├── verif
│   │   │   │   ├── Makefile
│   │   │   │   └── test_MAC_fp.py
│   │   │   └── verilog
│   │   │       ├── mkUnpipelined_float_add.use
│   │   │       ├── mkUnpipelined_float_add.v
│   │   │       ├── mkUnpipelined_float_mul.use
│   │   │       ├── mkUnpipelined_float_mul.v
│   │   │       ├── mkUnpipelined_float.use
│   │   │       └── mkUnpipelined_float.v
│   │   ├── int
│   │   │   ├── dump.vcd.gtkw
│   │   │   ├── int8MAC
│   │   │   │   ├── A_binary.txt
│   │   │   │   ├── A_decimal.txt
│   │   │   │   ├── B_binary.txt
│   │   │   │   ├── B_decimal.txt
│   │   │   │   ├── C_binary.txt
│   │   │   │   ├── C_decimal.txt
│   │   │   │   ├── MAC_binary.txt
│   │   │   │   └── MAC_decimal.txt
│   │   │   ├── intermediate
│   │   │   │   ├── add.bo
│   │   │   │   ├── MAC_unpipelined_int.bo
│   │   │   │   ├── mkintmul.ba
│   │   │   │   ├── mkintmul.sched
│   │   │   │   └── mul.bo
│   │   │   ├── MAC_unpipelined_int.bsv
│   │   │   ├── Makefile
│   │   │   ├── pipelined_int
│   │   │   │   ├── int8MAC
│   │   │   │   │   ├── A_binary.txt
│   │   │   │   │   ├── A_decimal.txt
│   │   │   │   │   ├── B_binary.txt
│   │   │   │   │   ├── B_decimal.txt
│   │   │   │   │   ├── C_binary.txt
│   │   │   │   │   ├── C_decimal.txt
│   │   │   │   │   ├── MAC_binary.txt
│   │   │   │   │   └── MAC_decimal.txt
│   │   │   │   ├── intermediate
│   │   │   │   │   ├── MAC_pipelined_int.bo
│   │   │   │   │   ├── mkintmul.ba
│   │   │   │   │   └── mkintmul.sched
│   │   │   │   ├── MAC_pipelined_int.bsv
│   │   │   │   ├── Makefile
│   │   │   │   ├── verif
│   │   │   │   │   ├── Makefile
│   │   │   │   │   └── test_pip_int.py
│   │   │   │   └── verilog
│   │   │   │       ├── mkintmul.use
│   │   │   │       └── mkintmul.v
│   │   │   ├── results.xml
│   │   │   ├── verif
│   │   │   │   ├── Makefile
│   │   │   │   └── test_MAC_int.py
│   │   │   └── verilog
│   │   │       ├── mkintmul.use
│   │   │       └── mkintmul.v
│   │   ├── pipelined
│   │   │   ├── bf16_MAC
│   │   │   │   ├── A_binary.txt
│   │   │   │   ├── A_decimal.txt
│   │   │   │   ├── B_binary.txt
│   │   │   │   ├── B_decimal.txt
│   │   │   │   ├── C_binary.txt
│   │   │   │   ├── C_decimal.txt
│   │   │   │   ├── combined_AB_binary.txt
│   │   │   │   ├── MAC_binary.txt
│   │   │   │   └── MAC_decimal.txt
│   │   │   ├── int8_MAC
│   │   │   │   ├── A_binary.txt
│   │   │   │   ├── A_decimal.txt
│   │   │   │   ├── B_binary.txt
│   │   │   │   ├── B_decimal.txt
│   │   │   │   ├── C_binary.txt
│   │   │   │   ├── C_decimal.txt
│   │   │   │   ├── MAC_binary.txt
│   │   │   │   └── MAC_decimal.txt
│   │   │   ├── intermediate
│   │   │   │   ├── MAC_pipelined.bo
│   │   │   │   ├── MAC_pipelined_float_add.bo
│   │   │   │   ├── MAC_pipelined_float.bo
│   │   │   │   ├── MAC_pipelined_float_mul.bo
│   │   │   │   ├── MAC_pipelined_int.bo
│   │   │   │   ├── MAC_types.bo
│   │   │   │   ├── mkintmul.ba
│   │   │   │   ├── mkintmul.sched
│   │   │   │   ├── mkMAC_pipelined.ba
│   │   │   │   ├── mkMAC_pipelined.sched
│   │   │   │   ├── mkPipelined_float_add.ba
│   │   │   │   ├── mkPipelined_float_add.sched
│   │   │   │   ├── mkPipelined_float.ba
│   │   │   │   ├── mkPipelined_float_mul.ba
│   │   │   │   ├── mkPipelined_float_mul.sched
│   │   │   │   └── mkPipelined_float.sched
│   │   │   ├── MAC_pipelined.bsv
│   │   │   ├── MAC_pipelined_float_add.bsv
│   │   │   ├── MAC_pipelined_float.bsv
│   │   │   ├── MAC_pipelined_float_mul.bsv
│   │   │   ├── MAC_pipelined_int.bsv
│   │   │   ├── MAC_types.bsv
│   │   │   ├── Makefile
│   │   │   ├── results.xml
│   │   │   ├── verif
│   │   │   │   ├── Makefile
│   │   │   │   └── test_MAC_pipelined.py
│   │   │   └── verilog
│   │   │       ├── mkintmul.use
│   │   │       ├── mkintmul.v
│   │   │       ├── mkMAC_pipelined.use
│   │   │       ├── mkMAC_pipelined.v
│   │   │       ├── mkPipelined_float_add.use
│   │   │       ├── mkPipelined_float_add.v
│   │   │       ├── mkPipelined_float_mul.use
│   │   │       ├── mkPipelined_float_mul.v
│   │   │       ├── mkPipelined_float.use
│   │   │       └── mkPipelined_float.v
│   │   ├── Report.pdf
│   │   └── unpipelined
│   │       ├── bf16_MAC
│   │       │   ├── A_binary.txt
│   │       │   ├── A_decimal.txt
│   │       │   ├── B_binary.txt
│   │       │   ├── B_decimal.txt
│   │       │   ├── C_binary.txt
│   │       │   ├── C_decimal.txt
│   │       │   ├── combined_AB_binary.txt
│   │       │   ├── MAC_binary.txt
│   │       │   └── MAC_decimal.txt
│   │       ├── int8_MAC
│   │       │   ├── A_binary.txt
│   │       │   ├── A_decimal.txt
│   │       │   ├── B_binary.txt
│   │       │   ├── B_decimal.txt
│   │       │   ├── C_binary.txt
│   │       │   ├── C_decimal.txt
│   │       │   ├── MAC_binary.txt
│   │       │   └── MAC_decimal.txt
│   │       ├── intermediate
│   │       │   ├── MAC_unpipelined_float_add.bo
│   │       │   ├── MAC_unpipelined_float.bo
│   │       │   ├── MAC_unpipelined_float_mul.bo
│   │       │   ├── MAC_unpipelined_int.bo
│   │       │   ├── MAC_unpipelined_top.bo
│   │       │   ├── mkintmul.ba
│   │       │   ├── mkintmul.sched
│   │       │   ├── mkMAC.ba
│   │       │   ├── mkMAC.sched
│   │       │   ├── mkUnpipelined_float_add.ba
│   │       │   ├── mkUnpipelined_float_add.sched
│   │       │   ├── mkUnpipelined_float.ba
│   │       │   ├── mkUnpipelined_float_mul.ba
│   │       │   ├── mkUnpipelined_float_mul.sched
│   │       │   └── mkUnpipelined_float.sched
│   │       ├── MAC_unpipelined_float_add.bsv
│   │       ├── MAC_unpipelined_float.bsv
│   │       ├── MAC_unpipelined_float_mul.bsv
│   │       ├── MAC_unpipelined_int.bsv
│   │       ├── MAC_unpipelined_top.bsv
│   │       ├── Makefile
│   │       ├── results.xml
│   │       ├── verif
│   │       │   ├── log
│   │       │   ├── Makefile
│   │       │   └── test_MAC.py
│   │       └── verilog
│   │           ├── mkintmul.use
│   │           ├── mkintmul.v
│   │           ├── mkMAC.use
│   │           ├── mkMAC.v
│   │           ├── mkUnpipelined_float_add.use
│   │           ├── mkUnpipelined_float_add.v
│   │           ├── mkUnpipelined_float_mul.use
│   │           ├── mkUnpipelined_float_mul.v
│   │           ├── mkUnpipelined_float.use
│   │           └── mkUnpipelined_float.v
│   ├── assignment_2
│   │   ├── bf16_MAC
│   │   │   ├── A_binary.txt
│   │   │   ├── A_decimal.txt
│   │   │   ├── B_binary.txt
│   │   │   ├── B_decimal.txt
│   │   │   ├── C_binary.txt
│   │   │   ├── C_decimal.txt
│   │   │   ├── combined_AB_binary.txt
│   │   │   ├── MAC_binary.txt
│   │   │   └── MAC_decimal.txt
│   │   ├── int8_MAC
│   │   │   ├── A_binary.txt
│   │   │   ├── A_decimal.txt
│   │   │   ├── B_binary.txt
│   │   │   ├── B_decimal.txt
│   │   │   ├── C_binary.txt
│   │   │   ├── C_decimal.txt
│   │   │   ├── MAC_binary.txt
│   │   │   └── MAC_decimal.txt
│   │   ├── MAC_pipelined.bsv
│   │   ├── MAC_pipelined_float_add.bsv
│   │   ├── MAC_pipelined_float.bsv
│   │   ├── MAC_pipelined_float_mul.bsv
│   │   ├── MAC_pipelined_int.bsv
│   │   ├── MAC_types.bsv
│   │   ├── Makefile
│   │   ├── systolic_array.bsv
│   │   └── verif
│   │       ├── Makefile
│   │       └── test_MAC_pipelined.py
│   ├── float
│   │   ├── dump.vcd
│   │   ├── sim_build
│   │   │   ├── verilated.d
│   │   │   ├── verilated_dpi.d
│   │   │   ├── verilated_dpi.o
│   │   │   ├── verilated.o
│   │   │   ├── verilated_vcd_c.d
│   │   │   ├── verilated_vcd_c.o
│   │   │   ├── verilated_vpi.d
│   │   │   ├── verilated_vpi.o
│   │   │   ├── verilator.d
│   │   │   ├── verilator.o
│   │   │   ├── Vtop
│   │   │   ├── Vtop__ALL.a
│   │   │   ├── Vtop__ALL.cpp
│   │   │   ├── Vtop__ALL.d
│   │   │   ├── Vtop__ALL.o
│   │   │   ├── Vtop_classes.mk
│   │   │   ├── Vtop.cpp
│   │   │   ├── Vtop__Dpi.cpp
│   │   │   ├── Vtop__Dpi.h
│   │   │   ├── Vtop.h
│   │   │   ├── Vtop.mk
│   │   │   ├── Vtop__Slow.cpp
│   │   │   ├── Vtop__Syms.cpp
│   │   │   ├── Vtop__Syms.h
│   │   │   ├── Vtop__Trace.cpp
│   │   │   └── Vtop__Trace__Slow.cpp
│   │   └── verif
│   │       └── __pycache__
│   │           └── test_MAC_fp.cpython-312-pytest-8.3.2.pyc
│   ├── int
│   │   ├── dump.vcd
│   │   ├── sim_build
│   │   │   ├── verilated.d
│   │   │   ├── verilated_dpi.d
│   │   │   ├── verilated_dpi.o
│   │   │   ├── verilated.o
│   │   │   ├── verilated_vcd_c.d
│   │   │   ├── verilated_vcd_c.o
│   │   │   ├── verilated_vpi.d
│   │   │   ├── verilated_vpi.o
│   │   │   ├── verilator.d
│   │   │   ├── verilator.o
│   │   │   ├── Vtop
│   │   │   ├── Vtop__ALL.a
│   │   │   ├── Vtop__ALL.cpp
│   │   │   ├── Vtop__ALL.d
│   │   │   ├── Vtop__ALL.o
│   │   │   ├── Vtop_classes.mk
│   │   │   ├── Vtop.cpp
│   │   │   ├── Vtop__Dpi.cpp
│   │   │   ├── Vtop__Dpi.h
│   │   │   ├── Vtop.h
│   │   │   ├── Vtop.mk
│   │   │   ├── Vtop__Slow.cpp
│   │   │   ├── Vtop__Syms.cpp
│   │   │   ├── Vtop__Syms.h
│   │   │   ├── Vtop__Trace.cpp
│   │   │   ├── Vtop__Trace__Slow.cpp
│   │   │   ├── Vtop__ver.d
│   │   │   └── Vtop__verFiles.dat
│   │   └── verif
│   │       └── __pycache__
│   │           └── test_MAC_int.cpython-312-pytest-8.3.2.pyc
│   ├── Pipelined
│   │   ├── dump.vcd
│   │   ├── sim_build
│   │   │   ├── verilated.d
│   │   │   ├── verilated_dpi.d
│   │   │   ├── verilated_dpi.o
│   │   │   ├── verilated.o
│   │   │   ├── verilated_vcd_c.d
│   │   │   ├── verilated_vcd_c.o
│   │   │   ├── verilated_vpi.d
│   │   │   ├── verilated_vpi.o
│   │   │   ├── verilator.d
│   │   │   ├── verilator.o
│   │   │   ├── Vtop
│   │   │   ├── Vtop__ALL.a
│   │   │   ├── Vtop__ALL.cpp
│   │   │   ├── Vtop__ALL.d
│   │   │   ├── Vtop__ALL.o
│   │   │   ├── Vtop_classes.mk
│   │   │   ├── Vtop.cpp
│   │   │   ├── Vtop__Dpi.cpp
│   │   │   ├── Vtop__Dpi.h
│   │   │   ├── Vtop.h
│   │   │   ├── Vtop.mk
│   │   │   ├── Vtop__Slow.cpp
│   │   │   ├── Vtop__Syms.cpp
│   │   │   ├── Vtop__Syms.h
│   │   │   ├── Vtop__Trace.cpp
│   │   │   └── Vtop__Trace__Slow.cpp
│   │   └── verif
│   │       └── __pycache__
│   │           └── test_MAC_fp.cpython-312-pytest-8.3.2.pyc
│   ├── pipelined_int
│   │   ├── dump.vcd
│   │   ├── sim_build
│   │   │   ├── verilated.d
│   │   │   ├── verilated_dpi.d
│   │   │   ├── verilated_dpi.o
│   │   │   ├── verilated.o
│   │   │   ├── verilated_vcd_c.d
│   │   │   ├── verilated_vcd_c.o
│   │   │   ├── verilated_vpi.d
│   │   │   ├── verilated_vpi.o
│   │   │   ├── verilator.d
│   │   │   ├── verilator.o
│   │   │   ├── Vtop
│   │   │   ├── Vtop__ALL.a
│   │   │   ├── Vtop__ALL.cpp
│   │   │   ├── Vtop__ALL.d
│   │   │   ├── Vtop__ALL.o
│   │   │   ├── Vtop_classes.mk
│   │   │   ├── Vtop.cpp
│   │   │   ├── Vtop__Dpi.cpp
│   │   │   ├── Vtop__Dpi.h
│   │   │   ├── Vtop.h
│   │   │   ├── Vtop.mk
│   │   │   ├── Vtop__Slow.cpp
│   │   │   ├── Vtop__Syms.cpp
│   │   │   ├── Vtop__Syms.h
│   │   │   ├── Vtop__Trace.cpp
│   │   │   └── Vtop__Trace__Slow.cpp
│   │   └── verif
│   │       └── __pycache__
│   │           └── test_pip_int.cpython-312-pytest-8.3.2.pyc
│   ├── pipelined_MAC
│   │   ├── dump.vcd
│   │   ├── sim_build
│   │   │   ├── verilated.d
│   │   │   ├── verilated_dpi.d
│   │   │   ├── verilated_dpi.o
│   │   │   ├── verilated.o
│   │   │   ├── verilated_vcd_c.d
│   │   │   ├── verilated_vcd_c.o
│   │   │   ├── verilated_vpi.d
│   │   │   ├── verilated_vpi.o
│   │   │   ├── verilator.d
│   │   │   ├── verilator.o
│   │   │   ├── Vtop
│   │   │   ├── Vtop__ALL.a
│   │   │   ├── Vtop__ALL.cpp
│   │   │   ├── Vtop__ALL.d
│   │   │   ├── Vtop__ALL.o
│   │   │   ├── Vtop_classes.mk
│   │   │   ├── Vtop.cpp
│   │   │   ├── Vtop__Dpi.cpp
│   │   │   ├── Vtop__Dpi.h
│   │   │   ├── Vtop.h
│   │   │   ├── Vtop.mk
│   │   │   ├── Vtop__Slow.cpp
│   │   │   ├── Vtop__Syms.cpp
│   │   │   ├── Vtop__Syms.h
│   │   │   ├── Vtop__Trace.cpp
│   │   │   └── Vtop__Trace__Slow.cpp
│   │   └── verif
│   │       └── __pycache__
│   │           └── test_MAC_pipelined.cpython-312-pytest-8.3.2.pyc
│   ├── README.md
│   └── Unpipelined
│       ├── dump.vcd
│       ├── sim_build
│       │   ├── verilated.d
│       │   ├── verilated_dpi.d
│       │   ├── verilated_dpi.o
│       │   ├── verilated.o
│       │   ├── verilated_vcd_c.d
│       │   ├── verilated_vcd_c.o
│       │   ├── verilated_vpi.d
│       │   ├── verilated_vpi.o
│       │   ├── verilator.d
│       │   ├── verilator.o
│       │   ├── Vtop
│       │   ├── Vtop__ALL.a
│       │   ├── Vtop__ALL.cpp
│       │   ├── Vtop__ALL.d
│       │   ├── Vtop__ALL.o
│       │   ├── Vtop_classes.mk
│       │   ├── Vtop.cpp
│       │   ├── Vtop__Dpi.cpp
│       │   ├── Vtop__Dpi.h
│       │   ├── Vtop.h
│       │   ├── Vtop.mk
│       │   ├── Vtop__Slow.cpp
│       │   ├── Vtop__Syms.cpp
│       │   ├── Vtop__Syms.h
│       │   ├── Vtop__Trace.cpp
│       │   └── Vtop__Trace__Slow.cpp
│       └── verif
│           └── __pycache__
│               └── test_MAC.cpython-312-pytest-8.3.2.pyc
└── README.md

```