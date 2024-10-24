SIM ?= verilator
TOPLEVEL_LANG ?= verilog

PWD=$(shell pwd)

export PYTHONPATH:=$(PWD)/verif:$(PYTHONPATH)

VERILOG_SOURCES=$(PWD)/verilog/mkUnpipelined.v

EXTRA_ARGS = --trace --trace-structs

TOPLEVEL = mkUnpipelined
MODULE   := test_MAC_fp

include $(shell cocotb-config --makefiles)/Makefile.sim
