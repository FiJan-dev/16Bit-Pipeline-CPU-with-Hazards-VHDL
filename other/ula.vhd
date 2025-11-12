library ieee;
use ieee.std_logic_1164.all;
use work.ula_pkg.all;

entity ula is
    port (
        a, b: in word;
        alu_op: in std_logic;   -- 0: ADD, 1: SUB
        result: out word;
        cout, overflow, zero: out std_logic
    );
end entity ula;

architecture behavior of ula is
    signal sum_result: word;
    signal carry_out: std_logic;
    signal overflow_interno: std_logic;
begin
    adder: adder16
        port map (
            a    => a,
            b    => b,
            cin  => alu_op,
            sum  => sum_result,
            cout => carry_out,
            overflow => overflow_interno
        );
    
    -------------------------------------------------------------------
    -- Sinais principais
    -------------------------------------------------------------------
    result <= sum_result;
    Cout <= carry_out;
    overflow <= overflow_internal;

    -------------------------------------------------------------------
    -- Sinal de zero
    -------------------------------------------------------------------
    zero <= '1' when sum_result = (others => '0') else '0';

end behavior;