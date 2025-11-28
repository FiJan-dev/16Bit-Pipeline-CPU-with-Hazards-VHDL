LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ADDER IS
	PORT (
	Cin : IN STD_LOGIC;
	BitB , BitA  : IN STD_LOGIC;
	S, Cout : OUT STD_LOGIC);
END ADDER;

ARCHITECTURE logica OF ADDER IS 
	BEGIN 
		S <= Cin XOR BitB XOR BitA;
		Cout <= (BitB AND BitA) OR (Cin AND (BitB XOR BitA));
	END logica;