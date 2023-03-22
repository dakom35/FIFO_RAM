--sequencer_tb.vhd

LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
ENTITY sequencer_tb  IS 
END ; 
 
ARCHITECTURE sequencer_tb_arch OF sequencer_tb IS
  SIGNAL req   :  STD_LOGIC  ; 
  SIGNAL incw   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  SIGNAL rClk   :  STD_LOGIC  ; 
  SIGNAL enr   :  STD_LOGIC  ; 
  SIGNAL Ack   :  STD_LOGIC  ; 
  SIGNAL rw   :  STD_LOGIC  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL enw   :  STD_LOGIC  ; 
  SIGNAL oe   :  STD_LOGIC  ; 
  SIGNAL incr   :  STD_LOGIC  ; 
  SIGNAL cs   :  STD_LOGIC  ; 
  SIGNAL selr   :  STD_LOGIC  ; 
  COMPONENT sequencer  
    PORT ( 
      req  : in STD_LOGIC ; 
      incw  : out STD_LOGIC ; 
      reset  : in STD_LOGIC ; 
      rClk  : out STD_LOGIC ; 
      enr  : in STD_LOGIC ; 
      Ack  : out STD_LOGIC ; 
      rw  : out STD_LOGIC ; 
      clk  : in STD_LOGIC ; 
      enw  : in STD_LOGIC ; 
      oe  : out STD_LOGIC ; 
      incr  : out STD_LOGIC ; 
      cs  : out STD_LOGIC ; 
      selr  : out STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : sequencer  
    PORT MAP ( 
      req   => req  ,
      incw   => incw  ,
      reset   => reset  ,
      rClk   => rClk  ,
      enr   => enr  ,
      Ack   => Ack  ,
      rw   => rw  ,
      clk   => clk  ,
      enw   => enw  ,
      oe   => oe  ,
      incr   => incr  ,
      cs   => cs  ,
      selr   => selr   ) ; 
      
    process
      begin
        clk<='0';
        wait for 10 ns;
        clk<='1';
        wait for 10 ns;
    end process;
    
    
    process
      begin
        --state sleep
        reset<='0' ; 
        req<='1';
        enr<='1';
        enw<='0';
        --state lecture
        wait for 40 ns;
        --state sleep
        req<='0';
        enw<='1';
        enr<='0';
        --state writing
        wait for 40 ns;
        --state waiting
        req<='1';
        enr<='1';
        enw<='0';
        --state read2
        wait for 40 ns;
        --state waiting
        req<='0';
        enw<='1';
        enr<='0';
        --state waiting
        wait for 20 ns ;
        req<='1';
        enr<='0';
        enw<='1';
        --state sleep
        wait;
    end process;
    
END ; 

