----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/29/2024 07:19:36 PM
-- Design Name: 
-- Module Name: RTL8211_F_Serial_manger - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RTL8211_F_Serial_manger is
    Port ( mdio                  : inout STD_LOGIC;
           mdc                   : out   STD_LOGIC;
           rd_tvalid             : out   STD_LOGIC;
           rd_tdata              : out   STD_LOGIC_vector(15 downto 0);
           tcntr                 : out   STD_LOGIC_vector(15 downto 0);
           i_clk                 : in    STD_LOGIC;
           reset                 : in    STD_LOGIC;
           rdwr                  : in    STD_LOGIC;
           taddr                 : in    STD_LOGIC_VECTOR( 4 downto 0);
           value                 : in    STD_LOGIC_VECTOR( 15 downto 0);
           start                 : in    STD_LOGIC
           );
end RTL8211_F_Serial_manger;

architecture Behavioral of RTL8211_F_Serial_manger is
-- ====================================================================================
-- SIGNAL DECLERATION for controling the serial managment state machine and the register addresses and it's values
-- ====================================================================================
type controller_State is (wait_20ms_1,write, wait_20ms_2,read, wait_unitl_death );
signal control_State : controller_State := wait_20ms_1;
signal wait_counter_to_start            : unsigned(31 downto 0)         :=(others=>'0');
--signal start                            : STD_LOGIC                     :='1';
--signal rdwr                             : STD_LOGIC                     :='0';
--signal address                          : STD_LOGIC_VECTOR(4 downto 0)  :="00000";
--signal value                            : STD_LOGIC_VECTOR(15 downto 0) ;
--type addresses is array (0 to 3) of STD_LOGIC_VECTOR(4 downto 0);
--signal s_address: addresses:=(X"00",X"1f",X"11",X"15");
--signal s_address: addresses:=("00000","11111","10001","10101");
--type VALUES is array (0 to 3) of STD_LOGIC_VECTOR(15 downto 0);
--signal s_value: VALUES:=(X"0000",X"001f",X"0011",X"0015");
-- ====================================================================================
-- General SIGNAL DECLERATION for buffer and register the inputs
-- ====================================================================================
signal S_I,S_O,S_T                    : STD_LOGIC;
signal s_reg_reset                    : STD_LOGIC;
signal s_reg_start                    : STD_LOGIC;
signal s_reg_rdwr                     : STD_LOGIC;
signal s_reg_addr                     : STD_LOGIC_vector(4 downto 0);
signal s_reg_value                    : STD_LOGIC_vector(15 downto 0);
signal s_reg_rd_tdata                 : STD_LOGIC_VECTOR(15 downto 0);



-- ====================================================================================
-- TYPE AND CONSTANT DECLERATION  and state machines signals
-- ====================================================================================

type t_State is (idle,start_frame, read_op_code, phy_address, reg_address,turn_around, reg_data );
signal State : t_State :=idle;


signal s_start_frame_cs : integer range  0 to 1; 
signal read_op_code_cs  : integer range  0 to 1; 
signal phy_address_cs   : integer range  0 to 4; 
signal reg_address_cs   : integer range  0 to 4; 
signal turn_around_cs   : integer range  0 to 3; 
signal reg_data_cs      : integer range  0 to 15; 

-- ====================================================================================
-- SIGNAL DECLERATION FOR BUFFER
-- ====================================================================================
signal S_I_buffer       : STD_LOGIC;
signal S_O_buffer       : STD_LOGIC;
signal S_T_buffer       : STD_LOGIC;
signal S_inout_buffer   : STD_LOGIC;

begin



-- ====================================================================================
-- Input register
-- ====================================================================================
input_register_process: process(i_clk) IS
begin
    if rising_edge(i_clk)   then
     s_reg_reset   <= reset ;
     s_reg_rdwr    <= rdwr  ;
     s_reg_addr    <= taddr  ;
     s_reg_value   <= value ;
     s_reg_start   <= start ;
    end if;
end process input_register_process;    
 




