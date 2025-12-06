library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity text_buffer is
    port (
        clk      : in  std_logic;
        we       : in  std_logic;
        w_addr   : in  integer range 0 to 2399; --write address which cell to update 
        w_data   : in  std_logic_vector(7 downto 0); --ascii code to store for that screen cell
        r_addr   : in  integer range 0 to 2399; --read adress which cell to update 
        r_data   : out std_logic_vector(7 downto 0) --give ascii output which goes to font rom
    );
end text_buffer;

architecture rtl of text_buffer is
    type ram_type is array (0 to 2399) of std_logic_vector(7 downto 0);
    signal ram : ram_type := (others => x"20"); -- fill with spaces
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                ram(w_addr) <= w_data;
            end if;
            r_data <= ram(r_addr);
        end if;
    end process;
end rtl;
