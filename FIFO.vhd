


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- implementation of 16x32 FIFO (N=32 , M=16)
-- N is the number of bits per word
-- 2^M is the total number of words that the FIFO can manage
entity FIFO is
    Port ( 
    Din : in  STD_LOGIC_VECTOR(31 downto 0) ;    
    reset : in STD_LOGIC  ;
    CLK : in STD_LOGIC ;
    req : in STD_LOGIC ;
    Ack : out STD_LOGIC ;
    Data_out : out STD_LOGIC_VECTOR(31 downto 0) ;
    HL : out STD_LOGIC ;
    fast : out STD_LOGIC ;
    slow : out STD_LOGIC 
    );

end FIFO;

architecture Behavioral of FIFO is 

  
  -- SIGNALS FOR : 
  
  ---- sequencer input 
  signal Enread : STD_LOGIC ;
  signal Enwrite : STD_LOGIC ;
  
  ----  genadr input --
  signal Incread : STD_LOGIC ;
  signal Incwrite : STD_LOGIC ;
  signal selread : STD_LOGIC ;
  
  -- Two_complement
  signal Data_in : STD_LOGIC_VECTOR(31 downto 0);
  --signal Data_out : STD_LOGIC_VECTOR(31 downto 0);

  BEGIN 
    
    registreNbits_0 : entity work.registreNbits
    PORT MAP
    (
      CLK => CLK,
      reset => reset,
      Din => Din
    );
    
 --   Two_complement_0 : entity work.Two_complement
  --  PORT MAP
  --  (
  --    Data_in => number,
 --     output => Data_out
  --   );
      
      
    
    genhl_0 : entity work.Genhl
    PORT MAP
    (
      reset => reset,
      CLK => clk,
      Enread => Enread,
      Enwrite => Enwrite
   );
   
    sequenseur_0 : entity work.sequenseur
    PORT MAP
    (
     reset => reset,
     CLK => clk,
     enr => Enread,
     enw => Enwrite,
     req => req,
     incr => Incread,
     incw => Incwrite,
     selr => selread
   );
   
   genadr_0 : entity work.genadr
   PORT MAP
   (
      reset => reset,
      CLK => CLK, 
      incread => Incread,
      incwrite =>  Incwrite,
      selread => selread
      
  );
     
      
    
    
    
    
end Behavioral; 
    
      
  