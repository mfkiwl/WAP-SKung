library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity mac is
    generic(n: natural:=8); -- vector size
    port(
        --matrix multiply accumulate
        clk, rst                                : in std_logic;
        left_in, top_in                         : in std_logic_vector(n-1 downto 0);
        bottom_out, right_out, result_out       : out std_logic_vector(n-1 downto 0)
    );
end mac;

architecture Behavioral of mac is
    signal product  :   std_logic_vector(2*n-1 downto 0);
    signal accum : std_logic_vector(n-1 downto 0);
begin
    product <= left_in * top_in;
    result_out <= accum;

    process(clk, rst)
    begin
        if rst = '1' then
            accum <= (others => '0');
            bottom_out <= (others => '0');
            right_out <= (others => '0');
        else
            if rising_edge(clk) then
                accum <= accum + product(n-1 downto 0);
                bottom_out <= top_in;
                right_out <= left_in;
            end if;
        end if;
    end process;
end Behavioral;