-- =========================================================================================================
-- Control the Serial managment(RTL8211_F Serial protocol) State machine to write the desired register value
-- I only have to write the first Register( BMCR (Basic Mode Control Register, Address 0x00) )
--    15th      14th     13th                   12th                11th    10th        9th         8th
-- --------------------------------------------------------------------------------------------------------
-- | Reset  |Loopback | Speed[0] |  ANE(Auto nogotiation Enable)  | PWD | Isolate   | Restart_AN  | Duplex |    
-- --------------------------------------------------------------------------------------------------------
--        7th           6th                     5th                   4th          3th   2th  1th    0th
-- ------------------------------------------------------------------------------------------------------
-- | Collision Test  | Speed[1]   |        Uni-directional        |  Reserve(RSV)| RSV | RSV | RSV | RSV |     
-- ------------------------------------------------------------------------------------------------------
-- We have to write 0x0140 into address 0x00 -----> 1000 Mbit/s, Full duplex, diable auto negotiation
-- =========================================================================================================
--rd_tdata   <=  s_reg_rd_tdata ;
--process(i_clk)
--    begin
--        if rising_edge(i_clk) then
--            case control_State  is
--                when    wait_20ms_1 =>
--                   if (wait_counter_to_start    < 100000 - 1)  then   --clk is 5MHz if it waits 1'000'000 clk it waits for 20ms.
--                        wait_counter_to_start    <=  wait_counter_to_start+1;
--                    else
--                        wait_counter_to_start    <=  to_unsigned(0,32);
--                        control_State            <=  write;
--                        address                  <= s_address(1);    -- Prepare to write
--                   end if;
                   
--                 when   write   =>
--                        control_State            <= wait_20ms_2;
                        
--                 when   wait_20ms_2   =>
--                    if (wait_counter_to_start    < 100000)  then   --clk is 5MHz if it waits 1000'000 clk it waits for 20ms.
--                        wait_counter_to_start    <=  wait_counter_to_start+1;
--                    else
--                        wait_counter_to_start    <=  to_unsigned(0,32);
--                        control_State            <= read;
--                        rdwr                     <= '1';        -- Prepare to read
--                        address                  <= s_address(2);    -- Prepare to read
--                        start                    <= '0';
--                    end if;
                    
--                 when   read   =>
--                        start                    <= '1';
--                        control_State            <= wait_unitl_death;
                        
                                       
--                 when   wait_unitl_death         => 
--                        Null;
                        
--                 when others    =>
--                        Null;
--            end case;    
--        end if;

--end process;











-- ====================================================================================
-- IOBUF declaration instead of using IOBUF PRIMITIVE
-- ====================================================================================
   S_O_buffer       <=   S_inout_buffer;
   S_inout_buffer   <=   'Z' when S_T_buffer='1' else  S_I_buffer  ;

   S_O_buffer       <=   S_O ;
   S_inout_buffer   <=   mdio;
   S_I_buffer       <=   S_I;
   S_T_buffer       <=   S_T;

      
      
--   IOBUF_inst : IOBUF
--   generic map (
--      DRIVE => 12,
--      IOSTANDARD => "LVCMOS25",
--      SLEW => "SLOW")
--   port map (
--      O => S_O,     -- Buffer output
--      IO => mdio,   -- Buffer inout port (connect directly to top-level port)
--      I => S_I,     -- Buffer input
--      T => S_T      -- 3-state enable input, high=input, low=output 
--   );
   
   mdc    <=  not i_clk;
   
 
   rd_tdata <= s_reg_rd_tdata;
