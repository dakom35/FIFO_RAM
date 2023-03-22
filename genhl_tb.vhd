


LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE work.myLibrary.all  ; 
ENTITY genhl_tb  IS 
  GENERIC (
    DIV  : NATURAL   := 250 ); 
END ; 
 
ARCHITECTURE genhl_tb_arch OF genhl_tb IS
  SIGNAL Enwrite   :  STD_LOGIC  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL Enread   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  COMPONENT Genhl  
    GENERIC ( 
      DIV  : NATURAL  );  
    PORT ( 
      Enwrite  : out STD_LOGIC ; 
      clk  : in STD_LOGIC ; 
      Enread  : out STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : Genhl  
    GENERIC MAP ( 
      DIV  => DIV   )
    PORT MAP ( 
      Enwrite   => Enwrite  ,
      clk   => clk  ,
      Enread   => Enread  ,
      reset   => reset   ) ; 


      test_genhl : PROCESS
      BEGIN
        -- normal behaviour
        reset <= '0' ;  wait for  600 ns ;
        -- reset
        reset <= '1' ; wait for 5 ns ;
        -- and so on ...
        
        
        
      END PROCESS ;
      
      CLK_PROCESS : PROCESS 
      BEGIN 
        CLK <= '0' ; wait for 1 ns ; CLK <='1' ; wait for 1 ns ;
      END PROCESS;

END ;     
