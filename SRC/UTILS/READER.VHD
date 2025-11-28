LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
USE IEEE.std_logic_textio.ALL;

ENTITY READER IS
    GENERIC (
        INST_SIZE : INTEGER := 16;
        ADDR_SIZE : INTEGER := 8
    );
    PORT (
        CLOCK     : IN  STD_LOGIC;
        RESET     : IN  STD_LOGIC;
        PC        : IN  UNSIGNED(ADDR_SIZE-1 DOWNTO 0);
        DATA_OUT  : OUT STD_LOGIC_VECTOR(INST_SIZE-1 DOWNTO 0)
    );
END READER;

ARCHITECTURE LOGICA OF READER is
    FILE ISNT_FILE : TEXT;
begin
    PROCESS(CLOCK, RESET)
        VARIABLE INST_LINE : LINE;
        VARIABLE INST_HEX  : STD_LOGIC_VECTOR(INST_SIZE-1 DOWNTO 0);
        VARIABLE LINE_NUM : INTEGER := 0;
    begin
        IF RESET = '1' THEN
            DATA_OUT <= (OTHERS => '0');
        ELSIF RISING_EDGE(CLOCK) THEN
            FILE_CLOSE(INST_FILE);
            FILE_OPEN(INST_FILE, "INSTRUCTIONS.txt", READ_MODE);

            LINE_NUM := 0;
            WHILE LINE_NUM < TO_INTEGER(PC) AND NOT ENDFILE(INST_FILE) LOOP
                READLINE(INST_FILE, INST_LINE);
                LINE_NUM := LINE_NUM + 1;
            END LOOP;

            IF NOT ENDFILE(INST_FILE) THEN
                HREAD(INST_LINE, INST_HEX);
                DATA_OUT <= INST_HEX;
            ELSE
                DATA_OUT <= x"0000";
            END IF;

            DEALLOCATE(L);
        END IF;
    END PROCESS;
END LOGICA;

--nao incluir