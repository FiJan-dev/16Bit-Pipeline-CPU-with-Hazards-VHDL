LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
USE IEEE.std_logic_textio.ALL;

USE work.CPU_package.all;

ENTITY IF_STAGE is
    PORT (
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        PC_BRANCH : IN INST_T;
        MUX_PC_SRC: IN STD_LOGIC;
        DATA_IF_ID : OUT DATA_REG_IF_ID
    );
END IF_STAGE;

architecture COMPORTAMENTO OF IF_STAGE is
    SIGNAL PC : UNSIGNED(DATA_T) := (OTHERS => '0'); --TODO://CONFERIR SE É INICIALIZADO APENAS 1 VEZ
    SIGNAL DATA_STREAM : INST_T;
BEGIN
    MEM_INST: MEMORY_INST PORT MAP(CLOCK, RESET, PC, DATA_STREAM);

    PROCESS(CLOCK, RESET)
    begin
        IF MUX_PC_SRC = '0'
            PC <= PC + 4;
        ELSE
            PC <= PC_BRANCH;
        END IF; 

        IF RESET = '1' THEN
            PC <= (OTHERS => '0');
        ELSIF RISING_EDGE(CLOCK) THEN
            PC <= NEXT_PC;
        END IF;
    END PROCESS;

    -- 16 - 16
    -- PC+4 - INST
    DATA_IF_ID(31 DOWNTO 16) <= PC;
    DATA_IF_ID(15 DOWNTO 0) <= DATA_STREAM;

END COMPORTAMENTO;
