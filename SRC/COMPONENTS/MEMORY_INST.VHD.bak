LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.CPU_package.ALL;

ENTITY MEMORY_INST IS
    PORT(
        CLOCK: IN STD_LOGIC;
        RESET: IN STD_LOGIC;
        ADDRESS: IN DATA_T;
        INSTRUCTION: OUT INST_T
    );
END ENTITY MEMORY_INST;

ARCHITECTURE LOGICA OF MEMORY_INST IS
    CONSTANT TAM_MEM: INTEGER := 2 ** ADDR_SIZE;
    TYPE ROM_TYPE IS ARRAY (0 TO TAM_MEM-1) OF INST_T;

    SIGNAL ROM: ROM_TYPE := (
        -- INICIALIZAÇÃO
        0 => x"0000";-- nop                      //0000000000000000
        1 => x"0000";-- load r1 70               //nan
        2 => x"0000";-- load r6 22               //nan
        3 => x"6ca2";-- add r5 r1 r6 (r5 <- 92)  //0110110010100010
        4 => x"4ca0";-- sw r5 0(r6) (mem <- 92)  //0100110010100000
        5 => x"0000";-- load r10 30              //nan
        6 => x"2de0";-- load r15 0(r6)           //0010110111100000
        7 => x"742b";-- sub r1 r5 r10 (r1 <- 62) //0111010000101011
        8 => x"a00d";-- j 13                     //1010000000001101
        9 => x"6c22";-- add r1 r1 r6             //0110110000100010
        10 => x"7445";-- sub r2 r2 r10           //0111010001000101
        11 => x"4220";-- sw r1 0(r1)             //0100001000100000
        12 => x"a00f";-- j 15                    //1010000000001111
        13 => x"6c44";-- add r2 r2 r6            //0110110001000100
        14 => x"8c49";-- beq r2 r6 9             //1000110001001001
        15 => x"0000";-- nop                     //0000000000000000
        OTHERS => (OTHERS => '0')
    );

    SIGNAL ADDR_INDEX: INTEGER RANGE 0 TO TAM_MEM-1 := 0;
BEGIN
    ADDR_INDEX <= TO_INTEGER(UNSIGNED(ADDRESS(ADDR_SIZE-1 DOWNTO 0)));

    PROCESS(CLOCK)
    BEGIN
        IF RISING_EDGE(CLOCK) THEN
            IF RESET='1' THEN
                INSTRUCTION <= (OTHERS => '0');
            ELSE
                INSTRUCTION <= ROM(ADDR_INDEX);
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE LOGICA;