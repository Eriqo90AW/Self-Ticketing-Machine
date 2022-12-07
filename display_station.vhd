LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY display_station IS
    PORT (
        BCDin : IN CHARACTER;
        Seven_Segment : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END display_station;

ARCHITECTURE Behavioral OF display_station IS

BEGIN

    PROCESS (BCDin)
    BEGIN
        CASE BCDin IS
            WHEN 'A' =>
                Seven_Segment <= "1110111"; --A
            WHEN 'B' =>
                Seven_Segment <= "0011111"; --B
            WHEN 'C' =>
                Seven_Segment <= "1001110"; --C
            WHEN 'D' =>
                Seven_Segment <= "0111101"; --D
            WHEN OTHERS =>
                Seven_Segment <= "1111111"; --K
        END CASE;

    END PROCESS;

END Behavioral;