library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jk_ff is
    port(
        clk, rst : in std_logic;
        j, k : in std_logic;
        q, q_bar : out std_logic
    );
end jk_ff;

architecture Behavioral of jk_ff is
signal temp: std_logic;
signal temp_bar: std_logic;
begin

-- J-K Flip Flop
    process(clk, rst)
    begin
        if rst = '1' then
            temp <= '0';
            temp_bar <= '1';
        elsif rising_edge(clk) then
            if(j = '0' and k = '0') then
                temp <= temp;
                temp_bar <= temp_bar;
            elsif(j = '0' and k = '1') then
                temp <= '0';
                temp_bar <= '1';
            elsif(j ='1' and k ='0') then
                temp <= '1';
                temp_bar <= '0';
            else
                temp <= not temp;
                temp_bar <= not temp_bar;
            end if;
        end if;
    end process;
    q <= temp;
    q_bar <= temp_bar;
end Behavioral;
