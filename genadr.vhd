library ieee;


use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.myLibrary.all;
use IEEE.NUMERIC_STD.ALL;

entity genadr is
    GENERIC (M  : NATURAL   := 4 ); -- number of bits of the 2 counters used
  
    port(
        RESET : in std_logic := '0'; 
        CLK : in std_logic := '0' ;
        INCREAD : in  std_logic ; -- indicates when you can make a write operation (asynchronous)
        INCWRITE : in std_logic ; --  indicates when you must make a read operation (synchronous)
        SELREAD : in std_logic ; -- indicates which output counter will be selected 
        ADRG : out unsigned(M-1 downto 0)) ; -- output counter selected 
end genadr;

architecture Behavioral of Genadr is
  
  signal READ_ADR :  unsigned(M-1 downto 0);
  signal WRITE_ADR :  unsigned(M-1 downto 0);
  
  begin  
    read_counter : counter_up_down -- counter used to count number of read operations
      generic map(M => M)
      Port map( 
        CLK => CLK,
        ENABLE=>INCREAD,
        UD => '1', -- normal counting forced 
        RESET => RESET ,
        CPTR => READ_ADR
        );

    write_counter : counter_up_down -- counter used to count number of write operations
      generic map(M => M)
        Port map(
          CLK => CLK,
          ENABLE => INCWRITE,
          UD => '1', -- normal counting forced 
          RESET => RESET,
          CPTR => WRITE_ADR                     
          );

    ADRG <= READ_ADR when SELREAD = '1'  else WRITE_ADR ; 

end Behavioral;

