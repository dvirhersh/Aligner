`include "tests/cfs_algn_test_pkg.sv"

module testbench();

    import uvm_pkg::*;
    import cfs_algn_test_pkg::*;

    reg clk;
    initial begin
        clk = 0;
        forever begin
            clk = #5ns ~clk;
        end
    end

    initial begin
        apb_if.preset_n = 1;
        #6ns;
        apb_if.preset_n = 0;
        #30ns;
        apb_if.preset_n = 1;
    end

    cfs_apb_if apb_if(.pclk(clk));

    initial begin
        uvm_config_db#(virtual cfs_apb_if)::set(null, "uvm_test_top.env.apb_agent", "vif", apb_if);

        run_test("cfs_algn_test_reg_access");
    end

    cfs_aligner dut(
        .clk(    clk),
        .reset_n(apb_if.preset_n),

        .paddr(  apb_if.paddr),
        .pwrite( apb_if.pwrite),
        .psel(   apb_if.psel),
        .penable(apb_if.penable),
        .pwdata( apb_if.pwdata),
        .pready( apb_if.pready),
        .prdata( apb_if.prdata),
        .pslverr(apb_if.pslverr)
    );

endmodule
