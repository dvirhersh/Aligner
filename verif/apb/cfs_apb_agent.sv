`ifndef CFS_APB_AGENT_SV
    `define CFS_APB_AGENT_SV

    class cfs_apb_agent extends uvm_agent;

        cfs_apb_agent_config agent_config;

        cfs_apb_driver       driver;
        cfs_apb_sequencer   sequencer;

        `uvm_component_utils(cfs_apb_agent)

        function new(string name = "", uvm_component parent);
            super.new(name, parent);
        endfunction

        virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            agent_config = cfs_apb_agent_config::type_id::create("agent_config", this);

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
                `uvm_fatal("APB_NO_VIF", $sformatf("Could not get from the database the APB virtual interface using name \"%0s\"", vif_name))
            end
            else begin
                agent_config.set_vif(vif);
            end

            if (agent_config.get_active_passive() == UVM_ACTIVE) begin
                driver.agent_config = agent_config;
                driver.seq_item_port.connect(sequencer.seq_item_export);
            end
        endfunction

    endclass

`endif
