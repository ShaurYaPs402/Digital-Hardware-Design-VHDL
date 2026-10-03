library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity traffic_light_controller is
    Port (
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        Sa  : in  STD_LOGIC;
        Sb  : in  STD_LOGIC;
        Ga  : out STD_LOGIC;
        Ya  : out STD_LOGIC;
        Ra  : out STD_LOGIC;
        Gb  : out STD_LOGIC;
        Yb  : out STD_LOGIC;
        Rb  : out STD_LOGIC
    );
end traffic_light_controller;

architecture Behavioral of traffic_light_controller is

    type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12);
    signal current_state, next_state : state_type;

begin

    -- Process 1: State Memory (Sequential Logic)
    process(clk, rst)
    begin
        if rst = '1' then
            current_state <= S0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Process 2: Next State Logic (Combinational Logic)
    process(current_state, Sa, Sb)
    begin
        case current_state is
            when S0 =>
                next_state <= S1;
            when S1 =>
                next_state <= S2;
            when S2 =>
                next_state <= S3;
            when S3 =>
                next_state <= S4;
            when S4 =>
                next_state <= S5;
                
            when S5 =>
                if Sb = '0' then         -- Sb' condition
                    next_state <= S5;
                else                     -- Sb condition
                    next_state <= S6;
                end if;
                
            when S6 =>
                next_state <= S7;
            when S7 =>
                next_state <= S8;
            when S8 =>
                next_state <= S9;
            when S9 =>
                next_state <= S10;
            when S10 =>
                next_state <= S11;
                
            when S11 =>
                if (Sa = '0' and Sb = '1') then  -- Sa' * Sb condition
                    next_state <= S11;
                else                              -- Sa + Sb' condition
                    next_state <= S12;
                end if;
                
            when S12 =>
                next_state <= S0;
                
            when others =>
                next_state <= S0;
        end case;
    end process;

    -- Process 3: Output Logic (Moore Machine)
    process(current_state)
    begin
        -- Default: Sab lights OFF
        Ga <= '0'; Ya <= '0'; Ra <= '0';
        Gb <= '0'; Yb <= '0'; Rb <= '0';

        case current_state is
            when S0 | S1 | S2 | S3 | S4 | S5 =>
                Ga <= '1';
                Rb <= '1';
                
            when S6 =>
                Ya <= '1';
                Rb <= '1';
                
            when S7 | S8 | S9 | S10 | S11 =>
                Ra <= '1';
                Gb <= '1';
                
            when S12 =>
                Ra <= '1';
                Yb <= '1';
                
            when others =>
                Ra <= '1';
                Rb <= '1';
        end case;
    end process;

end Behavioral;
