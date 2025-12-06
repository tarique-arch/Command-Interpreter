library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_text_display is
    port (
        clk25    : in  std_logic;  -- 25 MHz pixel clock
        h_sync   : out std_logic;
        v_sync   : out std_logic;
        vga_r, vga_g, vga_b : out std_logic
    );
end vga_text_display;

architecture rtl of vga_text_display is

    -- VGA timing
    signal h_count, v_count : integer range 0 to 799;
    signal display_on       : std_logic;

    -- Text buffer interface
    signal char_x, char_y : integer range 0 to 79;
    signal ascii_code     : std_logic_vector(7 downto 0);

    -- Font ROM interface
    signal font_row_addr  : std_logic_vector(10 downto 0);
    signal font_data      : std_logic_vector(7 downto 0);

    -- Pixel extraction
    signal font_x, font_y : integer range 0 to 15;
    signal pixel_on       : std_logic;
	 signal uart_out       : std_logic_vector(7 downto 0);
	 signal cursor_pos      : integer 0 to 2399;

begin
		process(clk25)
		begin 
		

    if rising_edge(clk25) then
         -- default no write

        if uart_valid = '1' then   -- ✅ only true when a new character arrives
            w_addr <= cursor_pos;
            w_data <= uart_out;
            we <= '1';
				if cursor_pos<2399 then
				   cursor_pos <= cursor_pos + 1;
				else 
					cursor_pos <='0';
				end if;
		   if uart_valid ='0' then
				cursor_pos<=cursor_pos;
				
        end if;
    end if;
end process;


    -- Instantiate VGA timing
    timing_inst : entity work.vga_timing
        port map (
            clk        => clk25,
            h_count    => h_count,
            v_count    => v_count,
            h_sync     => h_sync,
            v_sync     => v_sync,
            display_on => display_on
        );

    ----------------------------------------------------------------
    -- Compute text cell position
    ----------------------------------------------------------------
    char_x <= h_count / 8;  -- 80 columns
    char_y <= v_count / 16; -- 30 rows

    -- Inside character pixel
    font_x <= h_count mod 8;
    font_y <= v_count mod 16;

    ----------------------------------------------------------------
    -- Text buffer address
    ----------------------------------------------------------------
    text_buf_addr : entity work.text_buffer
        port map (
            clk      => clk25,
            we       => '1',
            w_addr   => cursor_pos ,
            w_data   => uart_out,
            r_addr   => char_y * 80 + char_x,
            r_data   => ascii_code
        );

    ----------------------------------------------------------------
    -- Font ROM access
    ----------------------------------------------------------------
    font_row_addr <= std_logic_vector(to_unsigned(to_integer(unsigned(ascii_code)) * 16 + font_y, 11));

    font_rom_inst : entity work.font_rom
        port map (
            address => font_row_addr,
            clock   => clk25,
            q       => font_data
        );

    pixel_on <= font_data(7 - font_x);

    ----------------------------------------------------------------
    -- VGA color output
    ----------------------------------------------------------------
    process(clk25)
    begin
        if rising_edge(clk25) then
            if display_on = '1' then
                if pixel_on = '1' then
                    vga_r <= '1'; vga_g <= '1'; vga_b <= '1'; -- white text
                else
                    vga_r <= '0'; vga_g <= '0'; vga_b <= '0'; -- black background
                end if;
            else
                vga_r <= '0'; vga_g <= '0'; vga_b <= '0';
            end if;
        end if;
    end process;

end rtl;
