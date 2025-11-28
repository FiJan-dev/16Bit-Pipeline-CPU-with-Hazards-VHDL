library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DEBOUNCER is
    generic (
        CLK_FREQ  : integer := 50_000_000;
        TIME_MS   : integer := 20
    );
    port (
        CLK      : in  std_logic;
        BUTTON   : in  std_logic;
        CLEAN    : out std_logic
    );
end DEBOUNCER;

architecture COMPORTAMENTO of DEBOUNCER is
    -- Contagem = freq * ms / 1000  → 50e6 * 20 / 1000 = 1_000_000 ciclos
    constant MAX_COUNT : integer := (CLK_FREQ * TIME_MS) / 1000;

    signal counter    : integer range 0 to MAX_COUNT := 0;
    signal btn_sync   : std_logic := '0';
    signal btn_state  : std_logic := '0';
begin

    -- 1) Sincronizar o botão para evitar metastabilidade
    process(CLK)
    begin
        if rising_edge(CLK) then
            btn_sync <= BUTTON;
        end if;
    end process;

    -- 2) Contar enquanto o botão não muda
    process(CLK)
    begin
        if rising_edge(CLK) then
            if btn_sync /= btn_state then
                counter <= 0;  -- mudou? zera a contagem
            elsif counter < MAX_COUNT then
                counter <= counter + 1; -- botão igual = continua contando
            else
                btn_state <= btn_sync;  -- estável por 20ms = atualiza estado
            end if;
        end if;
    end process;

    CLEAN <= btn_state;

end COMPORTAMENTO;
