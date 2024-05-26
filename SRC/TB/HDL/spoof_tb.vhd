----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2024 03:11:14 AM
-- Design Name: 
-- Module Name: spoof_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spoof_tb is
--  Port ( );
end spoof_tb;

architecture Behavioral of spoof_tb is

-- ======================================================================================
-- SIGNAL DECLERATION 
-- ======================================================================================
	
	-- Inst_prn_spoof
		Signal s_ADFS_clk			: STD_LOGIC := '0';
	
begin

	Inst_prn_spoof : Entity Work.prn_spoof 
		PORT MAP 
			(
				i_ADFS_clk		=> s_ADFS_clk,
				i_Reset 			=> '0'		,
				o_dac1_i_tdata	=> OPEN		, 
				o_dac1_q_tdata 	=> OPEN		,
				o_dac2_i_tdata	=> OPEN		,
				o_dac2_q_tdata 	=> OPEN
			);
	
	
		s_ADFS_clk <= NOT s_ADFS_clk AFTER 8.145975887911372ns;
	

end Behavioral;
