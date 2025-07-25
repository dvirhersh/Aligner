`ifndef CFS_APB_TYPES_SV
    `define CFS_APB_TYPES_SV

    typedef virtual cfs_apb_if cfs_apb_vif;

    typedef enum bit {CFS_APB_READ = 0, CFS_APB_WRITE = 1} cfs_apb_dir_e;

    typedef bit[`CFS_APB_MAX_ADDR_WIDTH-1:0] cfs_apb_addr;

    typedef bit[`CFS_APB_MAX_DATA_WIDTH-1:0] cfs_apb_data;

    typedef enum bit {CFS_APB_OKAY = 0, CFS_APB_ERR = 1} cfs_apb_response_e;

`endif
