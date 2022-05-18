module ethernet_rmii (
    // RMII PHY INTERFACE
    input reg           PHY_CLK,
    input reg [1:0]     PHY_RXD,
    input reg           PHY_RXER,
    output wire [1:0]   PHY_TXD,
    output wire         PHY_TXEN,
    output wire         PHY_RST,
    input reg           PHY_CRS_DV,
    output wire         PHY_MCD,
    input reg           PHY_MDIO,
    
    // ETHERNET AXIS RX INTERFACE
    input reg           ETH_RX_AXIS_CLK,
    input reg           ETH_RX_AXIS_RESET,
    output wire [7:0]   ETH_RX_AXIS_TDATA,
    output wire         ETH_RX_AXIS_TVALID,
    output wire         ETH_RX_AXIS_TLAST,
    input wire          ETH_RX_AXIS_TREADY,
    
    // ETHERNET AXIS TX INTERFACE
    input reg           ETH_TX_AXIS_CLK,
    input reg           ETH_TX_AXIS_RESET,
    input reg [7:0]     ETH_TX_AXIS_TDATA,
    input reg           ETH_TX_AXIS_TVALID,
    input reg           ETH_TX_AXIS_TLAST,
    input reg           ETH_TX_AXIS_TREADY   
);

    reg [7:0]   rx_data     = 7'h0;
    reg         rx_valid    = 1'b0;
    reg         rx_last     = 1'b0;
    reg         d_rx_last   = 1'b0;
    
    reg [ 1:0] byte_counter         = 2'b0;
    reg [63:0] preamble_register    = 64'b0;
    
    reg has_preamble_found = 1'b0;
    
    reg d_phy_crs_dv = 1'b0;
    
    reg [31:0] crc_calc;
    reg [31:0] crc_calc_r;
    
    reg [31:0] crc_tx_calc;
    reg [31:0] crc_tx_calc_r;
    
    reg [31:0]  crc_ext;
    reg         has_last_assigned = 1'b0;
    
    reg [7:0]   rx_data_vector[0:16];
    reg [16:0]  rx_valid_vector;
    
    reg [7:0]   out_din_data;
    reg         out_din_last;
    reg         out_wren;
    reg         out_full;
    reg         out_awfull;
    
    reg phy_reset_sync;
    
    reg [7:0]   in_dout_data;
    reg         in_din_last;
    reg         in_rden;
    reg         in_empty;
    
    reg saved_in_dout_last;
    
    reg cmd_rden;
    reg cmd_empty;
    
    localparam IDLE         = 3'h0;
    localparam TX_PREAMBLE  = 3'h1;
    localparam TX_SFD       = 3'h2;
    localparam TX_DATA      = 3'h3;
    localparam TX_CRC       = 3'h4;
    
    reg current_state = IDLE;
    
    reg [7:0]   serializer_data;
    reg         serializer_valid;
    reg         serializer_ready;
    
    always @(posedge PHY_CLK) begin
        PHY_RST <= ~phy_reset_sync;
    end
    
    

endmodule
