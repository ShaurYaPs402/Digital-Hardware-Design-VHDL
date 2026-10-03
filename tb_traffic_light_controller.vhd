library ieee;
use ieee.std_logic_1164.all;

entity tb_traffic_light_controller is
-- Testbench entity keeps empty
end tb_traffic_light_controller;

architecture test of tb_traffic_light_controller is

    -- Component declaration
    component traffic_light_controller
        port (
            clk : in std_logic;
            rst : in std_logic;
            Sa  : in std_logic;
            Sb  : in std_logic;
            Ga  : out std_logic;
            Ya  : out std_logic;
            Ra  : out std_logic;
            Gb  : out std_logic;
            Yb  : out std_logic;
            Rb  : out std_logic
        );
    end component;

    -- Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal Sa  : std_logic := '0';
    signal Sb  : std_logic := '0';

    -- Outputs
    signal Ga, Ya, Ra : std_logic;
    signal Gb, Yb, Rb : std_logic;

    -- Clock period definition (10ns clock)
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: traffic_light_controller port map (
        clk => clk,
        rst => rst,
        Sa  => Sa,
        Sb  => Sb,
        Ga  => Ga,
        Ya  => Ya,
        Ra  => Ra,
        Gb  => Gb,
        Yb  => Yb,
        Rb  => Rb
    );

    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- Apply system reset
        rst <= '1';
        wait for 20 ns;	
        rst <= '0';
        wait for 20 ns;

        -- Test Case 1: Road A active, Road B empty (Sb = 0)
        Sa <= '1';
        Sb <= '0';
        wait for 80 ns;

        -- Test Case 2: Vehicle arrives on Road B (Sb = 1)
        Sb <= '1';
        wait for 120 ns;

        -- Test Case 3: Road A empty, Road B has traffic (Sa = 0, Sb = 1)
        Sa <= '0';
        Sb <= '1';
        wait for 80 ns;

        -- End simulation
        wait;
    end process;

end test;
