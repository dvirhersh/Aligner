`ifndef CFS_MD_AGENT_MASTER_SV
    `define CFS_MD_AGENT_MASTER_SV

    class cfs_md_agent_master#(int unsigned DATA_WIDTH = 32) extends cfs_md_agent implements cfs_md_reset_handler;

        `uvm_component_param_utils(cfs_md_agent_master)

        function new(string name = "", uvm_component parent);
            super.new(name, parent);

            cfs_md_agent_config#(DATA_WIDTH)::type_id::set_inst_override(
                cfs_md_agent_config_master#(DATA_WIDTH)::get_type(), "agent_config", this);
        endfunction

    endclass

`endif
