library ieee;
use ieee.std_logic_1164.all;

package ula_pkg is

    constant N_BITS : integer := 16;

    subtype word is std_logic_vector(N_BITS-1 downto 0);

    component adder16
        port (
            a, b : in  std_logic_vector(N_BITS-1 downto 0);
            cin  : in  std_logic;
            sum  : out std_logic_vector(N_BITS-1  downto 0);
            cout : out std_logic
        );
    end component adder16;

    component fulladder
        port (
            a, b : in  std_logic;
            cin  : in  std_logic;
            sum, cout  : out std_logic;
        );
    end component fulladder;