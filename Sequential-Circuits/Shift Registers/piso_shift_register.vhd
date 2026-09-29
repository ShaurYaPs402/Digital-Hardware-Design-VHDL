library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PISO is
    Port ( clk   : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load  : in  STD_LOGIC;
           din   : in  STD_LOGIC_VECTOR(3 downto 0);
           dout  : out STD_LOGIC);
end PISO;

architecture Behavioral of PISO is
    signal temp : STD_LOGIC_VECTOR(3 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            temp <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                temp <= din;
            else
                temp <= temp(2 downto 0) & '0';
            end if;
        end if;
    end process;

    dout <= temp(3);
end Behavioral;
