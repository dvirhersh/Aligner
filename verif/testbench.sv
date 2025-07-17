`include "tests/cfs_algn_test_pkg.sv"

module testbench ();

    import uvm_pkg::*;
    import cfs_algn_test_pkg::*;

    reg clk;

    initial begin
        clk = 0;
        forever begin
            clk = #5ns ~clk;
        end
    end

    reg reset_n;

    initial begin
        reset_n = 1;
        #6ns;
        reset_n = 0;
        #30ns;
        reset_n = 1;
    end

    initial begin

        $dumpfile("dump.vcd");
        $dumpvars;

        run_test("cfs_algn_test_reg_access");
    end

    cfs_aligner dut(
        .clk(    clk),
        .reset_n(reset_n)
    );

endmodule