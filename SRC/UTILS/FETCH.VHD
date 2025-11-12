library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

USE work.CPU_package.all;

ENTITY FETCH is
    PORT(
        INSTRUCTION_IN : IN STD_LOGIC_VECTOR(INST_SIZE-1 downto 0);
        INST_TYPE   : OUT STD_LOGIC_VECTOR(TYPE_BITS_SIZE-1 downto 0)
        INSTRUCTION_OUT : OUT STD_LOGIC_VECTOR(INST_SIZE-1 downto 0);
    );
END FETCH;

architecture LOGICA OF FETCH is
    TYPE INST_TYPE_T IS (
        T_NOP,
        T_R,
        T_MEM,
        T_COND,
        T_J
    );

    TYPE OPCODE_TO_TYPE IS ARRAY(0 TO )
    SIGNAL OP             : STD_LOGIC_VECTOR (OP_BITS_SIZE-1 downto 0);
    SIGNAL REG_POINTER    : integer := 0;
    SIGNAL RS, RT, RD     : STD_LOGIC_VECTOR(REG_ADDR_SIZE-1 downto 0);
    SIGNAL    FUNC        : STD_LOGIC_VECTOR(FUNC_SIZE-1 downto 0);
    SIGNAL    ADDRESS     : STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
    SIGNAL    ADDRESS_EXT : STD_LOGIC_VECTOR(ADDR_EXT_SIZE-1 downto 0);
begin
    
    OP <= INSTRUCTION(INST_SIZE-1 downto INST_SIZE-OP_BITS_SIZE);

    TYPE_R <= '001' WHEN OP = "011" ELSE '0'; --ADD/SUB
    TYPE_MEM <= '1' WHEN OP = "001" OR OP = "010" ELSE '0'; --LW/SW
    TYPE_COND <= '1' WHEN OP = "100" ELSE '0'; --BEQ
    TYPE_J <= '1' WHEN OP = "101" ELSE '0'; --J

    INSTRUCTION_OUT <= INSTRUCTION_IN;

    
END LOGICA;