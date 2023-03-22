library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.myLibrary.all;


entity genhl is
  generic (DIV: natural :=250);
  Port 
  (
      reset,clk: in std_logic;
      Enread,Enwrite: out std_logic
  );
end genhl;

architecture Behavioral of genhl is
    signal tmp8: unsigned(7 downto 0);
    signal RAZ,tmp1: std_logic;
       
  begin
    U1 : counter_up_down
    generic map(8)
   
    port map
    (
      clk=>clk,
      reset=>RAZ,
      UD=>'1',
      enable=>'1',
      CPTR=>tmp8
    );
    
    tmp1<='1' when to_integer(tmp8)=249 else '0';
     
    Enread<=tmp1;
    Enwrite<=not tmp1;
    RAZ<= reset or tmp1;
    
end Behavioral;

