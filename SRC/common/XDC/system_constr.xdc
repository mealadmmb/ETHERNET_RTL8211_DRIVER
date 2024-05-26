set_property  -dict {PACKAGE_PIN  B19   IOSTANDARD  LVCMOS25} [get_ports  MDIO_PHY_mdc]       ;
set_property  -dict {PACKAGE_PIN  A20   IOSTANDARD  LVCMOS25} [get_ports  MDIO_PHY_mdio_io]   ;

set_property  -dict {PACKAGE_PIN  E19   IOSTANDARD  LVCMOS25} [get_ports  RGMII_tx_ctl] ;
set_property  -dict {PACKAGE_PIN  F17   IOSTANDARD  LVCMOS25} [get_ports  RGMII_txc]    ; 
set_property  -dict {PACKAGE_PIN  D18   IOSTANDARD  LVCMOS25} [get_ports  RGMII_td[0]]  ;
set_property  -dict {PACKAGE_PIN  D19   IOSTANDARD  LVCMOS25} [get_ports  RGMII_td[1]]  ;
set_property  -dict {PACKAGE_PIN  D20   IOSTANDARD  LVCMOS25} [get_ports  RGMII_td[2]]  ;
set_property  -dict {PACKAGE_PIN  E18   IOSTANDARD  LVCMOS25} [get_ports  RGMII_td[3]]  ;

set_property  -dict {PACKAGE_PIN  M17   IOSTANDARD  LVCMOS25} [get_ports  RGMII_rx_ctl] ;
set_property  -dict {PACKAGE_PIN  H16   IOSTANDARD  LVCMOS25} [get_ports  RGMII_rxc]    ;
set_property  -dict {PACKAGE_PIN  L20   IOSTANDARD  LVCMOS25} [get_ports  RGMII_rd[0]]  ;
set_property  -dict {PACKAGE_PIN  L19   IOSTANDARD  LVCMOS25} [get_ports  RGMII_rd[1]]  ;
set_property  -dict {PACKAGE_PIN  M19   IOSTANDARD  LVCMOS25} [get_ports  RGMII_rd[2]]  ;
set_property  -dict {PACKAGE_PIN  M20   IOSTANDARD  LVCMOS25} [get_ports  RGMII_rd[3]]  ;

create_clock -period 8.000 -name RGMII_rxc -waveform {0.000 4.000} [get_ports RGMII_rxc]

set_property SLEW FAST [get_ports  RGMII_tx_ctl]
set_property SLEW FAST [get_ports  RGMII_txc]
set_property SLEW FAST [get_ports {RGMII_td[*]}]
# constraints
# ad9361

set_property  -dict {PACKAGE_PIN  N18  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_clk_in_p]       ; 
set_property  -dict {PACKAGE_PIN  P19  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_clk_in_n]       ; 
set_property  -dict {PACKAGE_PIN  R16  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_frame_in_p]     ; 
set_property  -dict {PACKAGE_PIN  R17  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_frame_in_n]     ; 
set_property  -dict {PACKAGE_PIN  V17  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[0]]   ; 
set_property  -dict {PACKAGE_PIN  V18  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[0]]   ; 
set_property  -dict {PACKAGE_PIN  Y18  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[1]]   ; 
set_property  -dict {PACKAGE_PIN  Y19  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[1]]   ; 
set_property  -dict {PACKAGE_PIN  T17  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[2]]   ; 
set_property  -dict {PACKAGE_PIN  R18  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[2]]   ; 
set_property  -dict {PACKAGE_PIN  V20  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[3]]   ; 
set_property  -dict {PACKAGE_PIN  W20  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[3]]   ; 
set_property  -dict {PACKAGE_PIN  T20  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[4]]   ; 
set_property  -dict {PACKAGE_PIN  U20  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[4]]   ; 
set_property  -dict {PACKAGE_PIN  V16  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_p[5]]   ; 
set_property  -dict {PACKAGE_PIN  W16  IOSTANDARD LVDS_25   DIFF_TERM TRUE} [get_ports rx_data_in_n[5]]   ; 

set_property  -dict {PACKAGE_PIN  U14  IOSTANDARD LVDS_25}  [get_ports tx_clk_out_p]                      ; 
set_property  -dict {PACKAGE_PIN  U15  IOSTANDARD LVDS_25}  [get_ports tx_clk_out_n]                      ; 
set_property  -dict {PACKAGE_PIN  V15  IOSTANDARD LVDS_25}  [get_ports tx_frame_out_p]                    ; 
set_property  -dict {PACKAGE_PIN  W15  IOSTANDARD LVDS_25}  [get_ports tx_frame_out_n]                    ; 
set_property  -dict {PACKAGE_PIN  P14  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[0]]                  ; 
set_property  -dict {PACKAGE_PIN  R14  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[0]]                  ; 
set_property  -dict {PACKAGE_PIN  V12  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[1]]                  ; 
set_property  -dict {PACKAGE_PIN  W13  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[1]]                  ; 
set_property  -dict {PACKAGE_PIN  W14  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[2]]                  ; 
set_property  -dict {PACKAGE_PIN  Y14  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[2]]                  ; 
set_property  -dict {PACKAGE_PIN  T14  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[3]]                  ; 
set_property  -dict {PACKAGE_PIN  T15  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[3]]                  ; 
set_property  -dict {PACKAGE_PIN  Y16  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[4]]                  ; 
set_property  -dict {PACKAGE_PIN  Y17  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[4]]                  ; 
set_property  -dict {PACKAGE_PIN  T16  IOSTANDARD LVDS_25}  [get_ports tx_data_out_p[5]]                  ; 
set_property  -dict {PACKAGE_PIN  U17  IOSTANDARD LVDS_25}  [get_ports tx_data_out_n[5]]                  ; 

