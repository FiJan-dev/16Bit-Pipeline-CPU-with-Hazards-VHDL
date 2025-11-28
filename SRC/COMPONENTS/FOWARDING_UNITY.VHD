LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY FOWARDING_UNITY is
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
END FOWARDING_UNITY;

ARCHITECTURE COMPORTAMENTO OF FOWARDING_UNITY IS
BEGIN
    PROCESS(CLOCK, RESET)
    BEGIN
        IF  (REGWRITE_MEM = '1' AND REGDST_MEM /= "0000") AND (REGDST_MEM = RS) THEN
            FOWARD_A <= "10";
        ELSE
            FOWARD_A <= "00";
        END IF;
		  

        IF  (REGWRITE_MEM = '1' AND REGDST_MEM /= "0000") AND (REGDST_MEM = RT) THEN
            FOWARD_B <= "10";
        ELSE
            FOWARD_B <= "00";
        END IF;
		  

        IF (REGWRITE_WB = '1' AND REGDST_WB /= "0000") AND (REGDST_WB = RS) AND NOT (REGWRITE_MEM = '1' AND REGDST_MEM /= "0000") AND (REGDST_MEM = RS)  THEN
            FOWARD_A <= "01";
        ELSE
            FOWARD_A <= "00";
        END IF;
		  

        IF (REGWRITE_WB = '1' AND REGDST_WB /= "0000") AND (REGDST_WB = RT) AND NOT (REGWRITE_MEM = '1' AND REGDST_MEM /= "0000") AND (REGDST_MEM = RT)  THEN
            FOWARD_B <= "01";
        ELSE
            FOWARD_B <= "00";
        END IF;
		  
	END PROCESS;
END COMPORTAMENTO;