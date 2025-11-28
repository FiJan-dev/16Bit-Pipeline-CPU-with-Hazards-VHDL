library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

ENTITY ASSEMBLER is
    GENERIC (INST_SIZE : INTEGER := 16)
    PORT (
        SW : IN STD_LOGIC_VECTOR (INST_SIZE+1 DOWNTO 0);
        LEDR: OUT STD_LOGIC_VECTOR(INST_SIZE+1 DOWNTO 0)
    );
END ASSEMBLER;

ARCHITECTURE LOGICA OF ASSEMBLER is
    SIGNAL SAVE : STD_LOGIC;
    FILE OUTPUT_FILE   : TEXT OPEN WRITE_MODE IS "INSTRUCTIONS.txt";
begin

    SAVE <= SW(16);
    LEDR <= SW;
    
    PROCESS(SW, SAVE)
        variable LINE_OUT: LINE;
    begin
        IF SAVE = '1' THEN
            HWRITE(LINE_OUT, SW(15 downto 0));
            WRITELINE(OUTPUT_FILE, LINE_OUT);
        END IF;
    END PROCESS;
END LOGICA;

