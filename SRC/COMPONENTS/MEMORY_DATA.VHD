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
    SIGNAL RAM : RAM_TYPE := (
        0  => x"0005",  
        1  => x"000A",  
        2  => x"0016",  
        3  => x"0046",  
        4  => x"0050",  
        5  => x"003E",  
        6  => x"0030",  
        7  => x"0001", 
        8  => x"0020",  
        9  => x"000F",  
        10 => x"0002",  
        11 => x"00FF",  
        12 => x"00AA",  
        13 => x"005C",  
        14 => x"000C",  
        15 => x"0000",  
        OTHERS => (OTHERS => '0')
    );
    
    SIGNAL ADDR_INDEX: INTEGER RANGE 0 TO TAM_MEM-1;
BEGIN
    ADDR_INDEX <= TO_INTEGER(UNSIGNED(ADDRESS(ADDR_SIZE-1 DOWNTO 0)));

    READ_DATA <= RAM(ADDR_INDEX) when MEM_READ = '1' else (others => '0');

    PROCESS(CLOCK, RESET)
    BEGIN
        IF RISING_EDGE(CLOCK) THEN
            IF RESET='1' THEN
                FOR i IN 0 TO TAM_MEM-1 LOOP
                    RAM(i) <= (OTHERS => '0');
                END LOOP;
            ELSE
                IF MEM_WRITE='1' THEN
                    RAM(ADDR_INDEX) <= WRITE_DATA;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END LOGICA;