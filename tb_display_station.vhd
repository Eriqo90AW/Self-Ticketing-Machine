LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY tb_display_station IS
END tb_display_station;

ARCHITECTURE rtl OF tb_display_station IS
    COMPONENT display_station IS
        PORT (
            BCDin : IN CHARACTER;
            Seven_Segment : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
    END COMPONENT;
    SIGNAL input : CHARACTER;
    SIGNAL output : STD_LOGIC_VECTOR (6 DOWNTO 0);
BEGIN
    uut : display_station PORT MAP(
        BCDin => input,
        Seven_Segment => output);

    PROCESS
        CONSTANT period : TIME := 50 ns;
    BEGIN
        input <= 'A';
        WAIT FOR period;
        IF output = "1110111" THEN
            REPORT "Menunjukkan huruf A: " & INTEGER'image(to_integer(unsigned(output))) SEVERITY Note;
        END IF;

        input <= 'B';
        WAIT FOR period;
        IF output = "0011111" THEN
            REPORT "Menunjukkan huruf B: " & INTEGER'image(to_integer(unsigned(output))) SEVERITY Note;
        END IF;

        input <= 'C';
        WAIT FOR period;
        IF output = "1001110" THEN
            REPORT "Menunjukkan huruf C: " & INTEGER'image(to_integer(unsigned(output))) SEVERITY Note;
        END IF;

        input <= 'D';
        WAIT FOR period;
        IF output = "0111101" THEN
            REPORT "Menunjukkan huruf D: " & INTEGER'image(to_integer(unsigned(output))) SEVERITY Note;
        END IF;
        WAIT;
    END PROCESS;
END ARCHITECTURE rtl;
