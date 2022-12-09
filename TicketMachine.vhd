LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY TicketMachine IS
    PORT (
        clk, cancel, stasiunA, stasiunB, stasiunC, stasiunD : IN STD_LOGIC;
        seribu, dua_ribu, lima_ribu, sepuluh_ribu, dua_puluh_ribu : IN STD_LOGIC;
        kembalian, ticket, uang_balik : OUT STD_LOGIC);
END TicketMachine;

ARCHITECTURE mesin_tiket_sederhana OF TicketMachine IS
    COMPONENT display_station IS
        PORT (
            BCDin : IN CHARACTER;
            Seven_Segment : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
    END COMPONENT;

    TYPE state_type IS (main_menu, waiting_input, refund, change_out, ticket_out);
    SIGNAL stasiun : INTEGER RANGE 0 TO 4 := 0;
    SIGNAL state : state_type := main_menu;
    SIGNAL timer : INTEGER RANGE 0 TO 89 := 0;
    SIGNAL wait_time : INTEGER RANGE 0 TO 2 := 0;
    SIGNAL tarif : INTEGER := 0;
    SIGNAL uang : INTEGER := 0;
    SIGNAL uang_kembalian : INTEGER := 0;

    SIGNAL kode_stasiun : CHARACTER;
    SIGNAL display_output : STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN
    display : display_station PORT MAP(BCDin => kode_stasiun, Seven_Segment => display_output);
    PROCESS (clk, cancel)
        CONSTANT period : TIME := 50 ns;
    BEGIN
        IF cancel = '1' THEN
            kembalian <= '0';
            ticket <= '0';
            tarif <= 0;
            wait_time <= 0;
            uang_kembalian <= 0;
            uang_balik <= '1';
            uang <= 0;
            stasiun <= 0;
            timer <= 0;
            tarif <= 0;
            state <= main_menu;
        ELSIF clk'event AND clk = '1' THEN
            CASE state IS
                WHEN main_menu =>
                    timer <= 0;
                    uang <= 0;
                    stasiun <= 0;
                    kembalian <= '0';
                    uang_balik <= '0';
                    ticket <= '0';
                    tarif <= 0;
                    wait_time <= 0;
                    uang_kembalian <= 0;
                    IF stasiunA = '1' THEN
                        stasiun <= 1;
                        state <= waiting_input;
                    ELSIF stasiunB = '1' THEN
                        stasiun <= 2;
                        state <= waiting_input;
                    ELSIF stasiunC = '1' THEN
                        stasiun <= 3;
                        state <= waiting_input;
                    ELSIF stasiunD = '1' THEN
                        stasiun <= 4;
                        state <= waiting_input;
                    END IF;

                WHEN waiting_input =>
                    timer <= timer + 1;
                    uang_balik <= '0';

                    IF uang_balik = '1' THEN
                        uang_kembalian <= uang;
                        state <= refund;
                    END IF;

                    IF timer = 89 THEN
                        state <= main_menu;
                    END IF;

                    IF seribu = '1' THEN
                        uang <= 1000;
                    ELSIF dua_ribu = '1' THEN
                        uang <= 2000;
                    ELSIF lima_ribu = '1' THEN
                        uang <= 5000;
                    ELSIF sepuluh_ribu = '1' THEN
                        uang <= 10000;
                    ELSIF dua_puluh_ribu = '1' THEN
                        uang <= 20000;
                    END IF;

                    -- stasiun A, harga: 3 ribu
                    IF stasiun = 1 THEN
                        kode_stasiun <= 'A';
                        WAIT FOR period;
                        IF display_output = "1110111" THEN
                            REPORT "Menunjukkan huruf A: " & INTEGER'image(to_integer(unsigned(display_output))) SEVERITY Note;
                        END IF;
                        tarif <= 3000;
                        IF uang = 3000 THEN
                            state <= ticket_out;
                        ELSIF (uang < 3000 AND uang > 0) THEN
                            state <= refund;
                        ELSIF uang > 3000 THEN
                            state <= change_out;
                        ELSE
                            timer <= timer + 1;
                        END IF;

                        -- stasiun B, harga: 5 ribu
                    ELSIF stasiun = 2 THEN
                        kode_stasiun <= 'B';
                        WAIT FOR period;
                        IF display_output = "0011111" THEN
                            REPORT "Menunjukkan huruf B: " & INTEGER'image(to_integer(unsigned(display_output))) SEVERITY Note;
                        END IF;
                        tarif <= 5000;
                        IF uang = 5000 THEN
                            state <= ticket_out;
                        ELSIF (uang < 5000 AND uang > 0) THEN
                            state <= refund;
                        ELSIF uang > 5000 THEN
                            state <= change_out;
                        ELSE
                            timer <= timer + 1;
                        END IF;

                        -- stasiun C, harga: 9 ribu
                    ELSIF stasiun = 3 THEN
                        kode_stasiun <= 'C';
                        WAIT FOR period;
                        IF display_output = "1001110" THEN
                            REPORT "Menunjukkan huruf C: " & INTEGER'image(to_integer(unsigned(display_output))) SEVERITY Note;
                        END IF;
                        tarif <= 9000;
                        IF uang = 9000 THEN
                            state <= ticket_out;
                        ELSIF (uang < 9000 AND uang > 0) THEN
                            state <= refund;
                        ELSIF uang > 9000 THEN
                            state <= change_out;
                        ELSE
                            timer <= timer + 1;
                        END IF;

                        -- stasiun D, harga: 13 ribu
                    ELSIF stasiun = 4 THEN
                        kode_stasiun <= 'D';
                        WAIT FOR period;
                        IF display_output = "0111101" THEN
                            REPORT "Menunjukkan huruf D: " & INTEGER'image(to_integer(unsigned(display_output))) SEVERITY Note;
                        END IF;
                        tarif <= 13000;
                        IF uang = 13000 THEN
                            state <= ticket_out;
                        ELSIF (uang < 13000 AND uang > 0) THEN
                            state <= refund;
                        ELSIF uang > 13000 THEN
                            state <= change_out;
                        ELSE
                            timer <= timer + 1;
                        END IF;
                    END IF;

                WHEN change_out =>
                    kembalian <= '1';
                    uang_kembalian <= uang - tarif;
                    wait_time <= wait_time + 1;
                    IF wait_time = 2 THEN
                        state <= ticket_out;
                    END IF;

                WHEN refund =>
                    uang_balik <= '1';
                    wait_time <= wait_time + 1;
                    IF wait_time = 2 THEN
                        state <= waiting_input;
                    END IF;

                WHEN ticket_out =>
                    ticket <= '1';
                    wait_time <= wait_time + 1;
                    IF wait_time = 2 THEN
                        state <= main_menu;
                    END IF;
            END CASE;
        END IF;
    END PROCESS;

END mesin_tiket_sederhana;