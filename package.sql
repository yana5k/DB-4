CREATE OR REPLACE PACKAGE Operation_RS500 IS
 TYPE RowForAlbum IS RECORD (
    album_name VARCHAR2(75),
    album_band VARCHAR2(70),
    album_frontman VARCHAR2(50),
    album_year NUMBER
); 
TYPE TableOfAlbums IS TABLE OF RowForAlbum;
FUNCTION ShowAlbumsBetweenYears (first_y IN NUMBER, second_y IN NUMBER)   
        RETURN TableOfAlbums  
        PIPELINED;
PROCEDURE pDeleteFrontman(frontman_name IN bandfrontman.person_name%TYPE, band_name IN bandfrontman.band%TYPE);
END Operation_RS500;
/
CREATE OR REPLACE PACKAGE BODY Operation_RS500 IS
    FUNCTION ShowAlbumsBetweenYears (first_y IN NUMBER, second_y IN NUMBER)   
        RETURN TableOfAlbums  
        PIPELINED AS
            CURSOR albums_information IS
                SELECT ALBUMINFO.album AS album_name, ALBUMINFO.band AS album_band, 
                        BANDFRONTMAN.person_name AS album_frontman, ALBUMINFO.year AS album_year 
                FROM ALBUMINFO JOIN BANDFRONTMAN ON ALBUMINFO.band = BANDFRONTMAN.band
                WHERE ALBUMINFO.YEAR BETWEEN first_y and second_y;
        BEGIN
                FOR alb IN albums_information
                LOOP
                    PIPE ROW (alb);
                END LOOP;
        END ShowAlbumsBetweenYears;
    PROCEDURE pDeleteFrontman(frontman_name IN bandfrontman.person_name%TYPE, band_name IN bandfrontman.band%TYPE) IS
            band_exception EXCEPTION;
            name_exception EXCEPTION;
            missing_expression EXCEPTION;
            cursor frontm is select person_name from BANDFRONTMAN where person_name = frontman_name and band = band_name;
            cursor cband is select band from bands where band = band_name;
            rfront bandfrontman.person_name%TYPE;
            rband bandfrontman.band%TYPE;
        BEGIN
            open frontm;
            fetch frontm into rfront;
            open cband;
            fetch cband into rband;
            IF frontman_name is null or band_name is null then
                RAISE missing_expression;
            END IF;
            
            IF rband is null then
                RAISE band_exception;
            END IF;
            
            IF rfront is null then
                RAISE name_exception;
            END IF;
            
            DELETE FROM bandfrontman
            WHERE bandfrontman.person_name = frontman_name
            AND bandfrontman.band = band_name;
            DBMS_OUTPUT.PUT_LINE('Рядочок видалено :) ');
        
            close frontm;
            close cband;
        EXCEPTION
            
            WHEN missing_expression THEN
            DBMS_OUTPUT.PUT_LINE('Може, не треба шукати пусті рядки?');
        
            WHEN name_exception THEN
            DBMS_OUTPUT.PUT_LINE('Некоректне ім`я фронтмена');
        
            WHEN band_exception THEN
            DBMS_OUTPUT.PUT_LINE('Некоректна назва групи!');

    END pDeleteFrontman;
END;

