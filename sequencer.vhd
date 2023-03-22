--sequencer.vhd


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sequencer is
 Port ( clk,reset,enr,enw,req : in std_logic ;
            Ack,cs,rw,oe,incr,incw,selr,rClk: out std_logic   
          );
end sequencer;

 
architecture Behavorial of sequencer is
 
type STATE_TYPE is (sleep,read1,read2,writing,waiting);
signal Current_state : STATE_TYPE := sleep;
signal Next_state : STATE_TYPE;
 begin
   process(clk)
        begin
            if rising_edge(clk) then
                Current_state<=Next_state;  
            end if;
        end process;
        
   process (reset,req,enr,enw,Current_state)
    begin
      
      case Current_state is
			
				when sleep=>
				   ack<='1';cs<='1';rw<='1';oe<='0';incw<='0';incr<='0';selr<='0';rClk<='0';
				      if(req='1' and enr='1')
				        then Next_state<=read1;      
				       else if(req='0' and enw='1')
				         then Next_state<=writing;
				       end if;
				      end if;
        when read1=>
             ack<='1';cs<='0';rw<='1';oe<='1';incw<='0';incr<='1';selr<='0';rClk<='1';
             Next_state<=sleep;
             
        when writing=>
             ack<='1';cs<='0';rw<='0';oe<='0';incw<='1';incr<='0';selr<='1';rClk<='0';
             Next_state<=waiting;
             
        when waiting=>    
            ack<='0';cs<='1';rw<='1';oe<='0';incw<='0';incr<='0';selr<='0';rClk<='0';
            if(enr='1')
               then Next_state<=read2;
              else if(req='0' and enr='0')
                then Next_state<=waiting;
                else if(req='1' and enr='0')
                  then Next_state<=sleep;
                end if;
              end if;
            end if;
            
        when read2=>     
          ack<='0';cs<='0';rw<='1';oe<='1';incw<='0';incr<='1';selr<='0';rClk<='1';
          Next_state<=waiting;
        when others=>
                    Next_state <= sleep;				
			end case;  
   end process;
   
end Behavorial;