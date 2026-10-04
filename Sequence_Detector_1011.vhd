library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sequence_detector_1011 is
    Port (
        clk   : in  STD_LOGIC;
        rst   : in  STD_LOGIC;
        x     : in  STD_LOGIC;
        y     : out STD_LOGIC
    );
end sequence_detector_1011;

architecture Behavioral of sequence_detector_1011 is

    type state_type is (S0, S1, S2, S3);
    signal current_state, next_state : state_type;

begin

    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= S0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    process(current_state, x)
    begin
        case current_state is
            when S0 =>
                if x = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;

            when S1 =>
                if x = '0' then
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;

            when S2 =>
                if x = '1' then
                    next_state <= S3;
                else
                    next_state <= S0;
                end if;

            when S3 =>
                if x = '1' then
                    next_state <= S1;
                else
                    next_state <= S2;
                end if;

            when others =>
                next_state <= S0;
        end case;
    end process;

    process(current_state, x)
    begin
        if (current_state = S3 and x = '1') then
            y <= '1';
        else
            y <= '0';
        end if;
    end process;

end Behavioral;
