----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2024 03:20:46 PM
-- Design Name: 
-- Module Name: prn_tb - Behavioral
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

entity prn_tb is
--  Port ( );
end prn_tb;

architecture Behavioral of prn_tb is
	
	
	Signal s_clk			: STD_LOGIC := '0';
	Signal s_clk_glonass	: STD_LOGIC := '0';
	Signal s_clk_baidu	: STD_LOGIC := '0';
	Signal s_prn_tdata 	: STD_LOGIC_VECTOR( 15 DOWNTO 0 ) := ( Others => '0' );
	Signal s_filtering 	: STD_LOGIC_VECTOR( 15 DOWNTO 0 ) := ( Others => '0' );
	Signal s_PRN		 	: STD_LOGIC_VECTOR( 15 DOWNTO 0 ) := ( Others => '0' );
	
	
begin

	Inst_GLONASS_LFSR : Entity Work.GLONASS_LFSR 
		Port Map 
			( 
				i_clk_glonass		=> s_clk_glonass,
				i_clk_gps			=> s_clk,
				i_reset 		    		=> '0',
				prn_glonass_i	    	=> open ,
				prn_glonass_q	    	=> open
			);
	
	-- Inst_baidu_gen : Entity Work.baidu_gen 
		-- PORT MAP 
			-- (
				-- i_Clk				=> s_clk,
				-- i_Reset 				=> '0',
				-- o_prn_tdata_i 		=> OPEN,
				-- o_prn_tdata_q 		=> OPEN
			-- );
	
	
	-- Inst_prn_spoof : Entity Work.prn_spoof 
		-- PORT MAP 
			-- (
				-- i_ADFS_clk		=> s_clk,
				-- i_Reset 			=> '0',
				-- o_dac1_i_tdata	=> s_PRN,
				-- o_dac1_q_tdata 	=> OPEN,
				-- o_dac2_i_tdata	=> OPEN,
				-- o_dac2_q_tdata 	=> OPEN
			-- );
	
	-- Inst_filtering : Entity Work.filtering 
		-- PORT MAP 
			-- (
				-- i_Clk				=> s_clk,
				-- i_Reset 				=> '0',
				-- i_prn_tdata 			=> s_PRN,
				-- i_filtering_tdata 	=> OPEN 
			-- );
	
	s_clk 			<= not s_clk after 8.145975887911372ns;
	s_clk_glonass	<= not s_clk_glonass after 16.30789302022179ns;
	s_clk_baidu		<= not s_clk_baidu after 16.845509829354986ns;





end Behavioral;
