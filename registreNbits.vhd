

---------------------------------------------
library ieee;
use ieee.std_logic_1164.all ;
use work.CHECK_PKG.all;

entity registreNbits is
  generic(N : natural := 8;
          t_setup : time := 5ns;
          t_hold : time := 5ns);
  port ( Reg_out : out STD_LOGIC_vector(N-1 downto 0);
          Din : in STD_LOGIC_vector(N-1 downto 0) := (others => '0');
         	CLK : in STD_LOGIC := '0' ;
         	reset : in STD_LOGIC := '0' );
end registreNbits;

--------------------------------------------------------
architecture registreNbits of registreNbits is
    signal output : std_logic_vector(N-1 downto 0);
begin
  process(CLK, reset)
    begin
      if reset = '1' then
        output <= (others => '0') ;
      else if (CLK = '1' and CLK'event) then
        output <= Din;
      end if;
    end if;
  end process;
  -- Verification of the pre-positionning time
  
  check_setup(clk=>CLK, din=>Din,t_setup=>t_setup);
  
  -- Verification of the hold time
  check_hold(clk=>CLK, din=>Din,t_hold=>t_hold);    
  Reg_out<=output;
  
end registreNbits;
