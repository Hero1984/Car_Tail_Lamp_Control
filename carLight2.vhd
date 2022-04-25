
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity carLight2 is
Port (     L : in STD_LOGIC;
           R : in STD_LOGIC;
           L3 : out STD_LOGIC;
           L2 : out STD_LOGIC;
           L1 : out STD_LOGIC;
           R1 : out STD_LOGIC;
           R2 : out STD_LOGIC;
           R3 : out STD_LOGIC;           
           clk : inout STD_LOGIC:='0'
        );
end carLight2;

architecture Behavioral of carLight2 is
    
    --Mealy machine state variables:s0,s1,s2,s3
    type stateLight_type is (s0,s1,s2,s3); 
    signal stateLight_current,stateLight_next: stateLight_type := s0; 
    
    signal clk_signal : std_logic:='0';
    constant CLK_CYCLE : TIME:= 20ns; 
    
begin
    
    --clk for simulation 
--    process(clk_signal)
--    begin
--    clk_signal <= not clk_signal after CLK_CYCLE / 2;
--    end process;
    
    --initialize the clock
    --slow down the clock to 0.25s
    scan_clk_gen : process (clk) is
        -- T = 1/f,  f=100MHz, t=0.25=nT, n=10^8
        variable count : integer range 0 to 15000000 ;  
    begin
        -- count up the number of rising_edge
        -- clk_signal will rise after 0.25s passed
        if rising_edge(clk) then
            if count = 15000000 then
                count :=0;
                clk_signal<='1';
            else
                count :=count + 1;
                clk_signal<='0';
            end if;
        end if;
    end process scan_clk_gen ;    
       
    
    
    --mealy state design that
    mealy_machine: process(stateLight_current,clk_signal,L,R)
    begin
    if(clk_signal='1' and clk_signal'event) then
        case stateLight_current is
            when s0 =>
            if (L='0'and R='0') then --go LR == "00"
                L3<='0';L2<='0';L1<='0';R1<='0';R2<='0';R3<='0';
                stateLight_current  <= s0;
            elsif (L='1' and R='0') then --left LR == "10"
                L3<='0';L2<='0';L1<='1';
                stateLight_current  <= s1;
            elsif (L='0' and R='1') then --right LR == "01"
                R1<='1';R2<='0';R3<='0';
                stateLight_current  <= s1;
            elsif (L='1' and R='1') then --stop LR == "11"
                L3<='1';L2<='1';L1<='1';R1<='1';R2<='1';R3<='1';
                stateLight_current <= s3;
            else
                null;
            end if;
            when s1 =>
            if (L='0'and R='0') then --go LR == "00"
                L3<='0';L2<='0';L1<='0';
                R1<='0';R2<='0';R3<='0';
                stateLight_current <= s0;
            elsif (L='1' and R='0') then --left LR == "10"
                L3<='0';L2<='1';L1<='1';
                R1<='0';R2<='0';R3<='0';
                stateLight_current <= s2;
            elsif (L='0' and R='1') then --right LR == "01"
                L3<='0';L2<='0';L1<='0';
                R1<='1';R2<='1';R3<='0';
                stateLight_current <= s2;
            elsif (L='1' and R='1') then --stop LR == "11"
                L3<='1';L2<='1';L1<='1';
                R1<='1';R2<='1';R3<='1';
                stateLight_current <= s3;
            else
                null;
            end if;    

            when s2 =>
            if (L='0'and R='0') then --go LR == "00"
                L3<='0';L2<='0';L1<='0';
                R1<='0';R2<='0';R3<='0';
                stateLight_current <= s0;
            elsif (L='1' and R='0') then --left LR == "10"
                L3<='1';L2<='1';L1<='1';
                R1<='0';R2<='0';R3<='0';
                stateLight_current <= s3;
            elsif (L='0' and R='1') then --right LR == "01"
                L3<='0';L2<='0';L1<='0';
                R1<='1';R2<='1';R3<='1';
                stateLight_current <= s3;
            elsif (L='1' and R='1') then --stop LR == "11"
                L3<='1';L2<='1';L1<='1';
                R1<='1';R2<='1';R3<='1';
                stateLight_current <= s3;
            else
                null;
            end if;    

            when s3 =>  
            if (L='1'and R='1') then --go LR == "00"
                L3<='1';L2<='1';L1<='1';
                R1<='1';R2<='1';R3<='1';
                stateLight_current <= s3;
            else                     -- state goes S0
                L3<='0';L2<='0';L1<='0';
                R1<='0';R2<='0';R3<='0';
                stateLight_current <= s0;
            end if;    
            when others =>
            null;        
        end case;
    end if;    
    end process;

end Behavioral;

