library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.CPU_package.all;

ENTITY SIGN_EXT is
    PORT(
        IMMEDIATE : IN STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0);
        IMMEDIATE_EXT : OUT DATA_T
    );
END SIGN_EXT;

architecture LOGICA OF SIGN_EXT is
begin
    IMMEDIATE_EXT <= STD_LOGIC_VECTOR(RESIZE(SIGNED(IMMEDIATE), 16));
END LOGICA;