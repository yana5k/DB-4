create or replace PROCEDURE pDeleteFrontman(frontman_name IN bandfrontman.person_name%TYPE, band_name IN bandfrontman.band%TYPE) IS


	/*визначимо виключення*/
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
    DBMS_OUTPUT.PUT_LINE('Рядочок видалено');

	close frontm;
	close cband;
EXCEPTION
	
    WHEN missing_expression THEN
    DBMS_OUTPUT.PUT_LINE('Може, краще не шукати пусті рядки?');

    WHEN name_exception THEN
    DBMS_OUTPUT.PUT_LINE('Некоректне ім`я фронтмена!');

    WHEN band_exception THEN
    DBMS_OUTPUT.PUT_LINE('Некоректна назва групи!');

END;
/