library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.CPU_package.all;

ENTITY IDEX is
    PORT (
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        FLUSH: IN STD_LOGIC;
        DATA_IN : IN STD_LOGIC_VECTOR(65 downto 0);
        DATA_OUT : OUT STD_LOGIC_VECTOR(65 downto 0);
    );
END IDEX;

ARCHITECTURE LOGICA OF IDEX is
begin
    PROCESS (CLOCK, RESET)
    begin
        IF RESET = '1' THEN
            DATA_OUT <= (others => '0'); 
        ELSIF FLUSH = '1' THEN
            DATA_OUT <= (others => '0');   --TODO://ZERAR APENAS 6 SINAIS ALTOS
        ELSIF RISING_EDGE(CLOCK) THEN
            DATA_OUT <= DATA_IN;
        END IF;
    END PROCESS;
END LOGICA;

