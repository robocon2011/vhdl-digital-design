-- single port M-bit x N-bit RAM
--   read first / write first
--   block RAM (sync read)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bram is
generic(
    M : integer := 10;
    N : integer := 32
);
port(
    clk  : in  std_logic;
    we   : in  std_logic;
    addr : in  std_logic_vector(M - 1 downto 0);
    din  : in  std_logic_vector(N - 1 downto 0);
    dout : out std_logic_vector(N - 1 downto 0)
);
end bram;

architecture rtl of bram is
    type ram_type is array(0 to 2**M - 1) of std_logic_vector(N - 1 downto 0);
    signal RAM : ram_type := (others => (others => '0'));
begin

    process(clk) is
    begin
        if rising_edge(clk) then
            if we = '1' then
                RAM(to_integer(unsigned(addr))) <= din;
                --  dout <= din; -- optional, write first
            end if;
            dout <= RAM(to_integer(unsigned(addr)));
        end if;
    end process;

end rtl;