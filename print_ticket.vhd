LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY print_ticket IS
    PORT (
        kode_stasiun : IN CHARACTER;
        harga_ticket : IN INTEGER
    );
END print_ticket;

ARCHITECTURE Behavioral OF print_ticket IS
BEGIN
    PROCESS (kode_stasiun, harga_ticket)
    BEGIN
        REPORT "waktu keberangkatan = " & TIME'image(now);
        REPORT "kode stasiun = " & kode_stasiun;
        REPORT "harga ticket = " & INTEGER'image(harga_ticket);
    END PROCESS;
END Behavioral;