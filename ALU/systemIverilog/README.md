---

## 📖 DevLog / Learning Journey

### [2026-09-28] - Mastering cocotb & Rethinking Architecture
**Milestone:** Successfully set up and ran my first ideal (behavioral) simulation using `cocotb` and Python. It was a crucial step to ensure the mathematical logic is flawless before stepping into the physical design flow.

**Key Changes:**
* **Architecture Cleanup:** I completely removed the standalone subtractor module from the repository. I realized it was entirely redundant and a waste of silicon area. Instead, I am now relying on a unified `subAdder` module that handles subtraction using Two's complement logic (inverting `B` and setting `carryIn` to 1). 
* **Next Steps:** With the behavioral RTL fully verified, the immediate next goal is to push this `subAdder` through the OpenLane toolchain (RTL-to-GDSII). I want to see how the physical layout looks and test the actual timing limits using Gate-Level Simulation (GLS) based on the generated delays.
