library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity ramMxN is 
  generic (M: natural := 16;
            N: natural :=8);

  port(
        OE : in std_logic := '0';     -- output enable
        CS_n : in std_logic := '0' ;  -- chip select
        RW_n : in  std_logic :='0';   -- readwrite
        ADR : in std_logic_vector(M-1 downto 0) := (others => '0');
        DIN : in std_logic_vector(N-1 downto 0) := (others => '0');
        DOUT : out std_logic_vector(N-1 downto 0)) ;
end ramMxN;
--------------------------------------------------
architecture comp of ramMxN is

type memo is array (M-1 downto 0) of std_logic_vector(N-1 downto 0) ;
signal DATA : memo:=  ((others=> (others=>'0')));
begin
  Process(CS_n, ADR, DIN, OE)
    begin
      if CS_n='0' then
        if RW_n='1' then -- read 
           if (OE='1') then --enable read mode
              DOUT<=DATA(conv_integer(ADR));
            end if;
        elsif RW_n='0' then -- write 
            DATA(conv_integer(ADR))<=DIN;
            DOUT <= (others => 'Z'); 
        end if;
        else
          DOUT <= (others => 'Z'); -- high impedance
      end if;
    end process;
    
end comp;

