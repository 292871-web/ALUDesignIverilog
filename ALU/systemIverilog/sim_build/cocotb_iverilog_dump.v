module cocotb_iverilog_dump();
initial begin
    $dumpfile("sim_build/addsub32.fst");
    $dumpvars(0, addsub32);
end
endmodule
