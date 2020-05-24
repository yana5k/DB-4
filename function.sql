--DROP TYPE TableOfAlbums;
--DROP TYPE RowForAlbum;

CREATE TYPE RowForAlbum AS OBJECT (
    album_name VARCHAR2(75),
    album_band VARCHAR2(70),
    album_frontman VARCHAR2(50),
    album_year NUMBER
); 
/
CREATE TYPE TableOfAlbums IS TABLE OF RowForAlbum;
/
CREATE OR REPLACE FUNCTION ShowAlbumsBetweenYears (first_y IN NUMBER, second_y IN NUMBER)   
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
                    PIPE ROW (RowForAlbum(alb.album_name, alb.album_band, alb.album_frontman, alb.album_year));
                END LOOP;
        END;
