

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;


package myLibrary is 
  
  component counter_up_down is
    generic (M: natural:=4);
    Port (
      CLK : in  STD_LOGIC;
      ENABLE,UD,RESET : in  STD_LOGIC;
      CPTR : out  unsigned (M-1 downto 0) );
  end component ;


  component RAM2EMxN is
    generic (M: natural := 16;
            N: natural :=8);

    port(
        OE : in std_logic := '0'; -- OE= output enable
        CS_n : in std_logic := '0' ;-- CS= chip select
        RW_n : in  std_logic :='0'; -- RW= readwrite  
        ADR : in std_logic_vector(M-1 downto 0) := (others => '0');
        DIN : in std_logic_vector(N-1 downto 0) := (others => '0');
        DOUT : out std_logic_vector(N-1 downto 0)) ;
  end component ; 


  component Genhl is
    generic (DIV: natural :=250);
      Port (
        RESET,CLK: in std_logic;
        Enread,Enwrite: out std_logic
        );
  end component ; 
  
  
  
  
  
  
  
end package ;