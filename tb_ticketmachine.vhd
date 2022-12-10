LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY tb_ticketmachine IS
END tb_ticketmachine;

ARCHITECTURE rtl OF tb_ticketmachine IS
    COMPONENT TicketMachine IS
        PORT (
            clk, cancel, stasiunA, stasiunB, stasiunC, stasiunD : IN STD_LOGIC;
            seribu, dua_ribu, lima_ribu, sepuluh_ribu, dua_puluh_ribu : IN STD_LOGIC;
            kembalian, ticket, uang_balik : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL clk, cancel, stasiunA, stasiunB, stasiunC, stasiunD : STD_LOGIC;
    SIGNAL seribu, dua_ribu, lima_ribu, sepuluh_ribu, dua_puluh_ribu : STD_LOGIC;
    SIGNAL Outkembalian, Outticket, Outuang_balik : STD_LOGIC;

BEGIN
    UUT : TicketMachine PORT MAP(
        clk => clk, cancel => cancel, stasiunA => stasiunA, stasiunB => stasiunB, stasiunC => stasiunC, stasiunD => stasiunD,
        seribu => seribu, dua_ribu => dua_ribu, lima_ribu => lima_ribu, sepuluh_ribu => sepuluh_ribu, dua_puluh_ribu => dua_puluh_ribu,
        kembalian => Outkembalian, ticket => Outticket, uang_balik => Outuang_balik);

    testbench : PROCESS
        CONSTANT period : TIME := 100 ps;
    BEGIN
        stasiunA <= '1';
        WAIT FOR period;
        lima_ribu <= '1';
        WAIT FOR period;
        IF Outticket = '1' THEN
            REPORT "Ticket berhasil dibeli " SEVERITY NOTE;
        ELSIF Outticket = '0' THEN
            REPORT "Ticket gagal dibeli " SEVERITY NOTE;
        END IF;
        IF Outkembalian = '1' THEN
            REPORT "Terdapat Kembalian" SEVERITY NOTE;
        ELSIF Outkembalian = '0' THEN
            REPORT "Tidak ada Kembalian" SEVERITY NOTE;
        END IF;
        IF Outuang_balik = '1' THEN
            REPORT "Uang dikembalikan" SEVERITY NOTE;
        ELSIF Outuang_balik = '0' THEN
            REPORT "Uang tidak dikembalikan" SEVERITY NOTE;
        END IF;
        stasiunA <= '0';
        WAIT FOR period;
        lima_ribu <= '0';
        WAIT FOR period;
        assert Outticket = '0' report "Ticket gagal dibeli" severity note;
        WAIT;
    END PROCESS;

END ARCHITECTURE;