LIBRARY ieee;
USE ieee.std_logic_1164.all;

USE work.CPU_package.all;

ENTITY ULA IS
PORT (
	Cin : IN STD_LOGIC; --entrada do carry para definir soma ou sub
	B: IN STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0); -- registradores que irao ser somados
	A: IN STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0);
	S : OUT STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0); -- resultado da soma/sub e cout = carry da soma/sub
	Cout, Overflow : OUT STD_LOGIC);
END ULA;

ARCHITECTURE logica OF ULA IS	
	SIGNAL Carry : STD_LOGIC_VECTOR(0 TO DATA_SIZE); --carry que é carregado de uma soma para outra
	SIGNAL NOT_A : STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0); -- variavel para caso seja uma sub poder tratar ela como uma soma com um numero negativo
	SIGNAL INTERNAL_COUT : STD_LOGIC;
BEGIN 
    NOT_A <= A XOR (DATA_SIZE-1 downto 0 => Cin);

    Carry(0) <= Cin;

    ADDERS: FOR i IN 0 to DATA_SIZE-1 generate
        ADDER_i : ADDER
            PORT MAP(
                Cin  => carry(i),
                BitB => NOT_A(i),
                BitA => B(i),
					 S    => S(i),
                Cout => Carry(i+1)
            );
    end generate;	
	
	Cout <= Carry(DATA_SIZE);
	Overflow <= Carry(DATA_SIZE-1) XOR Carry(DATA_SIZE);
	
END logica;


--COMO USAR:
--signal alu_result : std_logic_vector(15 downto 0);
--signal alu_ovf    : std_logic;
--
--ula : entity work.alu_generic generic map (DATA_SIZE => 16)
--    port map (
--        Cin      => func,         -- '0' = ADD, '1' = SUB
--        A        => rs_val,
--        B        => rt_val,
--        S        => alu_result,
--        Cout     => open,
--        Overflow => alu_ovf
--    );