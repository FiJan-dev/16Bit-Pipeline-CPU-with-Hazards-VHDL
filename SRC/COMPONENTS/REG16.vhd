library ieee;
use ieee.std_logic_1164.all;
use work.CPU_package.all;  -- DATA_T

entity REG16 is
    generic (
        INIT : DATA_T := (others => '0')  -- valor de pré-carga
    );
    port (
        rst, clock, enable: in std_logic;
        d: in DATA_T;
        q: out DATA_T
    );
end entity;

architecture RTL of REG16 is
    signal reg_q : DATA_T := INIT;  
begin
    process(clock, rst)
    begin
        if rst = '1' then
            reg_q <= INIT;              
        elsif rising_edge(clock) then
            if enable = '1' then
                reg_q <= d;
            end if;
        end if;
    end process;

    q <= reg_q;
end architecture;
