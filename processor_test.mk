TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(shell pwd)/processor.sv
TOPLEVEL = processor
MODULE = processor_test
include $(shell cocotb-config --makefiles)/Makefile.sim
