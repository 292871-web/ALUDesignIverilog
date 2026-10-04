# Adder/Subtractor Timing Benchmark

## Objective
This directory contains a custom verification environment built with `cocotb` and Python. The goal of this experiment was to test and observe how timing delays and clock edge constraints impact the mathematical correctness of 32-bit addition and subtraction operations.

## Methodology
- **Stimulus Generation:** Random 32-bit integers are applied to inputs `A` and `B` across multiple test iterations.
- **Timing Sweep:** The testbench sweeps the sampling delay (from 10,000 ps down to 100 ps) to simulate aggressive sampling conditions.
- **Automated Data Logging:** Results are exported directly to a timestamped Excel spreadsheet (`.xlsx`) using `openpyxl`.
- **Validation:** Excel formulas automatically verify hardware outputs against expected mathematical results.

---

> ### 💡 Key Engineering Insight & Lesson Learned
> **Initial Assumption vs. Reality:**
> When I first designed this benchmark, my intention was to observe timing failures directly within the behavioral RTL simulation. However, running the test revealed a fundamental property of HDL simulation: **behavioral RTL assumes zero-delay delta cycles**. As a result, all tests passed with 100% accuracy.


