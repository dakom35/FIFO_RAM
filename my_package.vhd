--------------------------------------------------------------------
-- my_package.vhd
--------------------------------------------------------------------



library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

package my_functions is
    function cpl2 (entree : std_logic_vector ; N : natural) 
    return std_logic_vector ;
end my_functions ;

--------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;

package body my_functions is
    function cpl2 (entree : std_logic_vector ; N : natural) 
    return std_logic_vector is
    variable temp : std_logic_vector( N-1 downto 0) ;
    
    begin
      temp := not entree;
      temp := temp + '1' ;
    
      return temp ;

    end cpl2 ;
end my_functions ;

--------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;

package CHECK_PKG is

-- declaration of the check setup procedure

procedure check_setup( signal clk : in std_logic;
    signal din : in std_logic_vector;
    t_setup : in time;
    severite : in severity_level:= warning;
    hstart : in time := time'low;
    hend : in time := time'high );

  procedure check_hold ( signal clk : in std_logic;
    signal din : in std_logic_vector;
    t_hold : in time;
    severite : in severity_level:= warning;
    hstart : in time := time'low;
    hend : in time := time'high );

end CHECK_PKG;

--------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;

package body CHECK_PKG is

-- Specification of the body of the package
--check_setup procedure 

procedure check_setup( signal clk : in std_logic;
    signal din : in std_logic_vector;
    t_setup : in time;
    severite : in severity_level:= warning;
    hstart : in time := time'low;
    hend : in time := time'high) is
begin
  loop
    wait on clk;
    If clk = '1' and clk'event then
      if now >= hstart and now <= hend then
        assert din'last_event >= t_setup and din'event = false
        report "SETUP TIME NOT RESPECTED" severity severite;
      elsif now > hend then
        wait;
      end if;
    end if;
  end loop;
end check_setup;

--------------------------------------------------------------------

procedure check_hold ( signal clk : in std_logic;
    signal din : in std_logic_vector;
    t_hold : in time;
    severite : in severity_level:= warning;
    hstart : in time := time'low;
    hend : in time := time'high ) is
    variable t : time;
  begin
  loop
    wait until clk='1';
    t := now;
        if t >= hstart and t <= hend then
            if din'event = false then
                wait on din for t_hold;
            end if;
        assert din'event = false or (now - t) = t_hold
        report "HOLD TIME NOT RESPECTED !!!" severity severite;
        elsif t > hend then
        wait;  -- definitive suspension.
      end if;
  end loop;

End check_hold;

End CHECK_PKG;
-------------------------------------------------------------------

