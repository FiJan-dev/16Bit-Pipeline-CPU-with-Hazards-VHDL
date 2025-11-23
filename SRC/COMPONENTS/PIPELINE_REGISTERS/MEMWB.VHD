library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.CPU_package.all;

ENTITY MEMWB is
    PORT (
        D : IN STD_LOGIC_VECTOR(35 downto 0);
        CLOCK, RESET, ENABLE : IN std_logic;    -- mudar de DATA_SIZE PARA STAGE_SIZE
        Q : OUT STD_LOGIC_VECTOR(35 downto 0);
    );
END MEMWB;

ARCHITECTURE LOGICA OF MEMWB is
begin
    PROCESS (CLOCK)
    begin
        IF RESET = '1' THEN
            Q <= (others => '0');
        ELSIF RISING_EDGE(CLOCK) AND ENABLE = '1' THEN
            Q <= D;
        END IF;
    END PROCESS;
END LOGICA;

