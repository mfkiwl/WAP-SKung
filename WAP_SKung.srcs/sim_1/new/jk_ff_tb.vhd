----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/04/2018 03:43:56 PM
-- Design Name: 
-- Module Name: jk_ff_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity jk_ff_tb is
--  Port ( );
end jk_ff_tb;

architecture Behavioral of jk_ff_tb is
component jk_ff
port(
        clk, rst : in std_logic;
        j, k : in std_logic;
        q, q_bar : out std_logic
    );
end component;

constant cP     : time := 1 us;


signal sclk, srst : std_logic := '0'; 
signal sj, sk, sq, sqbar : std_logic := '0';

begin

UUT : jk_ff
port map(
        clk => sclk, 
        rst => srst,
        j => sj,
        k => sk,
        q => sq,
        q_bar => sqbar
);

srst <= '0', '1' after 1 us, '0' after 2 us;

--clk1 and clk2. same period but has phase difference
process
begin
  sclk <= '0';  
  wait for cP/2;   
  sclk <= '1';
  wait for cP/2;
end process;

process 
begin
  sj <= '0';
  sk <= '0';
  wait for cP;
  sj <= '0';
  sk <= '1';
  wait for cP;
  sj <= '1';
  sk <= '0';
  wait for cP;
  sj <= '1';
  sk <= '1';
  wait for cP;
  
  assert false
      report "End of tests"
        severity failure;

end process;
end Behavioral;