set_property  -dict {PACKAGE_PIN  U7  IOSTANDARD LVCMOS25} [get_ports gpio_status[0]]                    ; 
set_property  -dict {PACKAGE_PIN  V7  IOSTANDARD LVCMOS25} [get_ports gpio_status[1]]                    ; 
set_property  -dict {PACKAGE_PIN  T9  IOSTANDARD LVCMOS25} [get_ports gpio_status[2]]                    ; 
set_property  -dict {PACKAGE_PIN  U10 IOSTANDARD LVCMOS25} [get_ports gpio_status[3]]                    ; 
set_property  -dict {PACKAGE_PIN  Y7  IOSTANDARD LVCMOS25} [get_ports gpio_status[4]]                    ; 
set_property  -dict {PACKAGE_PIN  Y6  IOSTANDARD LVCMOS25} [get_ports gpio_status[5]]                    ; 
set_property  -dict {PACKAGE_PIN  Y9  IOSTANDARD LVCMOS25} [get_ports gpio_status[6]]                    ; 
set_property  -dict {PACKAGE_PIN  Y8  IOSTANDARD LVCMOS25} [get_ports gpio_status[7]]                    ; 
set_property  -dict {PACKAGE_PIN  V8  IOSTANDARD LVCMOS25} [get_ports gpio_ctl[0]]                       ; 
set_property  -dict {PACKAGE_PIN  W8  IOSTANDARD LVCMOS25} [get_ports gpio_ctl[1]]                       ; 
set_property  -dict {PACKAGE_PIN  W10 IOSTANDARD LVCMOS25} [get_ports gpio_ctl[2]]                       ; 
set_property  -dict {PACKAGE_PIN  W9  IOSTANDARD LVCMOS25} [get_ports gpio_ctl[3]]                       ; 


set_property  -dict {PACKAGE_PIN  W19  IOSTANDARD LVCMOS25} [get_ports gpio_resetb]                       ; 
set_property  -dict {PACKAGE_PIN  N17  IOSTANDARD LVCMOS25} [get_ports enable]                            ; 
set_property  -dict {PACKAGE_PIN  P18  IOSTANDARD LVCMOS25} [get_ports gpio_en_agc]                       ; 
set_property  -dict {PACKAGE_PIN  P15  IOSTANDARD LVCMOS25} [get_ports gpio_sync]                         ; 
set_property  -dict {PACKAGE_PIN  P16  IOSTANDARD LVCMOS25} [get_ports txnrx]                             ; 



set_property  -dict {PACKAGE_PIN  T10  IOSTANDARD LVCMOS25  PULLTYPE PULLUP} [get_ports spi_csn]          ; 
set_property  -dict {PACKAGE_PIN  T11  IOSTANDARD LVCMOS25} [get_ports spi_clk]                           ; 
set_property  -dict {PACKAGE_PIN  T12  IOSTANDARD LVCMOS25} [get_ports spi_mosi]                          ; 
set_property  -dict {PACKAGE_PIN  U12  IOSTANDARD LVCMOS25} [get_ports spi_miso]                          ; 

set_property  -dict {PACKAGE_PIN  N20  IOSTANDARD LVCMOS25} [get_ports clkout_in]                         ; 

set_property  -dict {PACKAGE_PIN  U8    IOSTANDARD LVCMOS25} [get_ports TRX1_nTX_RX]                        ; 
set_property  -dict {PACKAGE_PIN  W11   IOSTANDARD LVCMOS25} [get_ports RX1_TRX_nRX]                        ; 
set_property  -dict {PACKAGE_PIN  T5    IOSTANDARD LVCMOS25} [get_ports RX2_nTRX_RX]                        ; 
set_property  -dict {PACKAGE_PIN  V6    IOSTANDARD LVCMOS25} [get_ports TRX2_TX_nRX]                        ; 

# spi pmod JA1

set_property  -dict {PACKAGE_PIN  Y12   IOSTANDARD LVCMOS25}     [get_ports spi_udc_csn_tx]             ; 
set_property  -dict {PACKAGE_PIN  Y13    IOSTANDARD LVCMOS25}     [get_ports spi_udc_csn_rx]             ; 
set_property  -dict {PACKAGE_PIN  V11   IOSTANDARD LVCMOS25}     [get_ports spi_udc_sclk]               ; 
set_property  -dict {PACKAGE_PIN  V10   IOSTANDARD LVCMOS25}     [get_ports spi_udc_data]               ; 

set_property  -dict {PACKAGE_PIN  K14    IOSTANDARD LVCMOS25}     [get_ports gpio_muxout_tx]             ; 
set_property  -dict {PACKAGE_PIN  J14    IOSTANDARD LVCMOS25}     [get_ports gpio_muxout_rx]             ; 

# clocks

create_clock -name rx_clk       -period  4 [get_ports rx_clk_in_p]


#====================GPS singlas loop back==========================
set_property  -dict {PACKAGE_PIN  G17  IOSTANDARD LVCMOS25} [get_ports nrst]                              ; 
set_property  -dict {PACKAGE_PIN  G18  IOSTANDARD LVCMOS25} [get_ports GPS_rx]                            ; 
set_property  -dict {PACKAGE_PIN  j20  IOSTANDARD LVCMOS25} [get_ports GPS_tx]                            ; 
set_property  -dict {PACKAGE_PIN  F19  IOSTANDARD LVCMOS25} [get_ports GPS_rx_loop_back]                  ; 
set_property  -dict {PACKAGE_PIN  F20  IOSTANDARD LVCMOS25} [get_ports GPS_tx_loop_back]                  ; 
set_property  -dict {PACKAGE_PIN  F16  IOSTANDARD LVCMOS25} [get_ports os_output]                  ; 






