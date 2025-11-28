library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.CPU_package.all;

ENTITY REGBANK is
    PORT(
        CLOCK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        REGWRITE : std_logic;
        RS, RT, RD : IN REG_ADDR_T;
        WRITEDATA : IN DATA_T;
        RSDATA, RTDATA: OUT DATA_T
    );
END REGBANK;

ARCHITECTURE LOGICA OF REGBANK is

    component REG16
        port (
            rst, clock, enable: IN STD_LOGIC;
            d: IN DATA_T;		
	        q: OUT DATA_T);
    end component;

    TYPE REG_ARRAY IS ARRAY(0 TO 15) OF DATA_T;
	 
    -- ==========================
    -- PRÉ-CARGA DOS REGISTRADORES
    -- ==========================
    SIGNAL REGS_OUT: REG_ARRAY := (
        1  => x"0046",  -- r1  = 70
        6  => x"0016",  -- r6  = 22
        10 => x"001E",  -- r10 = 30
        2  => x"000C",  -- r2  = 12 (teste branch depois)
        3  => x"0001",  -- r3  = 1  (para dependências rápidas)
        7  => x"00F0",  -- r7  = 240 (teste de forwarding)
        15 => x"0008",  -- r15 = 8  (teste jumps, registers altos)
        OTHERS => (OTHERS => '0')
    );
	 
	 
	 
    SIGNAL WRITE_ENABLE: DATA_T;
begin

    -- Decoder de escrita
    PROCESS (RD, REGWRITE)
    begin
        WRITE_ENABLE <= (OTHERS => '0');
        IF REGWRITE = '1' THEN
            CASE RD is
                WHEN "0000" => WRITE_ENABLE(0) <= '1';
                WHEN "0001" => WRITE_ENABLE(1) <= '1';
                WHEN "0010" => WRITE_ENABLE(2) <= '1';
                WHEN "0011" => WRITE_ENABLE(3) <= '1';
                WHEN "0100" => WRITE_ENABLE(4) <= '1';
                WHEN "0101" => WRITE_ENABLE(5) <= '1';
                WHEN "0110" => WRITE_ENABLE(6) <= '1';
                WHEN "0111" => WRITE_ENABLE(7) <= '1';
                WHEN "1000" => WRITE_ENABLE(8) <= '1';
                WHEN "1001" => WRITE_ENABLE(9) <= '1';
                WHEN "1010" => WRITE_ENABLE(10) <= '1';
                WHEN "1011" => WRITE_ENABLE(11) <= '1';
                WHEN "1100" => WRITE_ENABLE(12) <= '1';
                WHEN "1101" => WRITE_ENABLE(13) <= '1';
                WHEN "1110" => WRITE_ENABLE(14) <= '1';
                WHEN "1111" => WRITE_ENABLE(15) <= '1';
                WHEN OTHERS => NULL;
            END CASE;
        END IF;
    END PROCESS;

    GEN_REGS: FOR i IN 0 TO 15 GENERATE
        REG_i: REG16
            PORT MAP (
                rst     => RESET,
                clock   => CLOCK,
                enable  => WRITE_ENABLE(i),
                d       => WRITEDATA,
                q       => REGS_OUT(i)
            );
    END GENERATE;

    -- Mux de leitura RS
    PROCESS(RS, REGS_OUT)
    begin
        CASE RS is
            WHEN "0000" => RSDATA <= REGS_OUT(0);
            WHEN "0001" => RSDATA <= REGS_OUT(1);
            WHEN "0010" => RSDATA <= REGS_OUT(2);
            WHEN "0011" => RSDATA <= REGS_OUT(3);
            WHEN "0100" => RSDATA <= REGS_OUT(4);
            WHEN "0101" => RSDATA <= REGS_OUT(5);
            WHEN "0110" => RSDATA <= REGS_OUT(6);
            WHEN "0111" => RSDATA <= REGS_OUT(7);
            WHEN "1000" => RSDATA <= REGS_OUT(8);
            WHEN "1001" => RSDATA <= REGS_OUT(9);
            WHEN "1010" => RSDATA <= REGS_OUT(10);
            WHEN "1011" => RSDATA <= REGS_OUT(11);
            WHEN "1100" => RSDATA <= REGS_OUT(12);
            WHEN "1101" => RSDATA <= REGS_OUT(13);
            WHEN "1110" => RSDATA <= REGS_OUT(14);
            WHEN "1111" => RSDATA <= REGS_OUT(15);
            WHEN OTHERS => RSDATA <= (OTHERS => '0');
        END CASE;
    END PROCESS;

    --Mux de leitura RT
    PROCESS(RT, REGS_OUT)
    begin
        CASE RT is
            WHEN "0000" => RTDATA <= REGS_OUT(0);
            WHEN "0001" => RTDATA <= REGS_OUT(1);
            WHEN "0010" => RTDATA <= REGS_OUT(2);
            WHEN "0011" => RTDATA <= REGS_OUT(3);   
            WHEN "0100" => RTDATA <= REGS_OUT(4);
            WHEN "0101" => RTDATA <= REGS_OUT(5);
            WHEN "0110" => RTDATA <= REGS_OUT(6);
            WHEN "0111" => RTDATA <= REGS_OUT(7);
            WHEN "1000" => RTDATA <= REGS_OUT(8);
            WHEN "1001" => RTDATA <= REGS_OUT(9);
            WHEN "1010" => RTDATA <= REGS_OUT(10);
            WHEN "1011" => RTDATA <= REGS_OUT(11);
            WHEN "1100" => RTDATA <= REGS_OUT(12);
            WHEN "1101" => RTDATA <= REGS_OUT(13);
            WHEN "1110" => RTDATA <= REGS_OUT(14);
            WHEN "1111" => RTDATA <= REGS_OUT(15);
            WHEN OTHERS => RTDATA <= (OTHERS => '0');
        END CASE;
    END PROCESS;
END LOGICA;
            
