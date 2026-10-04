SIM ?= icarus
TOPLEVEL_LANG ?= verilog
TOPLEVEL ?= addsub32
WAVES ?= 1
MODULE ?= testbench
PDK_VERILOG = home/admin/.ciel/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A/libs.ref/sky130_fd_sc_hd/verilog/
#verilog
SOURCES ?= fullAdder.sv alu.sv
rtlSim:
	$(MAKE)	sim \
		VERILOG_SOURCES="fullAdder.sv" \
		WAVES=1
gtsSim:
	$(MAKE) sim \
		VERILOG_SOURCES="../build/runs/1_10_26/final/nl/addsub32.nl.v $(PDK_VERILOG)primitives.v $(PDK_VERILOG)sky130_fd_sc_hd.v" \
		COMPILE_ARGS="-DFUNCTIONAL -DUNIT_DELAY=#1"
		
		
syntaxALU:
	iverilog -g2012 -s ALU $(SOURCES)
			
include $(shell cocotb-config --makefiles)/Makefile.sim
