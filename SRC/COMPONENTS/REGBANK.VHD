library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

USE work.CPU_package.all;

ENTITY REGBANK is
    PORT(
        CLOCK, RESET, REGWRITE : std_logic;
        RS, RT, RD : IN REG_ADDR_T;
        WRITEDATA : IN DATA_T;
        RSDATA, RTDATA: OUT DATA_T
    );
END REGBANK;

ARCHITECTURE LOGICA OF REGBANK is
    TYPE REG_ARRAY IS ARRAY(0 TO 15) OF DATA_T;
    SIGNAL REGS: REG_ARRAY := (OTHERS => (OTHERS => '0'));
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

    -- Registradores
    PROCESS(CLOCK, RESET)
    begin
        IF RESET = '1' THEN
            REGS <= (OTHERS => (OTHERS => '0'));
        ELSIF RISING_EDGE(CLOCK) THEN
            for i in 0 to 15 loop
                IF WRITE_ENABLE(i) = '1' THEN
                    REGS(i) <= WRITEDATA;
                END IF;
            END LOOP;
        END IF;
    END PROCESS;

    -- Mux de leitura RS
    PROCESS(RS,REGS)
    begin
        CASE RS is
            WHEN "0000" => RSDATA <= REGS(0);
            WHEN "0001" => RSDATA <= REGS(1);
            WHEN "0010" => RSDATA <= REGS(2);
            WHEN "0011" => RSDATA <= REGS(3);
            WHEN "0100" => RSDATA <= REGS(4);
            WHEN "0101" => RSDATA <= REGS(5);
            WHEN "0110" => RSDATA <= REGS(6);
            WHEN "0111" => RSDATA <= REGS(7);
            WHEN "1000" => RSDATA <= REGS(8);
            WHEN "1001" => RSDATA <= REGS(9);
            WHEN "1010" => RSDATA <= REGS(10);
            WHEN "1011" => RSDATA <= REGS(11);
            WHEN "1100" => RSDATA <= REGS(12);
            WHEN "1101" => RSDATA <= REGS(13);
            WHEN "1110" => RSDATA <= REGS(14);
            WHEN "1111" => RSDATA <= REGS(15);
            WHEN OTHERS => RSDATA <= (OTHERS => '0');
        END CASE;
    END PROCESS;

    --Mux de leitura RT
    PROCESS(RT,REGS)
    begin
        CASE RT is
            WHEN "0000" => RTDATA <= REGS(0);
            WHEN "0001" => RTDATA <= REGS(1);
            WHEN "0010" => RTDATA <= REGS(2);
            WHEN "0011" => RTDATA <= REGS(3);   
            WHEN "0100" => RTDATA <= REGS(4);
            WHEN "0101" => RTDATA <= REGS(5);
            WHEN "0110" => RTDATA <= REGS(6);
            WHEN "0111" => RTDATA <= REGS(7);
            WHEN "1000" => RTDATA <= REGS(8);
            WHEN "1001" => RTDATA <= REGS(9);
            WHEN "1010" => RTDATA <= REGS(10);
            WHEN "1011" => RTDATA <= REGS(11);
            WHEN "1100" => RTDATA <= REGS(12);
            WHEN "1101" => RTDATA <= REGS(13);
            WHEN "1110" => RTDATA <= REGS(14);
            WHEN "1111" => RTDATA <= REGS(15);
            WHEN OTHERS => RTDATA <= (OTHERS => '0');
        END CASE;
    END PROCESS;
END LOGICA;
            
