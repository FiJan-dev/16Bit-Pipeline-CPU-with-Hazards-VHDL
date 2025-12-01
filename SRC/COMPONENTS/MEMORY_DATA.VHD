LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE WORK.CPU_package.ALL;

ENTITY MEMORY_DATA IS
    PORT (
        CLOCK     : IN  STD_LOGIC;
        RESET     : IN  STD_LOGIC;
        
        -- Sinais de controle do estágio MEM
        MEM_WRITE : IN  STD_LOGIC;  -- '1' para SW
        MEM_READ  : IN  STD_LOGIC;  -- '1' para LW
        
        ADDRESS   : IN  DATA_T; -- Endereço em palavras
        WRITE_DATA: IN  DATA_T;
        
        READ_DATA : OUT DATA_T
    );
END MEMORY_DATA;

ARCHITECTURE LOGICA OF MEMORY_DATA IS
    CONSTANT TAM_MEM : INTEGER := 2 ** ADDR_SIZE;
    TYPE RAM_TYPE IS ARRAY (0 TO TAM_MEM - 1) OF DATA_T;
    CONSTANT RAM_INIT : RAM_TYPE := (
        0  => x"0001",
        1  => x"0002",
        2  => x"0003",
        3  => x"0004",
        4  => x"0005",
        5  => x"0006",
        6  => x"0007",
        7  => x"0008",
        8  => x"0009",
        9  => x"000A",
        10 => x"000B",
        11 => x"000C",
        12 => x"000D",
        13 => x"000E",
        14 => x"000F",
        15 => x"0010",
        OTHERS => (OTHERS => '0')
    );
	 
    SIGNAL RAM : RAM_TYPE := RAM_INIT;

    
    SIGNAL ADDR_INDEX: INTEGER RANGE 0 TO TAM_MEM-1;
BEGIN
    ADDR_INDEX <= TO_INTEGER(UNSIGNED(ADDRESS(ADDR_SIZE-1 DOWNTO 0)));

    READ_DATA <= RAM(ADDR_INDEX) when MEM_READ = '1' else (others => '0');

    PROCESS(CLOCK, RESET)
    BEGIN
        IF RISING_EDGE(CLOCK) THEN
            IF RESET = '1' THEN
                RAM <= RAM_INIT;
            ELSE
                IF MEM_WRITE = '1' THEN
                    RAM(ADDR_INDEX) <= WRITE_DATA;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END LOGICA;