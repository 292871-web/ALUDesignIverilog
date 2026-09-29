---

## 📖 DevLog / Learning Journey

### [2026-09-28] - Mastering cocotb & Rethinking Architecture
**Milestone:** Successfully set up and ran my first ideal (behavioral) simulation using `cocotb` and Python. It was a crucial step to ensure the mathematical logic is flawless before stepping into the physical design flow.
## 🚀 How to Run the Benchmark

Follow these steps to execute the `cocotb` testbench and generate the timing analysis report.

### 1. Prerequisites
Ensure you have a Verilog simulator installed (e.g., [Icarus Verilog](http://iverilog.icarus.com/) or Verilator). Then, install the required Python dependencies:
```bash
pip install cocotb openpyxl 
```
### 2. Execution
Navigate to the directory containing the Makefile and start the simulation:
```bash 
make
```
3. Reviewing the Results
* Once the simulation completes, the script automatically exports the data to a spreadsheet.
* Navigate to the ./Benchmarks/addSub/ directory.
* Open the newly generated, timestamped Excel file (e.g., '2026-09-28 10:47:55.495696+00:00.xlsx').

Check the isTrue column to observe the exact picosecond delay threshold where the critical path breaks and hardware logic fails.
**Key Changes:**
* **Architecture Cleanup:** I completely removed the standalone subtractor module from the repository. I realized it was entirely redundant and a waste of silicon area. Instead, I am now relying on a unified `subAdder` module that handles subtraction using Two's complement logic (inverting `B` and setting `carryIn` to 1). 
* **Next Steps:** With the behavioral RTL fully verified, the immediate next goal is to push this `subAdder` through the OpenLane toolchain (RTL-to-GDSII). I want to see how the physical layout looks and test the actual timing limits using Gate-Level Simulation (GLS) based on the generated delays.

---

## 📖 DevLog / Learning Journey

### [2026-09-29] - Conquering Sky130 & First GDSII Layout
**Milestone:** Successfully pushed my purely combinational 32-bit Carry-Lookahead Adder (`addsub32`) through the complete RTL-to-GDSII physical design flow using OpenLane. Achieved timing closure at 200 MHz under worst-case thermal and voltage constraints, producing a clean physical layout.

**Key Changes:**
* **Overcoming Physical Limits:** Initially tried forcing a 2.0ns clock (500 MHz) using aggressive Yosys cell upsizing (SYNTH_STRATEGY: "DELAY 1"). I hit a physical wall (Setup Violations) due to high fan-out on carry nets and routing congestion.
* **Timing Closure:** Adjusted the target clock to 5ns to satisfy the ss_100C_1v60 (Slow-Slow, 100°C, 1.60V) PVT corner, securing a clean physical signoff with 0 DRC, 0 LVS, and 0 XOR violations.
* **PPA Realizations:** The design mathematically achieves 200 MHz in typical room-temperature conditions (tt_025C_1v80), proving the CLA architecture is solid before pipelining is introduced.

* **Next Steps:** With the physical layout generated, the immediate next goal is to run post-synthesis Gate-Level Simulation (GLS). I need to update my Makefile and cocotb setup to load the Sky130 standard cell library, the synthesized netlist (.nl.v), and the SDF delay file to prove the hardware works flawlessly under realistic physical delays.
