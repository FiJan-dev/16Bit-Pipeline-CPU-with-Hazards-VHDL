library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.CPU_package.all;

entity MEMORY_INST is
    port (
        ADDRESS		 : in  DATA_T;
        INSTRUCTION   : out INST_T
    );
end entity;

architecture LOGICA of MEMORY_INST is
    constant TAM_MEM : integer := 2 ** ADDR_SIZE;
    type ROM_TYPE is array (0 to TAM_MEM-1) of INST_T;

    signal ROM : ROM_TYPE := (
        0  => x"6CA2", -- add r5,r1,r6
        1  => x"7445", -- sub r2,r2,r10
        2  => x"0162", -- lw  r0,2(r6)
        3  => x"0000", -- nop
        4  => x"20C0", -- sw r1,0(r6)
        5  => x"2F04", -- lw r15,4(r6)
        6  => x"A001", -- jump 1
        7  => x"2101", -- add r1,r1,r1
        8  => x"A00D", -- j 13
        9  => x"6C22", -- add r1,r1,r6
        10 => x"0000", -- nop
        11 => x"0000", -- nop
        12 => x"A00F", -- j 15
        13 => x"0000", -- nop
        14 => x"8C49", -- beq r2,r6,9
        15 => x"0000", -- nop
        others => (others => '0')
);

begin
    INSTRUCTION <= ROM(to_integer(unsigned(ADDRESS)));
end architecture;
