library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.CPU_package.all;

ENTITY REGBANK is
    PORT(
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        REGWRITE : std_logic;
        RS, RT, RD : IN REG_ADDR_T;
        WRITEDATA : IN DATA_T;
        RSDATA, RTDATA: OUT DATA_T
    );
END REGBANK;

ARCHITECTURE LOGICA OF REGBANK is
    TYPE REG_ARRAY IS ARRAY(0 TO 15) OF DATA_T;
    SIGNAL REGS: REG_ARRAY := (OTHERS => (OTHERS => '0'));
begin
    PROCESS(CLOCK, RESET)
    begin
        IF RESET = '1' THEN
            REGS <= (OTHERS => (OTHERS => '0'));
        ELSIF RISING_EDGE(CLOCK) AND REWRITE = '1' THEN
            REGS(TO_INTEGER(UNSIGNED(RD))) <= WRITEDATA;
        END IF;
    END PROCESS;

    RSDATA <= REGS(TO_INTEGER(UNSIGNED(RS)));
    RTDATA <= REGS(TO_INTEGER(UNSIGNED(RT)));
END LOGICA;
            
