library ieee;
use ieee.std_logic_1164.all;

entity fulladder is
    port (
        a, b : in  std_logic;
        cin  : in  std_logic;
        sum, cout  : out std_logic;
    );
end entity fulladder;

architecture behavior of fulladder is
begin
    sum <= a xor b xor cin;
    cout <= (a and b) or (cin and (a xor b));
end behavior;