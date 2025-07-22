`ifndef CFS_APB_AGENT_SV
    `define CFS_APB_AGENT_SV

    class cfs_apb_agent extends uvm_agent;

        cfs_apb_agent_config agent_config;

        cfs_apb_driver    driver;
        cfs_apb_sequencer sequencer;
        cfs_apb_monitor   monitor;
        cfs_apb_coverage  coverage;

        `uvm_component_utils(cfs_apb_agent)

        function new(string name = "", uvm_component parent);
            super.new(name, parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            agent_config = cfs_apb_agent_config::type_id::create("agent_config", this);
            monitor      = cfs_apb_monitor::type_id::create("monitor", this);

            if (agent_config.get_has_coverage()) begin
                coverage = cfs_apb_coverage::type_id::create("coverage", this);
            end

            if (agent_config.get_active_passive() == UVM_ACTIVE) begin
                driver    = cfs_apb_driver::type_id::create("driver", this);
                sequencer = cfs_apb_sequencer::type_id::create("sequencer", this);
            end
        endfunction

        virtual function void connect_phase(uvm_phase phase);
            cfs_apb_vif vif;
            string      vif_name = "vif";

            super.connect_phase(phase);

            if (!uvm_config_db#(virtual cfs_apb_if)::get(this, "", vif_name, vif)) begin
                `uvm_fatal("APB_NO_VIF", $sformatf("Could not get from the database the APB "+
                           "virtual interface using name \"%0s\"", vif_name))
            end
            else begin
                agent_config.set_vif(vif);
            end

            monitor.agent_config = agent_config;

            if(agent_config.get_has_coverage()) begin
                coverage.agent_config = agent_config;

                monitor.output_port.connect(coverage.port_item);
            end

            if (agent_config.get_active_passive() == UVM_ACTIVE) begin
                driver.seq_item_port.connect(sequencer.seq_item_export);
                driver.agent_config = agent_config;
            end
        endfunction

    endclass

`endif
