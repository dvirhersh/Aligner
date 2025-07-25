`ifndef CFS_APB_SEQUENCE_BASE_SV
    `define CFS_APB_SEQUENCE_BASE_SV

    class cfs_apb_sequence_base extends uvm_sequence#(.REQ(cfs_apb_item_drv));

        `uvm_declare_p_sequencer(cfs_apb_sequencer)

        `uvm_object_utils(cfs_apb_sequence_base)

        function new(string name = "");
            super.new(name);
        endfunction

    endclass

`endif
