library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity carLight2_tb is
end carLight2_tb;

architecture tb of carLight2_tb is
    component carLight2
        Port ( 
           L : in STD_LOGIC;
           R : in STD_LOGIC;
           L3 : out STD_LOGIC;
           L2 : out STD_LOGIC;
           L1 : out STD_LOGIC;
           R1 : out STD_LOGIC;
           R2 : out STD_LOGIC;
           R3 : out STD_LOGIC;           
           clk : inout STD_LOGIC
           );
    end component;
        
    signal L :  STD_LOGIC;
    signal R :  STD_LOGIC;
    signal L3 : STD_LOGIC;
    signal L2 : STD_LOGIC;
    signal L1 : STD_LOGIC;
    signal R1 : STD_LOGIC;
    signal R2 : STD_LOGIC;
    signal R3 : STD_LOGIC;           
    signal clk : STD_LOGIC;
    
    constant clock_period: time := 10 ns;
    signal stop_the_clock: boolean;

begin
    dut: carLight2
    port map(
           L=>L, 
           R=>R,  
           L3=>L3, 
           L2=>L2, 
           L1=>L1, 
           R1=>R1, 
           R2=>R2, 
           R3=>R3, 
           clk=>clk);
    
    
    
    stimull: process
    begin
        L <= '0';
        R <= '0';
        wait for 120 ns;
        
        L <= '1';
        R <= '0';
        wait for 120 ns;
        
        L <= '0';
        R <= '1';
        wait for 120 ns;
        
        L <= '1';
        R <= '1';
        wait for 120 ns;

        L <= '1';
        R <= '0';
        wait for 120 ns;
        
        L <= '1';
        R <= '1';
        wait for 120 ns;
        
        L <= '0';
        R <= '1';
        wait for 120 ns;
        
        L <= '1';
        R <= '0';
        wait for 120 ns;

    
    end process;    

end tb;
