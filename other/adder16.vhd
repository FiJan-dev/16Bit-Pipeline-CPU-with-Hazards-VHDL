library ieee;
use ieee.std_logic_1164.all;
use work.ula_pkg.all;

entity adder16 is 
    port (
        a, b : in  word
        cin  : in  std_logic;
        sum  : out word;
        cout, overflow : out std_logic
    );
end entity adder16;

architecture behavior of adder16 is
    signal c: std_logic_vector(N_BITS downto 0);    -- Vetor de carrys
    signal b_mod: word;
begin
    inverte: for i in 0 to N_BITS-1 generate -- Inversao de b se cin = 1
        b_mod(i) <= b(i) xor cin;
    end generate inverte;

    c(0) <= cin;


    Operacao: for i in 0 to N_BITS-1 generate
        fa_i: fulladder
            port map (
                a    => a(i),
                b    => b_mod(i),
                cin  => c(i),
                sum  => sum(i),
                cout => c(i+1)
            );
    end generate Operacao;

    cout <= c(N_BITS);
    overflow <= c(N_BITS) xor cout;
end behavior;