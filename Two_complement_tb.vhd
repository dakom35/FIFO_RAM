

LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
USE work.my_functions.all  ; 
ENTITY Two_complement_tb  IS 
  GENERIC (
    N  : NATURAL   := 8 ); 
END ; 
 
ARCHITECTURE Two_complement_tb_arch OF Two_complement_tb IS
  SIGNAL output   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL number   :  std_logic_vector (N - 1 downto 0)  ; 
  COMPONENT Two_complement  
    GENERIC ( 
      N  : NATURAL  );  
    PORT ( 
      output  : out std_logic_vector (N - 1 downto 0) ; 
      number  : in std_logic_vector (N - 1 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : Two_complement  
    GENERIC MAP ( 
      N  => N   )
    PORT MAP ( 
      output   => output  ,
      number   => number   ) ; 
     process
     begin 
      
      number<="01011010";
      wait for 20 ns;
      number<="10100110";
      wait for 20 ns;
        number<="01001010";
      wait for 20 ns;
      number<="10100111";
      wait;
    end process;
END ; 

