
LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
ENTITY counter_up_down_tb  IS 
  GENERIC (
    M  : NATURAL   := 4 ); 
END ; 
 
ARCHITECTURE counter_up_down_tb_arch OF counter_up_down_tb IS
  SIGNAL UD   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL CPTR   :  UNSIGNED (M - 1 downto 0)  ; 
  SIGNAL RESET   :  STD_LOGIC  ; 
  SIGNAL ENABLE   :  STD_LOGIC  ; 
  COMPONENT counter_up_down  
    GENERIC ( 
      M  : NATURAL  );  
    PORT ( 
      UD  : in STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      CPTR  : out UNSIGNED (M - 1 downto 0) ; 
      RESET  : in STD_LOGIC ; 
      ENABLE  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : counter_up_down  
    GENERIC MAP ( 
      M  => M   )
    PORT MAP ( 
      UD   => UD  ,
      CLK   => CLK  ,
      CPTR   => CPTR  ,
      RESET   => RESET  ,
      ENABLE   => ENABLE   ) ; 
      
      
      test_compteur : PROCESS
      BEGIN
        -- reverse counting
        UD <= '0' ; RESET <='0' ; ENABLE <= '1' ; wait for  40 ns ;
        -- stop counting 
        UD <= '0' ; RESET <='0' ; ENABLE <= '0' ; wait for 10 ns ;
        -- test RESET function 
        UD <= '0' ; RESET <='1' ; ENABLE <= '1' ; wait for 10 ns ;
        --  normal counting
        UD <= '1' ; RESET <='0' ; ENABLE <= '1' ; wait for 40 ns ;
        -- and so on ...        
      END PROCESS ;
      
      CLK_PROCESS : PROCESS 
      BEGIN 
        CLK <= '0' ; wait for 1 ns ; CLK <='1' ; wait for 1 ns ;
      END PROCESS;
        
        
        
END ; 

