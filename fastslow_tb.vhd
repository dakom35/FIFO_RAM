LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE work.myLibrary.all  ; 
ENTITY fastslow_tb  IS 
  GENERIC(M  : NATURAL :=4  ); 
END ; 
 
ARCHITECTURE fastslow_tb_arch OF fastslow_tb IS
  SIGNAL SLOW   :  STD_LOGIC  ; 
  SIGNAL INCWRITE   :  STD_LOGIC  ; 
  SIGNAL FAST   :  STD_LOGIC  ; 
  SIGNAL INCREAD   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL RESET   :  STD_LOGIC  ; 
  COMPONENT FASTSLOW  
    GENERIC ( 
      M  : NATURAL :=4  );  
    PORT ( 
      SLOW  : out STD_LOGIC ; 
      INCWRITE  : in STD_LOGIC ; 
      FAST  : out STD_LOGIC ; 
      INCREAD  : in STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      RESET  : in STD_LOGIC ); 
  END COMPONENT ; 
  
BEGIN
  DUT  : FASTSLOW  
    GENERIC MAP ( 
      M  => M   )
      
    PORT MAP ( 
      SLOW   => SLOW  ,
      INCWRITE   => INCWRITE  ,
      FAST   => FAST  ,
      INCREAD   => INCREAD  ,
      CLK   => CLK  ,
      RESET   => RESET   ) ;
      
      
      fastslow_tb_0 : PROCESS 
      BEGIN 

        INCWRITE  <='1' ; INCREAD <= '0' ; RESET <='0' ; wait for 20 ns; -- filling up the memory
        INCWRITE  <='0' ; INCREAD <= '1' ; RESET <='0' ; wait for 20 ns; -- just reading from the memory : status quo 
        INCWRITE  <='0' ; INCREAD <= '1' ; RESET <='1' ; wait for 10 ns; -- test reset
        INCWRITE  <='1' ; INCREAD <= '0' ; RESET <='0' ; wait for 20 ns; -- filling up the memory once more    
      END PROCESS;
      
      CLK_PROCESS : PROCESS 
      BEGIN 
        CLK <= '0' ; wait for 500 ps ; CLK <='1' ; wait for 500 ps ;
      END PROCESS; 
      
      
      
       
END ; 

