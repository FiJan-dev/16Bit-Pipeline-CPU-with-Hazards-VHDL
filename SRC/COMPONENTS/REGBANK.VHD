library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.CPU_package.all;

entity REGBANK is
    port(
        CLOCK    : in  std_logic;
        RESET    : in  std_logic;
        REGWRITE : in  std_logic;
        RS, RT, RD : in REG_ADDR_T;
        WRITEDATA  : in DATA_T;
        RSDATA, RTDATA : out DATA_T
    );
end REGBANK;

architecture LOGICA of REGBANK is

    component REG16
        generic (
            INIT : DATA_T := (others => '0')
        );
        port (
            rst, clock, enable: in std_logic;
            d: in DATA_T;
            q: out DATA_T
        );
    end component;

    type REG_ARRAY is array (0 to 15) of DATA_T;

    -- Tabela com os valores de pré-carga
    constant INIT_REGS : REG_ARRAY := (
        1  => x"0002",  -- r1  = 2
        6  => x"0004",  -- r6  = 4
        10 => x"001E",  -- r10 = 30
        2  => x"000C",  -- r2  = 12
        3  => x"0001",  -- r3  = 1
        7  => x"00F0",  -- r7  = 240
        15 => x"0008",  -- r15 = 8
        others => (others => '0')
    );

    signal REGS_OUT : REG_ARRAY;
    signal WRITE_ENABLE : DATA_T;  

begin

    -- Decoder de escrita
    process (RD, REGWRITE)
    begin
        WRITE_ENABLE <= (others => '0');
        if REGWRITE = '1' then
            case RD is
                when "0000" => WRITE_ENABLE(0)  <= '1';
                when "0001" => WRITE_ENABLE(1)  <= '1';
                when "0010" => WRITE_ENABLE(2)  <= '1';
                when "0011" => WRITE_ENABLE(3)  <= '1';
                when "0100" => WRITE_ENABLE(4)  <= '1';
                when "0101" => WRITE_ENABLE(5)  <= '1';
                when "0110" => WRITE_ENABLE(6)  <= '1';
                when "0111" => WRITE_ENABLE(7)  <= '1';
                when "1000" => WRITE_ENABLE(8)  <= '1';
                when "1001" => WRITE_ENABLE(9)  <= '1';
                when "1010" => WRITE_ENABLE(10) <= '1';
                when "1011" => WRITE_ENABLE(11) <= '1';
                when "1100" => WRITE_ENABLE(12) <= '1';
                when "1101" => WRITE_ENABLE(13) <= '1';
                when "1110" => WRITE_ENABLE(14) <= '1';
                when "1111" => WRITE_ENABLE(15) <= '1';
                when others => null;
            end case;
        end if;
    end process;

    -- Geração dos 16 registradores
    GEN_REGS: for i in 0 to 15 generate
    begin
        REG_i: REG16
            generic map (
                INIT => INIT_REGS(i) 
            )
            port map (
                rst     => RESET,
                clock   => CLOCK,
                enable  => WRITE_ENABLE(i),
                d       => WRITEDATA,
                q       => REGS_OUT(i)
            );
    end generate;

    -- Mux de leitura RS
    process(RS, REGS_OUT)
    begin
        case RS is
            when "0000" => RSDATA <= REGS_OUT(0);
            when "0001" => RSDATA <= REGS_OUT(1);
            when "0010" => RSDATA <= REGS_OUT(2);
            when "0011" => RSDATA <= REGS_OUT(3);
            when "0100" => RSDATA <= REGS_OUT(4);
            when "0101" => RSDATA <= REGS_OUT(5);
            when "0110" => RSDATA <= REGS_OUT(6);
            when "0111" => RSDATA <= REGS_OUT(7);
            when "1000" => RSDATA <= REGS_OUT(8);
            when "1001" => RSDATA <= REGS_OUT(9);
            when "1010" => RSDATA <= REGS_OUT(10);
            when "1011" => RSDATA <= REGS_OUT(11);
            when "1100" => RSDATA <= REGS_OUT(12);
            when "1101" => RSDATA <= REGS_OUT(13);
            when "1110" => RSDATA <= REGS_OUT(14);
            when "1111" => RSDATA <= REGS_OUT(15);
            when others => RSDATA <= (others => '0');
        end case;
    end process;

    -- Mux de leitura RT
    process(RT, REGS_OUT)
    begin
        case RT is
            when "0000" => RTDATA <= REGS_OUT(0);
            when "0001" => RTDATA <= REGS_OUT(1);
            when "0010" => RTDATA <= REGS_OUT(2);
            when "0011" => RTDATA <= REGS_OUT(3);
            when "0100" => RTDATA <= REGS_OUT(4);
            when "0101" => RTDATA <= REGS_OUT(5);
            when "0110" => RTDATA <= REGS_OUT(6);
            when "0111" => RTDATA <= REGS_OUT(7);
            when "1000" => RTDATA <= REGS_OUT(8);
            when "1001" => RTDATA <= REGS_OUT(9);
            when "1010" => RTDATA <= REGS_OUT(10);
            when "1011" => RTDATA <= REGS_OUT(11);
            when "1100" => RTDATA <= REGS_OUT(12);
            when "1101" => RTDATA <= REGS_OUT(13);
            when "1110" => RTDATA <= REGS_OUT(14);
            when "1111" => RTDATA <= REGS_OUT(15);
            when others => RTDATA <= (others => '0');
        end case;
    end process;

end LOGICA;
