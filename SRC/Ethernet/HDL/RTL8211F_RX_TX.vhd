----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/15/2024 04:10:13 PM
-- Design Name: 
-- Module Name: RTL8211F_RX_TX - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RTL8211F_RX_TX is
    Port ( TXC          : out STD_LOGIC;
           TXD          : out STD_LOGIC_VECTOR (3 downto 0);
           TXCTL        : out STD_LOGIC;
           RXC          : in STD_LOGIC;
           RXD          : in STD_LOGIC_VECTOR (3 downto 0);
           RXCTL        : in STD_LOGIC;
           TXD_BYTE     : out STD_LOGIC_VECTOR (7 downto 0);
           RXD_BYTE     : out STD_LOGIC_VECTOR (7 downto 0);
           RXD_VALID    : out STD_LOGIC;
           O_RX_Clk     : OUT STD_LOGIC
           );  
end RTL8211F_RX_TX;

architecture Behavioral of RTL8211F_RX_TX is
SIGNAL S_RXD        :   STD_LOGIC_VECTOR (7 downto 0);
SIGNAL S_REG_RXD    :   STD_LOGIC_VECTOR (7 downto 0);
SIGNAL S_REG_RXDV   :   STD_LOGIC;
SIGNAL S_BUF_RXC    :   STD_LOGIC;
--SIGNAL S_BUF_RXC_90:   STD_LOGIC;

begin

--BUFG_inst : BUFG
--   port map 
--   (
--      O => S_BUF_RXC, -- 1-bit output: Clock output
--      I => RXC  -- 1-bit input: Clock input
--   );
   

IBUF_inst : IBUF
   generic map (
      IBUF_LOW_PWR => False, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD => "DEFAULT")
   port map (
      O => RXD_VALID,     -- Buffer output
      I => RXCTL      -- Buffer input (connect directly to top-level port)
   );  
 
  instance_name : Entity work.clk_wiz_1 
   port map 
   (

    clk_out1 => S_BUF_RXC,
    clk_in1 => RXC
    );    
 
   
   
input_buffer_loop : FOR I IN 0 TO 3 GENERATE 
begin
IDDR_inst : IDDR 
   generic map (
      DDR_CLK_EDGE => "OPPOSITE_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE" 
                                       -- or "SAME_EDGE_PIPELINED" 
      INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
      INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
      SRTYPE => "SYNC") -- Set/Reset type: "SYNC" or "ASYNC" 
   port map (
      Q1 => S_RXD(I), -- 1-bit output for positive edge of clock 
      Q2 => S_RXD(I + 4), -- 1-bit output for negative edge of clock
      C  => S_BUF_RXC,   -- 1-bit clock input
      CE => '1', -- 1-bit clock enable input
      D  => RXD(I),   -- 1-bit DDR data input
      R  => '0',   -- 1-bit reset
      S  => '0'    -- 1-bit set
      );
END GENERATE input_buffer_loop;




INPUT_REGISTER_PROCESS: process(S_BUF_RXC)   
 BEGIN
 if     rising_edge(S_BUF_RXC)    then

        S_REG_RXD   <=  S_RXD;
        S_REG_RXDV  <=  RXCTL;
 end if;
 END PROCESS INPUT_REGISTER_PROCESS;
 
 --=========================================================
 --                     Assignment to output
 --=========================================================
 RXD_BYTE    <=  S_REG_RXD;    
 O_RX_Clk    <= S_BUF_RXC; 

end Behavioral;
