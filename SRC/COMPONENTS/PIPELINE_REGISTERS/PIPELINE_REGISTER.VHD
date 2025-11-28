library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.CPU_package.all;

ENTITY PIPELINE_REGISTER is
    PORT (
        D : IN DATA_SIZE;
        CLOCK, RESET, ENABLE : IN std_logic;    -- mudar de DATA_SIZE PARA STAGE_SIZE
        Q : OUT DATA_SIZE
    );
END PIPELINE_REGISTER;

ARCHITECTURE LOGICA OF PIPELINE_REGISTER is
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

--nao incluir