--=====================================================
-- Starting the Serial mangment State Machine
--=====================================================   
process(i_clk)
    begin
        if rising_edge(i_clk) then
            case state is
            when idle               =>
                if (s_reg_start='0' and start='1') then
                     state         <=   start_frame;
                     tcntr <=   x"0000";
                else
                    rd_tvalid               <= '0';
                    S_T                     <= '0';--== making the MDIO In write mode
                    S_I                     <= '1';--== Pull up MDIO for 32 clock (according to datasheet)
                    state                   <= idle;
                    s_start_frame_cs        <= 0 ;
                    read_op_code_cs         <= 0 ;
                    phy_address_cs          <= 0 ;
                    reg_address_cs          <= 0 ;
                    turn_around_cs          <= 0 ;
                    reg_data_cs             <= 0 ;
                    tcntr                   <= x"0001";
                                        
                end if;
                
            when start_frame    =>
                     tcntr           <= x"0002";
                     case s_start_frame_cs is       ----------Sending 2B"01"
                     when 0 =>  
                        S_I                   <= '0';  ---send 0
                        S_T                   <= '0';
                        s_start_frame_cs      <=  1 ;
                     when 1 =>
                        S_I                   <= '1';  ---send 1  
                        state                 <=  read_op_code;
                     when others => 
							NULL;
					 end case;
					 
					 
            when read_op_code   =>
                tcntr           <= x"0003";
                if s_reg_rdwr='1' then              ----check if it is read mode or write mode
                     case read_op_code_cs is
                     when 0 =>  
                        S_I                 <= '1'; ----Send 1
                        read_op_code_cs     <=  1;
                        
                     when 1 =>
                        S_I                 <= '0';  ----Send 0
                        state               <=  phy_address;
                        
                     when others =>
                        NULL;
                     end case;
                else
                    case read_op_code_cs is
                     when 0 =>  
                      S_I                   <= '0';  ----Send 0
                      read_op_code_cs       <=  1;
                        
                     when 1 =>
                      S_I                   <= '1';  ----Send 1
                        state               <=  phy_address; 
                        
                     when others    =>
                        NULL;
                     end case; 
                end if;
                
            when phy_address    =>      ------send register address that user fed into into this component
                    tcntr           <= x"0004";
                    case phy_address_cs is
                     when 0 =>  
                       S_I                   <= '0';  ----Send 0
                         phy_address_cs      <=  1;
                         
                     when 1 =>
                       S_I                   <= '0';  ----Send 0
                         phy_address_cs      <=  2;
                         
                     when 2 =>
                       S_I                   <= '0';  ----Send 0
                         phy_address_cs      <=  3;
                         
                     when 3 =>
                       S_I                   <= '0';  ----Send 0
                         phy_address_cs      <=  4;
                         
                     when 4 =>
                       S_I                   <= '1';  ----Send 1
                         state               <=  reg_address;  
                     when others    =>
                        NULL;
                     end case;
            when reg_address    =>      ------send register address that user fed into into this component
                    tcntr           <= x"0005";
                    case reg_address_cs is
                     when 0 =>  
                         S_I                   <= s_reg_addr(4);  ----Send address(4)
                         reg_address_cs        <=  1;
                         
                     when 1 =>
                         S_I                   <= s_reg_addr(3);  ----Send address(3)
                         reg_address_cs        <=  2;
                         
                     when 2 =>
                         S_I                   <= s_reg_addr(2);  ----Send address(2)
                         reg_address_cs        <=  3;
                         
                     when 3 =>
                         S_I                   <= s_reg_addr(1);  ----Send address(1)
                         reg_address_cs        <=  4;
                         
                     when 4 =>
                       S_I                     <= s_reg_addr(0);  ----Send address(0)
                         state                 <=  turn_around;  
                     when others    =>
                        NULL;
                     end case;
                     
            when turn_around    =>
                  tcntr           <= x"0006";
                  if s_reg_rdwr='1' then              --====Read mode Turn around operation
                     case turn_around_cs is
                     when 0 =>  
                      S_T                   <= '1';   --====making tristate to read data from mdio
                      turn_around_cs        <=  1;
                        
                     when 1 =>                        --==== Wait one clock according to datasheet timing Diagram
                        state               <=  reg_data;
            
                     when others =>
                        NULL;
                     end case;
                  else                                --====Write mode Turn around operation
                   case turn_around_cs is
                     when 0 =>
                      S_I                   <= '1';   --====Send 1  
                      S_T                   <= '0';   --====making tristate to read data from mdio
                        turn_around_cs      <=  1;
                        
                     when 1 =>                        --==== Wait one clock according to datasheet timing Diagram
                      S_I                   <= '0';   --====Send 0 
                      state                 <=  reg_data;
            
                     when others =>
                        NULL;
                     end case;
                  end if;
                  
            when reg_data =>    ---s_reg_rd_tdata
                    
                  if s_reg_rdwr='1' then              --====Read mode reg_data operation
                     tcntr           <= x"0007";
                     case reg_data_cs is
                     when 0 =>  
                        S_T                      <= '1';   --====Read the MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs              <=  1;
                        s_reg_rd_tdata(15)      <=  S_O;
                     when 1 =>                        --==== Read the 2th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  2;
                        s_reg_rd_tdata(14)      <=  S_O;
                     when 2 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  3;
                        s_reg_rd_tdata(13)      <=  S_O;
                     when 3 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  4;
                        s_reg_rd_tdata(12)      <=  S_O;
                     when 4 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  5;
                        s_reg_rd_tdata(11)      <=  S_O;
                     when 5 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  6;
                        s_reg_rd_tdata(10)      <=  S_O;
                     when 6 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  7;
                        s_reg_rd_tdata(9)       <=  S_O;
                     when 7 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  8;
                        s_reg_rd_tdata(8)       <=  S_O;
                     when 8 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  9;
                        s_reg_rd_tdata(7)       <=  S_O;
                     when 9 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  10;
                        s_reg_rd_tdata(6)       <=  S_O;
                     when 10 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  11;
                        s_reg_rd_tdata(5)       <=  S_O;
                     when 11 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  12;
                        s_reg_rd_tdata(4)       <=  S_O;
                     when 12 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  13;
                        s_reg_rd_tdata(3)       <=  S_O;
                     when 13 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  14;
                        s_reg_rd_tdata(2)       <=  S_O;
                     when 14 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        reg_data_cs             <=  15;
                        s_reg_rd_tdata(1)       <=  S_O;
                     when 15 =>                        --==== Read the 3th MSB bit of the register into  s_reg_rd_tdata signal
                        s_reg_rd_tdata(0)       <=  S_O;
                        tcntr                   <= x"0009";
                        rd_tvalid               <= '1'; 
                        state                   <=  idle;              
                     when others =>
                        NULL;
                     end case;
                  else                                --====Write mode Turn around operation
                  tcntr           <= x"0008";
                   case reg_data_cs is
                     when 0 =>
                        S_I                 <= s_reg_value(15);   --====Send MSB of the data that user fed in  
                        S_T                   <= '0';   --====disable tri state to write
                        reg_data_cs         <=  1;
                     when 1 =>
                        S_I                 <= s_reg_value(14);    
                        reg_data_cs         <=  2;
                     when 2 =>
                        S_I                 <= s_reg_value(13);     
                        reg_data_cs         <=  3;
                     when 3 =>
                        S_I                 <= s_reg_value(12);   
                        reg_data_cs         <=  4;
                     when 4 =>
                        S_I                 <= s_reg_value(11);     
                        reg_data_cs         <=  5;
                     when 5 =>
                        S_I                 <= s_reg_value(10);   
                        reg_data_cs         <=  6;
                     when 6 =>
                        S_I                 <= s_reg_value(9);   
                        reg_data_cs         <=  7;
                     when 7 =>
                        S_I                 <= s_reg_value(8);  
                        reg_data_cs         <=  8;
                     when 8 =>
                        S_I                 <= s_reg_value(7);   
                        reg_data_cs         <=  9;
                     when 9 =>
                        S_I                 <= s_reg_value(6);   
                        reg_data_cs         <=  10;
                     when 10 =>
                        S_I                 <= s_reg_value(5);   
                        reg_data_cs         <=  11;
                     when 11 =>
                        S_I                 <= s_reg_value(4);      
                        reg_data_cs         <=  12;
                     when 12 =>
                        S_I                 <= s_reg_value(3);   
                        reg_data_cs         <=  13;
                     when 13 =>
                        S_I                 <= s_reg_value(2);   
                        reg_data_cs         <=  14;
                     when 14 =>
                        S_I                 <= s_reg_value(1);   
                        reg_data_cs         <=  15;
                     when 15 =>                        
                        S_I                 <= s_reg_value(0);  
                        state               <=  idle;
                     when others =>
                        NULL;
                     end case;
                  end if; 
            when others => 
							NULL;
            end case;
        
        end if;
    end process;

end Behavioral;
