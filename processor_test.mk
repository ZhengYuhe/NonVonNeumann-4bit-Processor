TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(shell pwd)/processor.sv
VERILOG_SOURCES += $(shell pwd)/PE.sv
VERILOG_SOURCES += $(shell pwd)/library.sv
TOPLEVEL = processor
MODULE = processor_test
include $(shell cocotb-config --makefiles)/Makefile.sim
