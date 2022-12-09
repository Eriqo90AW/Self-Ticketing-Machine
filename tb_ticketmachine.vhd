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
        CONSTANT period : TIME := 50 ns;
    BEGIN
        seribu <= '1';
        stasiunA <= '1';
        WAIT FOR period;
        if Outticket = '1' then
            REPORT "Ticket berhasil dibeli " SEVERITY NOTE;
        elsif Outticket = '0' then
            REPORT "Ticket gagal dibeli " SEVERITY NOTE;
        end if;
        if Outkembalian = '1' then
            REPORT "Terdapat Kembalian" SEVERITY NOTE;
        elsif Outkembalian = '0' then
            REPORT "Uang cukup" SEVERITY NOTE;
        end if;
        if Outuang_balik = '1' then
            REPORT "Uang dikembalikan" SEVERITY NOTE;
        elsif Outuang_balik = '0' then
            REPORT "Uang tidak dikembalikan" SEVERITY NOTE;
        end if;
        -- ASSERT(Outticket = '0') REPORT "Ticket gagal dibeli " SEVERITY NOTE;
        -- ASSERT(Outkembalian = '0') REPORT "Uang tidak cukup" SEVERITY NOTE;
        -- ASSERT(Outuang_balik = '1') REPORT "Uang kembali" SEVERITY NOTE;
        seribu <= '0';
        stasiunA <= '0';

        lima_ribu <= '0';
        stasiunB <= '1';
        WAIT FOR period;
        if Outticket = '1' then
            REPORT "Ticket berhasil dibeli " SEVERITY NOTE;
        elsif Outticket = '0' then
            REPORT "Ticket gagal dibeli " SEVERITY NOTE;
        end if;
        if Outkembalian = '1' then
            REPORT "Terdapat Kembalian" SEVERITY NOTE;
        elsif Outkembalian = '0' then
            REPORT "Uang cukup" SEVERITY NOTE;
        end if;
        if Outuang_balik = '1' then
            REPORT "Uang dikembalikan" SEVERITY NOTE;
        elsif Outuang_balik = '0' then
            REPORT "Uang tidak dikembalikan" SEVERITY NOTE;
        end if;
        -- ASSERT(Outticket = '1') REPORT "Ticket berhasil dibeli " SEVERITY NOTE;
        -- ASSERT(Outkembalian = '0') REPORT "Uang cukup" SEVERITY NOTE;
        -- ASSERT(Outuang_balik = '0') REPORT "Uang kembali" SEVERITY NOTE;
        lima_ribu <= '0';
        stasiunB <= '0';

        sepuluh_ribu <= '1';
        stasiunC <= '1';
        WAIT FOR period;
        if Outticket = '1' then
            REPORT "Ticket berhasil dibeli " SEVERITY NOTE;
        elsif Outticket = '0' then
            REPORT "Ticket gagal dibeli " SEVERITY NOTE;
        end if;
        if Outkembalian = '1' then
            REPORT "Terdapat Kembalian" SEVERITY NOTE;
        elsif Outkembalian = '0' then
            REPORT "Uang cukup" SEVERITY NOTE;
        end if;
        if Outuang_balik = '1' then
            REPORT "Uang dikembalikan" SEVERITY NOTE;
        elsif Outuang_balik = '0' then
            REPORT "Uang tidak dikembalikan" SEVERITY NOTE;
        end if;
        -- ASSERT(Outticket = '1') REPORT "Ticket berhasil dibeli " SEVERITY NOTE;
        -- ASSERT(Outkembalian = '1') REPORT "Kembali Rp. 1000" SEVERITY NOTE;
        -- ASSERT(Outuang_balik = '0') REPORT "Uang kembali" SEVERITY NOTE;
        sepuluh_ribu <= '0';
        stasiunC <= '0';

        WAIT;
    END PROCESS;

END ARCHITECTURE;