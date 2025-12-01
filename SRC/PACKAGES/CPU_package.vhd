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
    constant PC_INCREMENT   : std_logic_vector(DATA_SIZE - 1 downto 0) := x"0001";      

    SUBTYPE DATA_T is std_logic_vector(DATA_SIZE - 1 downto 0);
    SUBTYPE INST_T is std_logic_vector(INST_SIZE-1 downto 0);
    SUBTYPE REG_ADDR_T is std_logic_vector(REG_ADDR_SIZE-1 downto 0);
	 
	 SUBTYPE DISPLAY_T IS STD_LOGIC_VECTOR(0 TO 6);

    SUBTYPE DATA_REG_IF_ID IS STD_LOGIC_VECTOR(31 DOWNTO 0);
    SUBTYPE DATA_REG_ID_EX IS STD_LOGIC_VECTOR(66 DOWNTO 0);
    SUBTYPE DATA_REG_EX_MEM IS STD_LOGIC_VECTOR(39 DOWNTO 0);
    SUBTYPE DATA_REG_MEM_WB IS STD_LOGIC_VECTOR(37 DOWNTO 0);

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
	 
	 COMPONENT CPU
		PORT (
        CLOCK	: IN STD_LOGIC;
        RESET	: IN STD_LOGIC;
        HEX7	: OUT DISPLAY_T;
		  HEX6   : OUT DISPLAY_T;
		  HEX5   : OUT DISPLAY_T;
		  HEX4   : OUT DISPLAY_T;
		  HEX3   : OUT DISPLAY_T;
		  HEX2   : OUT DISPLAY_T;
		  HEX1   : OUT DISPLAY_T;
		  HEX0   : OUT DISPLAY_T
		);
	 END COMPONENT;
	 
	 COMPONENT REG16
		PORT(
			rst, clock, enable: IN STD_LOGIC;				--Sinais de Controle
			d: IN DATA_T;	--Data-In
			q: OUT DATA_T);	--Register Data
	END COMPONENT;
	 
    -- Banco de registradores
    COMPONENT REGBANK
        PORT(
            CLOCK, RESET, REGWRITE : std_logic;
            RS, RT, RD : IN REG_ADDR_T;
            WRITEDATA : IN DATA_T;
            RSDATA, RTDATA: OUT DATA_T
        );
    END COMPONENT;
    
    -- ULA
    COMPONENT ULA
        PORT (
            Cin : IN STD_LOGIC; 
            B: IN STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0); 
            A: IN STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0);
            Cout, Overflow : OUT STD_LOGIC
        );
    END COMPONENT;

    -- ADDER
    COMPONENT ADDER
        PORT (
            Cin : IN STD_LOGIC;
            BitB , BitA  : IN STD_LOGIC;
            S, Cout : OUT STD_LOGIC
        );
    END COMPONENT;

    -- MEMORIA DE DADO
    COMPONENT MEMORY_DATA
        PORT (
            CLOCK : IN  STD_LOGIC;
            RESET     : IN  STD_LOGIC;
            MEM_WRITE : IN  STD_LOGIC;
            MEM_READ  : IN  STD_LOGIC;
            ADDRESS   : IN  DATA_T;
            WRITE_DATA: IN  DATA_T;
            READ_DATA : OUT DATA_T
        );
    END COMPONENT;
	 
	 COMPONENT MEMORY_INST
		PORT(
        ADDRESS: IN DATA_T;
        INSTRUCTION: OUT INST_T
		);
	 END COMPONENT;

    COMPONENT SIGN_EXT
        PORT(
            IMMEDIATE : IN STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
            IMMEDIATE_EXT : OUT DATA_T
        );
    END COMPONENT;

    COMPONENT DISPLAY
	PORT(   SW : IN STD_LOGIC_VECTOR (3 DOWNTO 0);	-- Configuração do Display para a vizualização dos números e letras
            HEX :OUT DISPLAY_T);
    END COMPONENT;

    COMPONENT CONTROL_UNITY
        PORT(
            CLOCK : IN STD_LOGIC;
            RESET : IN STD_LOGIC;
            OPCODE : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            COMPARE : IN STD_LOGIC;
            FUNC : IN STD_LOGIC;
            --ID
            PC_SRC : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            --EX
            ALUSRC : OUT STD_LOGIC;
            REGDST : OUT STD_LOGIC;
            --MEM
            MEMWRITE : OUT STD_LOGIC;
            MEMREAD : OUT STD_LOGIC;
            --WB
            MEM2REG : OUT STD_LOGIC;
            REGWRITE : OUT STD_LOGIC
            --ADICONAR CONTROLE DA ULA PRA OP
        );
    END COMPONENT;

    -- Unidade de adiantamento
    COMPONENT FORWARDING_UNIT
		PORT (
			CLOCK : IN STD_LOGIC;
			RESET : IN STD_LOGIC;
			--EX
			RS : IN STD_LOGIC_VECTOR(3 DOWNTO 0); --PASSAR RS (3 DOWNTO 0) PARA REGS ID/EX
			RT : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			--MEM
			REGWRITE_MEM : IN STD_LOGIC;
			REGDST_MEM : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			--WB
			REGWRITE_WB : IN STD_LOGIC;
			REGDST_WB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

			FOWARD_A : OUT STD_LOGIC;
			FOWARD_B : OUT STD_LOGIC
			);
	END COMPONENT;

    COMPONENT IFID
        PORT (
			  CLOCK : IN STD_LOGIC;
			  RESET : IN STD_LOGIC;
			  DATA_IN : IN DATA_REG_IF_ID;
			  DATA_OUT : OUT DATA_REG_IF_ID
        );  
    END COMPONENT;

    COMPONENT IDEX
        PORT (
           CLOCK : IN STD_LOGIC;
			  RESET : IN STD_LOGIC;
			  FLUSH: IN STD_LOGIC;
			  DATA_IN : IN DATA_REG_ID_EX;
			  DATA_OUT : OUT DATA_REG_ID_EX
        );
    END COMPONENT;

    COMPONENT EXMEM
        PORT (
           CLOCK : IN STD_LOGIC;
			  RESET : IN STD_LOGIC;
			  FLUSH: IN STD_LOGIC;
			  DATA_IN : IN DATA_REG_EX_MEM;
			  DATA_OUT : OUT DATA_REG_EX_MEM
        );
    END COMPONENT;

    COMPONENT MEMWB
        PORT (
           CLOCK : IN STD_LOGIC;
			  RESET : IN STD_LOGIC;
			  DATA_IN : IN DATA_REG_MEM_WB;
			  DATA_OUT : OUT DATA_REG_MEM_WB
        );
    END COMPONENT;
	 
	 COMPONENT COMPARATOR
		port (
        A       : in  DATA_T;
        B       : in  DATA_T;
        EQ  : out std_logic
		);
	 END COMPONENT;
	 
	 COMPONENT SHIFT_LEFT_2
		PORT(
        IMMEDIATE_EXT : IN DATA_T;
        IMMEDIATE_SHIFTED : OUT DATA_T
		);
	 END COMPONENT;
	 
	 COMPONENT FOWARDING_UNITY
		PORT (
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        --EX
        RS : IN STD_LOGIC_VECTOR(3 DOWNTO 0); --PASSAR RS (3 DOWNTO 0) PARA REGS ID/EX
        RT : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        --MEM
        REGWRITE_MEM : IN STD_LOGIC;
        REGDST_MEM : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        --WB
        REGWRITE_WB : IN STD_LOGIC;
        REGDST_WB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        FOWARD_A : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
        FOWARD_B : OUT  STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT IF_STAGE
		PORT (
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
		  PC_IN : IN DATA_T;
        PC_BRANCH : IN DATA_T;
        PC_JUMP : IN DATA_T;
        MUX_PC_SRC: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        DATA_IF_ID : OUT DATA_REG_IF_ID;
		  NEXT_PC_OUT: OUT DATA_T
    );
	END COMPONENT;
	
	COMPONENT ID_STAGE
		PORT (
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        DATA_WB: IN DATA_T;
        REG_DST_ADDRESS : IN STD_LOGIC_VECTOR(REG_ADDR_SIZE-1 DOWNTO 0);-- DATA_ID, DATA_ID_EX
        REGWRITE_WB : IN STD_LOGIC;
        DATA_IN: IN DATA_REG_IF_ID;
        DATA_OUT: OUT DATA_REG_ID_EX;
        PC_SRC : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        JUMP_ADDR : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
        BRANCH_ADDRESS : OUT DATA_T
		);
	END COMPONENT;
	
	COMPONENT EX_STAGE
		PORT (
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        REG_DST_WB, REG_DST_MEM : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        REG_WRITE_WB, REG_WRITE_MEM  : IN STD_LOGIC;
		  DATA_WB, DATA_MEM: IN DATA_T;
        DATA_IN : IN DATA_REG_ID_EX;
        DATA_OUT: OUT DATA_REG_EX_MEM
		);
	END COMPONENT;
	
	COMPONENT MEM_STAGE
		PORT(
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        DATA_IN : IN DATA_REG_EX_MEM;
        DATA_OUT: OUT DATA_REG_MEM_WB;
		  DATA_FOWARD_EX: OUT DATA_T;
		  REG_WRITE_FU : STD_LOGIC;
		  REG_DST : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
	END COMPONENT;
	
	COMPONENT WB_STAGE
		PORT(
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        DATA_IN : IN DATA_REG_MEM_WB;
        REGWRITE : OUT STD_LOGIC;
        DATA_WB_ID : OUT DATA_T;
        REG_DST: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;
	
END CPU_package;

