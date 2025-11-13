library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 


PACKAGE CPU_package is
    constant DATA_SIZE      : integer := 16;
    constant INST_SIZE      : integer := 16;
    constant REG_ADDR_SIZE  : integer := 4;
    constant ADDR_EXT_SIZE  : integer := 13;
    constant ADDR_SIZE      : integer := 5;
    constant OP_BITS_SIZE   : integer := 3;
    constant FUNC_SIZE      : integer := 1;
    constant TYPE_BITS_SIZE : integer := 2;

    SUBTYPE DATA_T is std_logic_vector(DATA_SIZE - 1 downto 0);
    SUBTYPE INST_T is std_logic_vector(INST_SIZE-1 downto 0);
    SUBTYPE REG_ADDR_T is std_logic_vector(REG_ADDR_SIZE-1 downto 0);

    TYPE CTRL_S_T IS RECORD
        REGWRITE : std_logic;
        MEMREAD  : std_logic;
        MEMWRITE : std_logic;
        BRANCH   : std_logic;
        ALUSRC_A : std_logic;
        ALUSRC_B : std_logic;
        ALUOP    : std_logic;
        REGDST   : std_logic;
        JUMP     : std_logic;
        PCSRC    : std_logic;
        FLUSH    : std_logic;
        MEMTOREG : std_logic;
    END RECORD;

END CPU_package;

