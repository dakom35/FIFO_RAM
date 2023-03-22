

--------------------------------------------------------------------------
-- Two_complement.vhd
--------------------------------------------------------------------------






library ieee ;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_1164.all ;
use work.my_functions.all;



entity Two_complement is
generic (N: natural  := 8) ;

port (number : in std_logic_vector( N-1 downto 0);
	  output : out std_logic_vector( N-1 downto 0)) ;
end Two_complement;

architecture archi_Two_complement of Two_complement is
begin
    output <= cpl2(number,N);
    
end archi_Two_complement ;
--------------------------------------------------------------------------