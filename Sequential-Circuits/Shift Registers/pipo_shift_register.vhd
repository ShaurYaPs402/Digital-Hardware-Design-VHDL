library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pipo_shift_register is
    Port (
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        p_in  : in  STD_LOGIC_VECTOR(3 downto 0);
        p_out : out STD_LOGIC_VECTOR(3 downto 0)
    );
end pipo_shift_register;

architecture Behavioral of pipo_shift_register is
    signal q : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin

    process(clk, rst)
    begin
        if rst = '1' then
            q <= "0000";
        elsif rising_edge(clk) then
            q <= p_in;
        end if;
    end process;

    p_out <= q;

end Behavioral;
