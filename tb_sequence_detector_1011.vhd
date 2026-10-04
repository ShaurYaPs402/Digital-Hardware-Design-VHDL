library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_sequence_detector_1011 is
end tb_sequence_detector_1011;

architecture Behavioral of tb_sequence_detector_1011 is

    component sequence_detector_1011
        Port (
            clk   : in  STD_LOGIC;
            rst   : in  STD_LOGIC;
            x     : in  STD_LOGIC;
            y     : out STD_LOGIC
        );
    end component;

    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal x_tb   : std_logic := '0';
    signal y_tb   : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin

    uut: sequence_detector_1011
        Port Map (
            clk => clk_tb,
            rst => rst_tb,
            x   => x_tb,
            y   => y_tb
        );

    clk_process : process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD / 2;
        clk_tb <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    stim_proc: process
    begin
        rst_tb <= '1';
        wait for 20 ns;
        rst_tb <= '0';
        wait for 10 ns;

        x_tb <= '1'; wait for CLK_PERIOD;
        x_tb <= '0'; wait for CLK_PERIOD;
        x_tb <= '1'; wait for CLK_PERIOD;
        x_tb <= '1'; wait for CLK_PERIOD;

        x_tb <= '0'; wait for CLK_PERIOD;
        x_tb <= '1'; wait for CLK_PERIOD;
        x_tb <= '1'; wait for CLK_PERIOD;

        x_tb <= '0';
        wait;
    end process;

end Behavioral;
