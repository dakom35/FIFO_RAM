


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.myLibrary.all;


entity FASTSLOW is
  generic (M: natural);
  Port
  (
    CLK,INCWRITE,INCREAD,RESET: in std_logic;
    FAST,SLOW: out std_logic   
  );
end FASTSLOW;
  
architecture Behavioral of FASTSLOW is
  signal UP, DOWN: std_logic;
  signal sort: unsigned(M-1 downto 0);
  
  begin
    U1:counter_up_down
      generic map(M =>4)
      port map
      (
        CLK=>CLK,
        UD=>DOWN,
        ENABLE=>UP,
        CPTR=>sort,
        RESET=>RESET
      );
    
    UP<=INCWRITE xor INCREAD;
    DOWN<=INCWRITE;
    
    FAST<= sort(M-1) NOR sort(M-2);
    SLOW<= sort(M-1) and sort(M-2);
    

end Behavioral;


