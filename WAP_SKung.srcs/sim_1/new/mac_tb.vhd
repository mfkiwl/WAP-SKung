library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mac_tb is
end mac_tb;

architecture Behavioral of mac_tb is

component mac
generic(n: natural);
port(
        clk, rst                                : in std_logic;
        left_in, top_in                         : in std_logic_vector(n-1 downto 0);
        bottom_out, right_out, result_out       : out std_logic_vector(n-1 downto 0)
);
end component;

constant cP     : time := 1 us;

signal sclk, srst : std_logic := '0'; 
signal sleft_in, stop_in : std_logic_vector(7 downto 0) := (others => '0');
signal sbottom_out, sright_out, sresult_out : std_logic_vector(7 downto 0);

begin

UUT : mac
generic map (n => 8)
port map(
      clk => sclk,
      rst => srst,
      left_in => sleft_in,
      top_in => stop_in,
      bottom_out => sbottom_out,
      right_out => sright_out,
      result_out => sresult_out
);

srst <= '0', '1' after 1 us, '0' after 2 us;

process 
begin 
  sclk  <= '1';
  sleft_in <= "00000010";
  stop_in <= "00000010"; 
  
  wait for 100 ns; 
    
  sclk <= '0';   
  wait for cP/2;   
  sclk <= '1';   
  wait for cP/2;

  assert false
      report "End of tests"
        severity failure;

end process;


end Behavioral;
