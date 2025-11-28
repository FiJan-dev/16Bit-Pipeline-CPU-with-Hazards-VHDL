LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use work.CPU_package.ALL;

ENTITY REG16 IS PORT(
	rst, clock, enable: IN STD_LOGIC;				--Sinais de Controle
	d: IN DATA_T;	--Data-In
	q: OUT DATA_T);	--Register Data
END REG16;

ARCHITECTURE LOGIC OF REG16 IS
	SIGNAL reg: DATA_T;
BEGIN
	PROCESS (rst, clock)
	BEGIN
		if rst='1' then
			reg <= (others=>'0');
		elsif rising_edge(clock) then
			if enable='1' then
				reg <= d;
			end if;
		end if;
	END PROCESS;
	q <= reg;
END LOGIC;