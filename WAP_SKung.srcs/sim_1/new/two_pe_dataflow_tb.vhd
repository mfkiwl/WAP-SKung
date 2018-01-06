library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity two_pe_dataflow_tb is
end two_pe_dataflow_tb;

architecture Behavioral of two_pe_dataflow_tb is

component two_pe_dataflow
port(
        clk, rst   : in std_logic;
        clk1, clk2 : in std_logic;
        data_ready : in std_logic;
        data_enable : out std_logic;
        data_processed : in std_logic;
        data       : in std_logic_vector(7 downto 0);
        result_out : out std_logic_vector(7 downto 0)
    );
end component;

constant cP     : time := 1 us;
constant cP1     : time := 0.5 us;
constant cP2     : time := 0.5 us;


signal sclk, sclk1, sclk2, srst : std_logic := '0'; 
signal sdata_ready, sdata_processed : std_logic;
signal sdata_enable : std_logic;
signal sdata : std_logic_vector(7 downto 0) := (others => '0');
signal sresult_out : std_logic_vector(7 downto 0);

begin

UUT : two_pe_dataflow
port map(
        clk => sclk, 
        rst => srst,
        clk1 => sclk1,
        clk2 => sclk2,
        data_ready => sdata_ready,
        data_enable => sdata_enable,
        data_processed => sdata_processed,
        data => sdata,
        result_out => sresult_out
);


process
begin
  sclk1 <= '0'; 
  sclk2 <= '0' after cP1/4;   
  wait for cP1/2;   
  sclk1 <= '1'; 
  sclk2 <= '1' after cP1/4;  
  wait for cP1/2;
end process;

process
begin
  sclk <= '0';   
  wait for cP/2;   
  sclk <= '1';   
  wait for cP/2;
end process;

process(sclk1, sdata_enable)
begin
  if sdata_enable = '1' and falling_edge(sclk1) then
    -- PE1 says data is ready
    sdata_ready <= '1';
    
  elsif rising_edge(sclk1) then
    NULL;
  else
    sdata_ready <= '0';
  end if;

end process;

process 
begin
  srst <= '0', '1' after 1 us, '0' after 1.25 us;
  --clk1 and clk2. same period but has phase difference
  -- PE1 does some work
  sdata <= "00000010";
  
  wait for 5 us;
  -- PE2 processes data  and sends acknowledgment to PE1
  sdata_processed <= '0', '1' after 1.5 us, '0' after 2 us;
  
  assert false
      report "End of tests"
        severity failure;

end process;
end Behavioral;
