library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tb_ticketmachine is
end tb_ticketmachine;

architecture rtl of tb_ticketmachine is
    COMPONENT TicketMachine IS
    PORT (
        clk, cancel, stasiunA, stasiunB, stasiunC, stasiunD : IN STD_LOGIC;
        seribu, dua_ribu, lima_ribu, sepuluh_ribu, dua_puluh_ribu : IN STD_LOGIC;
        kembalian, ticket, uang_balik : OUT STD_LOGIC);
    end COMPONENT;

    SIGNAL clk, cancel, stasiunA, stasiunB, stasiunC, stasiunD : STD_LOGIC;
    SIGNAL seribu, dua_ribu, lima_ribu, sepuluh_ribu, dua_puluh_ribu : STD_LOGIC;
    SIGNAL Outkembalian, Outticket, Outuang_balik : STD_LOGIC;

begin
    UUT : TicketMachine port map (
        clk => clk, cancel => cancel, stasiunA => stasiunA, stasiunB => stasiunB, stasiunC => stasiunC, stasiunD => stasiunD,
        seribu => seribu, dua_ribu => dua_ribu, lima_ribu => lima_ribu, sepuluh_ribu => sepuluh_ribu, dua_puluh_ribu => dua_puluh_ribu,
        kembalian => Outkembalian, ticket => Outticket, uang_balik => Outuang_balik);
    
    testbench : process
    constant period : time := 50 ns;
        begin
        seribu <= '1'; stasiunA <= '1'; wait for period;
        assert(Outticket	 = '0') report "Error pada 001" severity Error;
        assert(Outkembalian = '0') report "Uang tidak cukup" severity Error;
        assert(Outuang_balik = '1') report "Uang kembali" severity Error;
        seribu <= '0'; stasiunA <= '0';

        lima_ribu <= '0'; stasiunB <= '1'; wait for period;
        assert(Outticket	 = '1') report "Ticket berhasil dibeli " severity Error;
        assert(Outkembalian = '0') report "Uang cukup" severity Error;
        assert(Outuang_balik = '0') report "Uang kembali" severity Error;
        lima_ribu <= '0'; stasiunB <= '0';

        sepuluh_ribu <= '1'; stasiunC <= '1'; wait for period;
        assert(Outticket	 = '1') report "Ticket berhasil dibeli " severity Error;
        assert(Outkembalian = '1') report "Kembali Rp. 1000" severity Error;
        assert(Outuang_balik = '0') report "Uang kembali" severity Error;
        sepuluh_ribu <= '0'; stasiunC <= '0';

        wait;
    end process;

end architecture;