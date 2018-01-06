library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity two_pe_dataflow is
    port(
        clk, rst   : in std_logic;
        clk1, clk2 : in std_logic;
        data_ready : in std_logic;
        data_enable : out std_logic;
        data_processed : in std_logic;
        data       : in std_logic_vector(7 downto 0);
        result_out : out std_logic_vector(7 downto 0)
    );
end two_pe_dataflow;

architecture Behavioral of two_pe_dataflow is

component handshake_send
    port(
        clk, rst            :   in std_logic;
        data_ready          :   in std_logic;
        data_used           :   in std_logic;
        data_enable         :   out std_logic;
        data_sent           :   out std_logic
    );
end component;

component handshake_rec
    port(
        clk, rst            :   in std_logic;
        data_received       :   in std_logic;
        data_processed      :   in std_logic;
        data_used           :   out std_logic;
        data_available      :   out std_logic
    );
end component;

signal sdata_used : std_logic;
signal sdata_sent : std_logic;
signal sdata_available : std_logic;

begin

    process(clk)
    begin
        if rising_edge(clk) and sdata_available = '1' then
            result_out <= data;
        end if;
    end process;

    send : handshake_send
    port map(
        clk => clk1, 
        rst => rst,
        data_ready => data_ready,
        data_used => sdata_used,
        data_enable => data_enable,
        data_sent => sdata_sent
    );

    receive : handshake_rec
    port map(
        clk => clk2, 
        rst => rst,
        data_received => sdata_sent,
        data_processed => data_processed,
        data_used => sdata_used,
        data_available => sdata_available
    );


end Behavioral;
