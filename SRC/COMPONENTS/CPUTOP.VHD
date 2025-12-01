LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE WORK.CPU_package.ALL;

ENTITY CPUTOP is
    PORT(
        CLOCK_50 : IN STD_LOGIC;
        SW       : IN STD_LOGIC_VECTOR(16 DOWNTO 0);
        KEY      : IN STD_LOGIC_VECTOR(3 DOWNTO 0);               
        LEDG     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        HEX7     : OUT DISPLAY_T;
		  HEX6     : OUT DISPLAY_T;
		  HEX5     : OUT DISPLAY_T;
		  HEX4     : OUT DISPLAY_T;
		  HEX3     : OUT DISPLAY_T;
		  HEX2     : OUT DISPLAY_T;
		  HEX1     : OUT DISPLAY_T;
		  HEX0     : OUT DISPLAY_T
    );
END CPUTOP;

ARCHITECTURE LOGICA OF CPUTOP is
    SIGNAL RESET      : STD_LOGIC;
    SIGNAL CLOCK      : STD_LOGIC;
	 SIGNAL key_sync_0, key_sync_1, key_prev : STD_LOGIC;
begin

    process(CLOCK_50)
	 begin
		if rising_edge(CLOCK_50) then
			key_sync_0 <= KEY(3);
			key_sync_1 <= key_sync_0;
			if (key_prev = '1') and (key_sync_1 = '0') then
				CLOCK <= '1';
			ELSE
				CLOCK <= '0';
			END IF;
			key_prev <= key_sync_1;
		END IF;
	END PROCESS;
	 
    RESET <= SW(16);
	 LEDG(0) <= RESET;
	 

    
    MAIN_CPU : CPU PORT MAP(
        CLOCK,
        RESET,
        HEX7,
		  HEX6,
		  HEX5,
		  HEX4,
		  HEX3,
		  HEX2,
		  HEX1,
		  HEX0
    );

    LEDG(7) <= CLOCK;
    LEDG(6 downto 1) <= (others => '0');                 

END LOGICA;
