library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity handshake_send is
    port(
        clk, rst            :   in std_logic;
        data_ready          :   in std_logic;
        data_used           :   in std_logic;
        data_enable         :   out std_logic;
        data_sent           :   out std_logic
    );
end handshake_send;

architecture Behavioral of handshake_send is

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
signal du1 : std_logic;

-- D Flip-Flop signals
signal s_d, s_qa : std_logic;

begin
    s_d <= data_used;
    du1 <= data_used and s_qa;
    -- D Flip Flop
    process(clk, rst)
    begin
        if rst = '1' then
            s_qa <= '1';
        elsif falling_edge(clk) then
            s_qa <= s_d;
        end if;
    end process;

    jk_ff_inst : jk_ff
    port map(
        clk => clk,
        rst => rst,
        j => data_ready,
        k => du1,
        q => data_sent,
        q_bar => data_enable
    );

end Behavioral;
