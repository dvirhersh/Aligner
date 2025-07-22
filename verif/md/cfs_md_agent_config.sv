`ifndef CFS_MD_AGENT_CONFIG_SV
    `define CFS_MD_AGENT_CONFIG_SV

    class cfs_md_agent_config extends uvm_component;

        // local cfs_md_vif             vif;
        local uvm_active_passive_enum active_passive;
        local bit                     has_checks;
        local bit                     has_coverage;

        `uvm_component_utils(cfs_md_agent_config)

        function new(string name = "", uvm_component parent);
            super.new(name, parent);

            active_passive  = UVM_ACTIVE;
            has_coverage    = 1;
            has_checks      = 1;
        endfunction

        virtual function uvm_active_passive_enum get_active_passive();
            return active_passive;
        endfunction

        virtual function void set_active_passive(uvm_active_passive_enum value);
            active_passive = value;
        endfunction

        virtual function bit get_has_checks();
            return has_checks;
        endfunction

        virtual function void set_has_checks(bit value);
            has_checks = value;

            if(vif != null) begin
                vif.has_checks = has_checks;
            end
        endfunction

        virtual function bit get_has_coverage();
            return has_coverage;
        endfunction

        virtual function void set_has_coverage(bit value);
            has_coverage = value;
        endfunction

        virtual function cfs_md_vif get_vif();
            return vif;
        endfunction

        virtual function void set_vif(cfs_md_vif value);
            if(vif == null) begin
                vif = value;

                set_has_checks(get_has_checks());
            end
            else begin
                `uvm_fatal("ALGORITHM_ISSUE", "Trying to set the md virtual interface more than "
                           "once")
            end
        endfunction

        virtual function void start_of_simulation_phase(uvm_phase phase);
            super.start_of_simulation_phase(phase);

            if(get_vif() == null) begin
                `uvm_fatal("ALGORITHM_ISSUE", "The md virtual interface is not configured at "
                           "\"Start of simulation\" phase")
            end
            else begin
                `uvm_info("md_CONFIG", "The md virtual interface is configured at \"Start of "
                          "simulation\" phase", UVM_DEBUG)
            end
        endfunction

        // virtual function void end_of_elaboration_phase(uvm_phase phase);
        //     uvm_top.print_topology();
        // endfunction

        virtual task run_phase(uvm_phase phase);
            forever begin
                @(vif.has_checks);

                if(vif.has_checks != get_has_checks()) begin
                    `uvm_error("ALGORITHM_ISSUE", $sformatf("Can not change \"has_checks\" from "+
                               "md interface directly - use %0s.set_has_checks()",
                               get_full_name()))
                end
            end

        endtask

    endclass

`endif
