LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

USE work.CPU_package.all;

ENTITY CPU is
    PORT (
        CLOCK: IN STD_LOGIC;
        RESET: IN STD_LOGIC;
        --INSTANCIAR CONTEUDO LEDS
    );
END CPU;

ARCHITECTURE COMPOSICAO OF CPU IS
SIGNAL PC              : STD_LOGIC_VECTOR(ADDR_SIZE-1 DOWNTO 0) := (others => '0');

-- Sinais de 16 bits (DATA_T)
SIGNAL PC_BRANCH       : DATA_T := (others => '0');
SIGNAL PC_JUMP			  : DATA_T := (others => '0');
SIGNAL DATA_WB_ID_FU   : DATA_T := (others => '0');
SIGNAL FOWARDING_DATA_MEM : DATA_T := (others => '0');

-- Controle do mux do PC (2 bits)
SIGNAL MUX_PC_SRC      : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

-- Registradores de pipeline (vetores planos - inicializados com zeros)
SIGNAL DATA_IF_ID      : DATA_REG_IF_ID := (others => '0');  -- 32 bits
SIGNAL DATA_ID         : DATA_REG_IF_ID := (others => '0');  -- 32 bits

SIGNAL DATA_ID_EX      : DATA_REG_ID_EX := (others => '0');  -- 67 bits (66 downto 0)
SIGNAL DATA_EX         : DATA_REG_ID_EX := (others => '0');  -- 67 bits

SIGNAL DATA_EX_MEM     : DATA_REG_EX_MEM := (others => '0'); -- 40 bits
SIGNAL DATA_MEM        : DATA_REG_EX_MEM := (others => '0'); -- 40 bits

SIGNAL DATA_MEM_WB     : DATA_REG_MEM_WB := (others => '0'); -- 38 bits
SIGNAL DATA_WB         : DATA_REG_MEM_WB := (others => '0'); -- 38 bits

-- Endereços de registradores (4 bits)
SIGNAL REG_DST         : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
SIGNAL REG_DST_WB      : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
SIGNAL REG_DST_MEM     : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

-- Sinais de controle de 1 bit
SIGNAL REGWRITE        : STD_LOGIC := '0';
SIGNAL MUX_FLUSH_ID    : STD_LOGIC := '0';
SIGNAL MUX_FLUSH_EX    : STD_LOGIC := '0';
SIGNAL REG_WRITE_WB    : STD_LOGIC := '0';
SIGNAL REG_WRITE_MEM   : STD_LOGIC := '0';
	 
begin
    DISPLAY_HEX7 : display PORT MAP(,HEX(7)); --teste
    DISPLAY_HEX6 : display PORT MAP(,HEX(6));
    DISPLAY_HEX5 : display PORT MAP(,HEX(5));
    DISPLAY_HEX4 : display PORT MAP(,HEX(4));
    DISPLAY_HEX3 : display PORT MAP(,HEX(3));
    DISPLAY_HEX2 : display PORT MAP(,HEX(2));
    DISPLAY_HEX1 : display PORT MAP(,HEX(1));
    DISPLAY_HEX0 : display PORT MAP(,HEX(0));
    
    IF_ST: IF_STAGE PORT MAP(CLOCK, RESET, PC_BRANCH, PC_JUMP, MUX_PC_SRC, DATA_IF_ID);
    IF_ID: IFID PORT MAP(CLOCK, RESET, DATA_IF_ID, DATA_ID);
	 
    ID_ST: ID_STAGE PORT MAP(CLOCK, RESET, DATA_WB_ID_FU, REG_DST, REGWRITE, DATA_ID, DATA_ID_EX);
    ID_EX: IDEX PORT MAP(CLOCK, RESET, MUX_FLUSH_ID, DATA_ID_EX, DATA_EX);
	 
    EX: EX_STAGE PORT MAP(CLOCK, RESET, REG_DST_WB, REG_DST_MEM, REG_WRITE_WB, REG_WRITE_MEM, DATA_WB_ID_FU, FOWARDING_DATA_MEM, DATA_EX, DATA_EX_MEM);
	 
    EX_MEM: EXMEM PORT MAP(CLOCK, RESET, MUX_FLUSH_EX, DATA_EX_MEM, DATA_MEM);
	 
    MEM_ST: MEM_STAGE PORT MAP(CLOCK, RESET, DATA_MEM, DATA_MEM_WB, FOWARDING_DATA_MEM, REG_WRITE_MEM, REG_DST_MEM);
	 
    MEM_WB: MEMWB PORT MAP(CLOCK, RESET, DATA_MEM_WB, DATA_WB);
    WB_ST: WB_STAGE PORT MAP(CLOCK, RESET, DATA_WB, REGWRITE, DATA_WB_ID_FU, REG_DST_WB);
END COMPOSICAO;