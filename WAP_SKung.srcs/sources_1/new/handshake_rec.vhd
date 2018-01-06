library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity handshake_rec is
    port(
        clk, rst            :   in std_logic;
        data_received       :   in std_logic;
        data_processed      :   in std_logic;
        data_used           :   out std_logic;
        data_available      :   out std_logic
    );
end handshake_rec;

architecture Behavioral of handshake_rec is

component jk_ff
    port(
        clk, rst : in std_logic;
        j, k : in std_logic;
        q, q_bar : out std_logic
    );
end component;

-- J-K Flip-Flop signals
signal s_q : std_logic := '0';
signal s_qbar : std_logic := '0';
signal s_j : std_logic;
signal s_k : std_logic;
signal ds2 : std_logic;

-- D Flip-Flop signals
signal s_d, s_qb : std_logic;

begin
    s_d <= data_received;
    ds2 <= data_received and s_qb;

    -- D Flip Flop
    process(clk, rst)
    begin
        if rst = '1' then
            s_qb <= '1';
        elsif falling_edge(clk) then
            s_qb <= s_d;
        end if;
    end process;

    jk_ff_inst : jk_ff
    port map(
        clk => clk,
        rst => rst,
        j => ds2,
        k => data_processed,
        q => data_available,
        q_bar => data_used
    );


end Behavioral;
