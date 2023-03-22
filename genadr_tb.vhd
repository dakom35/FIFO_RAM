

LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE work.myLibrary.all  ; 

-- genadr is a component which generates addresses. 
-- in READ mode (SELREAD=1) and (INCREAD=1)
-- --> points the last read address 
-- --> increments itself at CLK's speed
-- in WRITE mode (selred=0) and (INCWRITE=1) ; 
-- --> points to the last address where data has been written
-- --> increments itself at CLK's speed
-- If no precaution is taken, this component could easily 
-- fill up the RAM. When that happens, it continues writing 
-- from the beginning (ADRG=NULL). This is a problem if you are
-- not aware of it. For example, if you write "Elephant" in the RAM 
-- at the adress "0x20" the beginning of the day but you carelesslly 
-- keep writing so much that your RAM cycles once and you write "Tiger"
-- again at the adress "0x20". Then later you print all the content
-- of your RAM, you might be surprised not to see "Elephant" written
-- anywhere. 




ENTITY genadr_tb  IS 
  GENERIC (
    M  : NATURAL   := 4 ); -- 2^M = number of words in the RAM (word = N bits)
END ; 
 
ARCHITECTURE genadr_tb_arch OF genadr_tb IS
  SIGNAL SELREAD   :  STD_LOGIC  ; 
  SIGNAL INCWRITE   :  STD_LOGIC  ; 
  SIGNAL ADRG   :  UNSIGNED (M - 1 downto 0)  ; 
  SIGNAL INCREAD   :  STD_LOGIC  ; 
  SIGNAL CLK   :  STD_LOGIC := '0'  ; 
  SIGNAL RESET   :  STD_LOGIC := '0'  ; 
  COMPONENT genadr  
    GENERIC ( 
      M  : NATURAL :=4  );  
    PORT ( 
      SELREAD  : in STD_LOGIC ; 
      INCWRITE  : in STD_LOGIC ; 
      ADRG  : out UNSIGNED (M - 1 downto 0) ; 
      INCREAD  : in STD_LOGIC ; 
      CLK  : in STD_LOGIC ; 
      RESET  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : genadr  
    GENERIC MAP ( 
      M  => M   )
    PORT MAP ( 
      SELREAD   => SELREAD  ,
      INCWRITE   => INCWRITE  ,
      ADRG   => ADRG  ,
      INCREAD   => INCREAD  ,
      CLK   => CLK  ,
      RESET   => RESET   ) ; 
      
      test_genadr : PROCESS
      BEGIN
        -- Writing in the RAM...
        SELREAD <= '0' ; INCWRITE <='1' ; INCREAD <= '0' ; RESET <= '0' ; wait for  14 ns ;
        -- Reading in the RAM...
        SELREAD <= '1' ; INCWRITE <='0' ; INCREAD <= '1' ; RESET <= '0' ; wait for  10 ns ;
        -- Writing in the RAM more than capacity...
        SELREAD <= '0' ; INCWRITE <='1' ; INCREAD <= '0' ; RESET <= '0' ; wait for  14 ns ;
        -- Reading in the RAM more than capacity...
        SELREAD <= '1' ; INCWRITE <='0' ; INCREAD <= '1' ; RESET <= '0' ; wait for  10 ns ;
        -- test RESET function
        SELREAD <= '1' ; INCWRITE <='0' ; INCREAD <= '1' ; RESET <= '1' ; wait for  10 ns ;
      END PROCESS ;
      
      CLK_PROCESS : PROCESS 
      BEGIN 
        CLK <= '0' ; wait for 500 ps ; CLK <='1' ; wait for 500 ps ; --  Tclk = 1ns
      END PROCESS;
      
      
      
END ; 

