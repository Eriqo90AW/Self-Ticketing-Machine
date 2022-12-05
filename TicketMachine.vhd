library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TicketMachine is
    Port ( clk, cancel, stasiunA, stasiunB, stasiunC, stasiunD : in STD_LOGIC;
            seribu, dua_ribu, lima_ribu, sepuluh_ribu, dua_puluh_ribu : in STD_LOGIC;
            kembalian, ticket, uang_balik : out STD_LOGIC );
end TicketMachine;

architecture mesin_tiket_sederhana of TicketMachine is
    type state_type is (menu_stasiun, tunggu_uang, kembalikan_uang, keluarkan_kembalian, keluarkan_ticket);
    signal stasiun: integer range 0 to 4 := 0;
    signal state: state_type := menu_stasiun;
    signal timer: integer range 0 to 89 :=0;
    signal wait_time: integer range 0 to 2 :=0;
    signal tarif: integer :=0;
    signal uang: integer :=0;
    signal uang_kembalian: integer :=0;
begin

    process(clk, cancel)
        begin
            if cancel = '1' then
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
                state <= menu_stasiun;
            elsif clk'event and clk='1' then
                case state is
                    when menu_stasiun =>
                        timer <= 0; 
                        uang <= 0;
                        stasiun <= 0;
                        kembalian <= '0';
                        uang_balik <= '0'; 
                        ticket <= '0'; 
                        tarif <= 0; 
                        wait_time <= 0; 
                        uang_kembalian <= 0;
                        if stasiunA = '1' then
                            stasiun <= 1;
                            state <= tunggu_uang;
                        elsif stasiunB = '1' then
                            stasiun <= 2;
                            state <= tunggu_uang;
                        elsif stasiunC = '1' then
                            stasiun <= 3;
                            state <= tunggu_uang;
                        elsif stasiunD = '1' then
                            stasiun <= 4;
                            state <= tunggu_uang;
                        end if;
                    
                    when tunggu_uang =>
                        timer <= timer + 1;
                        uang_balik <= '0';

                        if uang_balik = '1' then
                            uang_kembalian <= uang;
                            state <= kembalikan_uang;
                        end if;                        
                        
                        if timer = 89 then
                            state <= menu_stasiun;
                        end if;    
                        
                        if seribu = '1' then
                            uang <= 1000;
                        elsif dua_ribu = '1' then
                            uang <= 2000;
                        elsif lima_ribu = '1' then
                            uang <= 5000;
                        elsif sepuluh_ribu = '1' then
                            uang <= 10000;
                        elsif dua_puluh_ribu = '1' then
                            uang <= 20000;
                        end if;

                        -- stasiun A, harga: 3 ribu
                        if stasiun = 1 then
                            tarif <= 3000;
                            if uang = 3000 then
                                state <= keluarkan_ticket;
                            elsif (uang < 3000 and uang > 0) then
                                state <= kembalikan_uang;
                            elsif uang > 3000 then
                                state <= keluarkan_kembalian;
                            else
                                timer <= timer + 1;
                            end if;
                        
                        -- stasiun B, harga: 5 ribu
                        elsif stasiun = 2 then
                            tarif <= 5000;
                            if uang = 5000 then
                                state <= keluarkan_ticket;
                            elsif (uang < 5000 and uang > 0) then
                                state <= kembalikan_uang;
                            elsif uang > 5000 then
                                state <= keluarkan_kembalian;
                            else
                                timer <= timer + 1;
                            end if;
                        
                        -- stasiun C, harga: 9 ribu
                        elsif stasiun = 3 then
                            tarif <= 9000;
                            if uang = 9000 then
                                state <= keluarkan_ticket;
                            elsif (uang < 9000 and uang > 0) then
                                state <= kembalikan_uang;
                            elsif uang > 9000 then
                                state <= keluarkan_kembalian;
                            else
                                timer <= timer + 1;      
                            end if;
                        
                        -- stasiun D, harga: 13 ribu
                        elsif stasiun = 4 then
                            tarif <= 13000;
                            if uang = 13000 then
                                state <= keluarkan_ticket;
                            elsif (uang < 13000 and uang > 0) then
                                state <= kembalikan_uang;
                            elsif uang > 13000 then
                                state <= keluarkan_kembalian;
                            else
                                timer <= timer + 1;
                            end if;
                        end if;         
                                
                    when keluarkan_kembalian =>
                        kembalian <= '1';
                        uang_kembalian <= uang - tarif;
                        wait_time <= wait_time + 1;
                        if wait_time = 2 then
                            state <= keluarkan_ticket;
                        end if;
                            
                    when kembalikan_uang =>
                        uang_balik <= '1';
                        wait_time <= wait_time + 1;
                        if wait_time = 2 then
                            state <= tunggu_uang;
                        end if;            
                    
                    when keluarkan_ticket =>
                        ticket <= '1';
                        wait_time <= wait_time + 1;
                        if wait_time = 2 then
                            state <= menu_stasiun;  
                        end if;
                end case;
            end if;
    end process;           
                        
end mesin_tiket_sederhana;
