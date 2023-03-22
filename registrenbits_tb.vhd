


LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.std_logic_1164.all  ; 
USE work.CHECK_PKG.all  ; 
ENTITY registrenbits_tb  IS 
  GENERIC (
    t_setup  : TIME   := 250 ps ;  
    t_hold  : TIME   := 250 ps ;
    CLK_period : TIME := 1ns ;  
    N  : NATURAL   := 8 ); 
END ; 
 
ARCHITECTURE registrenbits_tb_arch OF registrenbits_tb IS
  SIGNAL Din   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL Reg_out   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC := '0' ; 
  
  COMPONENT registreNbits  
    GENERIC ( 
      t_setup  : TIME ; 
      t_hold  : TIME ; 
      N  : NATURAL  );  
    PORT ( 
      Din  : in std_logic_vector (N - 1 downto 0) ; 
      Reg_out  : out std_logic_vector (N - 1 downto 0) ; 
      CLK  : in STD_LOGIC ; 
      reset  : in STD_LOGIC := '0' ); 
  END COMPONENT ; 
BEGIN
  DUT  : registreNbits  
    GENERIC MAP ( 
      t_setup  => t_setup  ,
      t_hold  => t_hold  ,
      N  => N   )
    PORT MAP ( 
      Din   => Din  ,
      Reg_out   => Reg_out  ,
      CLK   => CLK  ,
      reset   => reset   ) ; 
      
      CLK_process : process
        begin
          
          CLK<='0';
          wait for CLK_period / 2 ;
          CLK<='1';
          wait for CLK_period / 2;       
      end process;
      
      registreNbits_0 : process
        begin
          reset <= '0' ; 
          wait for CLK_period / 4 ; Din<="10101010"; -- to respect setup time (sets 250ps before rising edge)
          wait for CLK_period / 2 ; -- to respect hold time (250ps here)  
          Din<="10001111"; wait for CLK_period * 1 ;  -- if we write every period from now, both times will be respected 
          Din<="10000000"; wait for CLK_period/2 ; wait for CLK_period/4 ; wait for CLK_period/32 ; -- no respect of hold time 
          Din<="00000000"; wait for CLK_period /2; wait for CLK_period/4 ; wait for CLK_period/8;     -- ignored data
          Din<="11111111"; wait for CLK_period * 1 ;  -- no respect of setup time
          wait;
      end process;
      
END ; 

