



library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.


entity counter_up_down is
  generic (M: natural:=4);
  Port(
    CLK : in  STD_LOGIC;
    ENABLE,UD,reset : in  STD_LOGIC;
    CPTR : out  unsigned (M-1 downto 0) 
    );
end counter_up_down;

architecture Behavioral of counter_up_down is
  signal scount : unsigned (M-1 downto 0) := (others => '0');
   
  begin
    process (CLK, ENABLE, UD)
      begin
        if rising_edge(CLK) then
            if (ENABLE ='1' and UD='1') then
                scount <=scount+1;       
            elsif (ENABLE='1' and UD='0') then
                scount <= scount -1;
            else
                scount <= scount ; 
            end if;
        end if;	
		-- Handle the reset---
      if(reset='1') then    
        scount <= (others => '0') ; -- syntax to put all bits to 0  :-) 
      end if;			
    end process;
    
    CPTR <= scount;

end Behavioral;

