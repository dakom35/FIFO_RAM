LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
ENTITY ramMxN_tb  IS 
  GENERIC (
    M  : NATURAL   := 16 ;  
    N  : NATURAL   := 8 ); 
END ; 
 
ARCHITECTURE ramMxN_tb_arch OF ramMxN_tb IS
  SIGNAL DOUT   :  STD_LOGIC_VECTOR (N-1 downto 0)  ; 
  SIGNAL OE   :  STD_LOGIC :='0'  ; 
  SIGNAL RW_n   :  STD_LOGIC  ; 
  SIGNAL DIN   :  STD_LOGIC_VECTOR (N-1 downto 0)  ; 
  SIGNAL ADR   :  STD_LOGIC_VECTOR (M-1 downto 0)  ; 
  SIGNAL CS_n   :  STD_LOGIC  ; 
  COMPONENT ramMxN  
    GENERIC ( 
      M  : NATURAL ; 
      N  : NATURAL
      );  
    PORT ( 
      DOUT  : out STD_LOGIC_VECTOR (N-1 downto 0) ; 
      OE  : in STD_LOGIC :='0' ; 
      RW_n  : in STD_LOGIC ; 
      DIN  : in STD_LOGIC_VECTOR (N-1 downto 0) ; 
      ADR  : in STD_LOGIC_VECTOR (M-1 downto 0) ; 
      CS_n  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : ramMxN  
    GENERIC MAP ( 
      M  => M  ,
      N  => N   )
    PORT MAP ( 
      DOUT   => DOUT  ,
      OE   => OE  ,
      RW_n   => RW_n  ,
      DIN   => DIN  ,
      ADR   => ADR  ,
      CS_n   => CS_n   ) ; 
      
      
      changement_donnee_entree : PROCESS 
        BEGIN
          -- writing
          
          CS_n <= '0' ; RW_n <= '0' ;OE <= '0' ; ADR <= x"0000" ; DIN <= "00000010" ;wait for 10 ns ;
          CS_n <= '0' ; RW_n <= '0' ;OE <= '0' ; ADR <= x"0001" ; DIN <= "00000110" ;wait for 10 ns ;
          CS_n <= '0' ; RW_n <= '0' ;OE <= '0' ; ADR <= x"0002" ; DIN <= "00001110" ;wait for 10 ns ;
          
            -- reading
            
          CS_n <= '0' ; RW_n <= '1' ;OE <= '1' ; ADR <= x"0003" ; DIN <= "11111111" ;wait for 10 ns ;
          CS_n <= '0' ; RW_n <= '1' ;OE <= '1' ; ADR <= x"0004" ; DIN <= "11111111" ;wait for 10 ns ;
          CS_n <= '0' ; RW_n <= '1' ;OE <= '1' ; ADR <= x"0005" ; DIN <= "11111111" ;wait for 10 ns ;
          
            -- writing 
          CS_n <= '0' ; RW_n <= '0' ;OE <= '0' ; ADR <= x"0003" ; DIN <= "00011110" ;wait for 10 ns ;
          CS_n <= '0' ; RW_n <= '0' ;OE <= '0' ; ADR <= x"0004" ; DIN <= "00111110" ;wait for 10 ns ;
          CS_n <= '0' ; RW_n <= '0' ;OE <= '0' ; ADR <= x"0005" ; DIN <= "01111110" ;wait for 10 ns ;
          
            -- reading
          CS_n <= '0' ; RW_n <= '1' ;OE <= '1' ; ADR <= x"0003" ; DIN <= "00011110" ;wait for 10 ns ;
          CS_n <= '0' ; RW_n <= '1' ;OE <= '1' ; ADR <= x"0004" ; DIN <= "00111110" ;wait for 10 ns ;
          CS_n <= '0' ; RW_n <= '1' ;OE <= '1' ; ADR <= x"0005" ; DIN <= "01111110" ;wait for 10 ns ;

 
          
          wait ; 
          
        END PROCESS;    
END ;
          

