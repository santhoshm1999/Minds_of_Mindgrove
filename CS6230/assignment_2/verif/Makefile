SIM ?= verilator
TOPLEVEL_LANG ?= verilog

PWD=$(shell pwd)

export PYTHONPATH:=$(PWD)/verif:$(PYTHONPATH)

VERILOG_SOURCES=$(PWD)/verilog/*.v

EXTRA_ARGS = --trace --trace-structs

TOPLEVEL = mkSystolic
MODULE   := test_MAC_pipelined

include $(shell cocotb-config --makefiles)/Makefile.sim