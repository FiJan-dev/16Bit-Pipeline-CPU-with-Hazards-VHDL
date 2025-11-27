LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY CONTROL_UNITY is
    PORT (
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        OPCODE: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        COMPARE : IN STD_LOGIC;
        FUNC : IN STD_LOGIC;
        --ID
        PC_SRC : OUT STD_LOGIC;
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
END CONTROL_UNITY;

ARCHITECTURE LOGICA OF CONTROL_UNITY is
begin
    process(OPCODE, COMPARE)
    case OPCODE is
        WHEN "011" => --R
            ALUSRC <= '0'; -- RT
            REGDST <= '1'; -- RD
            MEMWRITE <= '0';
            MEMREAD <= '0';
            MEM2REG <= '1'; -- ULAOUT
            REGWRITE <= '1';
        WHEN "100" => --COND AND COMP = 1
            IF COMPARE='1' THEN
                MEMWRITE <= '0';
                MEMREAD <= '0';
                REGWRITE <= '0';
            END IF;
        WHEN "001" => --MEM AND LOAD
            ALUSRC <= '1'; -- IMMEDIATE
            REGDST <= '0'; -- RT
            MEMWRITE <= '0';
            MEMREAD <= '1';
            MEM2REG <= '0'; -- MEM
            REGWRITE <= '1';
        WHEN "010" => --MEM AND WRITE
            ALUSRC <= '1'; -- IMMEDIATE
            REGDST <= '0'; -- RT
            MEMWRITE <= '1';
            MEMREAD <= '0';
            MEM2REG <= '0'; -- MEM
            REGWRITE <= '1';
        WHEN "101" => --J
            PC_SRC <= '2' --ADDRESS
            MEMWRITE <= '0';
            MEMREAD <= '0';
            REGWRITE <= '0';
        WHEN OTHERS =>
            MEMWRITE <= '0';
            MEMREAD <= '0';
            REGWRITE <= '0';
    END CASE;
END LOGICA;