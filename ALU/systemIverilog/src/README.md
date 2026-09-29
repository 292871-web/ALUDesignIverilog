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
