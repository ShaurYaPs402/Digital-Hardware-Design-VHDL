library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sync_counter is
    Port ( clk   : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           count : out STD_LOGIC_VECTOR (3 downto 0));
end sync_counter;

architecture Behavioral of sync_counter is
    signal temp : STD_LOGIC_VECTOR (3 downto 0) := "0000";
begin
    process(clk, reset)
    begin
        if reset = '1' then
            temp <= "0000";
        elsif rising_edge(clk) then
            temp <= temp + 1;
        end if;
    end process;
    count <= temp;
end Behavioral;
