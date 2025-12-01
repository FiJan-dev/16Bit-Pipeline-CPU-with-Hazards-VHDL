library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.CPU_package.all;

entity CPU_TOP_tb is
end CPU_TOP_tb;

architecture sim of CPU_TOP_tb is
    -- Entradas do topo
    signal CLOCK_50 : std_logic := '0';
    signal SW  : std_logic_vector(16 downto 0) := (others => '0');
    signal KEY : std_logic_vector(3 downto 0)  := (others => '1');

    -- Saídas (para observar se quiser)
    signal LEDG : std_logic_vector(7 downto 0);
    signal HEX7 : DISPLAY_T;

    constant CLK_PERIOD : time := 10 ns;
begin

    -- Instancia o topo (DUT)
    DUT: entity work.CPUTOP
        port map(
            CLOCK_50 => CLOCK_50,
            SW  => SW,
            KEY => KEY,
            LEDG => LEDG,
            HEX7 => HEX7
        );

    -- Gera clock 50MHz fictício (não usado diretamente pela CPU, mas mantém top feliz)
    process
    begin
        while true loop
            CLOCK_50 <= '0';
            wait for CLK_PERIOD/2;
            CLOCK_50 <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    -- Estímulos
    process
    begin
        -- Aplica RESET via chave SW(16)
        SW(16) <= '1';
        wait for 30 ns;
        SW(16) <= '0';

        -- Gera clock da CPU via KEY(3)
        loop
            KEY(3) <= '1';  -- clock interno = NOT KEY3 = 0
            wait for 20 ns;
            KEY(3) <= '0';  -- clock interno = NOT KEY3 = 1
            wait for 20 ns;
        end loop;
    end process;

end architecture;
