library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.CPU_package.all;

ENTITY IFID is
    PORT (
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        DATA_IN : IN DATA_REG_IF_ID;
        DATA_OUT : OUT DATA_REG_IF_ID
    );
END IFID;

ARCHITECTURE LOGICA OF IFID is
begin
    PROCESS (CLOCK, RESET)
    begin
        IF RESET = '1' THEN
        DATA_OUT <= (others => '0');
        ELSIF RISING_EDGE(CLOCK) THEN
        DATA_OUT <= DATA_IN;
        END IF;
    END PROCESS;
END LOGICA;

