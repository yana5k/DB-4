SET SERVEROUTPUT ON
DECLARE
  uname bandfrontman.person_name%TYPE;
  uband bandfrontman.band%TYPE; 
BEGIN
  DBMS_OUTPUT.PUT_LINE('TESTING PROCEDURE');
  DBMS_OUTPUT.PUT_LINE(' ');
  uname := 78778577;
  uband := 'Black Sabbath';

  pDeleteFrontman(
    frontman_name => uname,
    band_name => uband 
  );
  DBMS_OUTPUT.PUT_LINE(' ');
  uname := 'Ozzy Osbourne';
  uband := 'dfvfdvdfv';
  pDeleteFrontman(
    frontman_name => uname,
    band_name => uband 
  );
  DBMS_OUTPUT.PUT_LINE(' ');
  uname := 'Ozzy Osbourne';
  uband := 'Black Sabbath';
  pDeleteFrontman(
    frontman_name => uname,
    band_name => uband 
  );
END;
/
--INSERT INTO BandFrontman VALUES('Black Sabbath', 'Ozzy Osbourne', TO_DATE('1968/01/01','yyyy/mm/dd'), null);
DECLARE
    CURSOR result_func_1 IS SELECT * FROM TABLE(ShowAlbumsBetweenYears(1965, 2020)) ORDER BY album_year;
    CURSOR result_func_2 IS SELECT * FROM TABLE(ShowAlbumsBetweenYears(1965, 1970)) ORDER BY album_year;
BEGIN
DBMS_OUTPUT.PUT_LINE('TESTING FUNCTION');
DBMS_OUTPUT.PUT_LINE(' ');
DBMS_OUTPUT.PUT_LINE('--| ALBUM |-----| BAND |-----| FRONTMAN |-----| YEAR(1965, 1970)|');
    FOR alb IN result_func_1 LOOP
        DBMS_OUTPUT.PUT_LINE('| '||alb.album_name||'|    |'|| alb.album_band||'|    |'||alb.album_frontman||'|    |'||alb.album_year||'|');
    END LOOP;
DBMS_OUTPUT.PUT_LINE(' ');
DBMS_OUTPUT.PUT_LINE('--| ALBUM |-----| BAND |-----| FRONTMAN |-----| YEAR(1965, 1970)|');
    FOR alb IN result_func_2 LOOP
        DBMS_OUTPUT.PUT_LINE('| '||alb.album_name||'|    |'|| alb.album_band||'|    |'||alb.album_frontman||'|    |'||alb.album_year||'|');
    END LOOP;
END;