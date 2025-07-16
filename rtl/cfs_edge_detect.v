///////////////////////////////////////////////////////////////////////////////
// File:        cfs_edge_detect.v
// Author:      Cristian Florin Slav
// Date:        2023-06-27
// Description: Edge detector module. It detects a particular edge of the input
//              signal.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_EDGE_DETECT_V
  `define CFS_EDGE_DETECT_V

  module cfs_edge_detect #(parameter EDGE = 1, parameter RESET_VAL = 0)(
    input clk,
    input reset_n,
    input data,

    output detected
  );

  reg dly1_data;

  always@(posedge clk or negedge reset_n) begin
      if(!reset_n) begin
        dly1_data <= RESET_VAL;
      end
      else begin
        dly1_data <= data;
      end
    end

    assign detected = ((data == EDGE) && (dly1_data != EDGE));

  endmodule

`endif
