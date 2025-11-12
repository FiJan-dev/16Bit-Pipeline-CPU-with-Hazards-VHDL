library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

USE work.CPU_package.all;

ENTITY DECODER is
    PORT(
        INST_T : IN INST_SIZE;
        INSTRUCTION : IN INST_SIZE;
        RS,
    )