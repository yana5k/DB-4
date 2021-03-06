-- Generated by Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   at:        2020-05-21 20:02:18 EEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



CREATE TABLE albumgenre (
    id_album  INTEGER NOT NULL,
    genre     VARCHAR2(30) NOT NULL
);

ALTER TABLE albumgenre ADD CONSTRAINT albumgenre_pk PRIMARY KEY ( id_album,
                                                                  genre );

CREATE TABLE albuminfo (
    id_album  INTEGER NOT NULL,
    band      VARCHAR2(70) NOT NULL,
    album     VARCHAR2(75) NOT NULL,
    year      INTEGER NOT NULL
);

ALTER TABLE albuminfo ADD CONSTRAINT albuminfo_pk PRIMARY KEY ( id_album );

CREATE TABLE bandfrontman (
    band         VARCHAR2(70) NOT NULL,
    person_name  VARCHAR2(50) NOT NULL,
    start_date   DATE NOT NULL,
    end_date     DATE
);

ALTER TABLE bandfrontman
    ADD CONSTRAINT bandfrontman_pk PRIMARY KEY ( band,
                                                 person_name,
                                                 start_date );

CREATE TABLE bands (
    band VARCHAR2(70) NOT NULL
);

ALTER TABLE bands ADD CONSTRAINT bands_pk PRIMARY KEY ( band );

CREATE TABLE genres (
    genre VARCHAR2(30) NOT NULL
);

ALTER TABLE genres ADD CONSTRAINT genres_pk PRIMARY KEY ( genre );

CREATE TABLE person (
    person_name VARCHAR2(50) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT person_pk PRIMARY KEY ( person_name );

ALTER TABLE albumgenre
    ADD CONSTRAINT albumgenre_albuminfo_fk FOREIGN KEY ( id_album )
        REFERENCES albuminfo ( id_album );

ALTER TABLE albumgenre
    ADD CONSTRAINT albumgenre_genres_fk FOREIGN KEY ( genre )
        REFERENCES genres ( genre );

ALTER TABLE albuminfo
    ADD CONSTRAINT albuminfo_bands_fk FOREIGN KEY ( band )
        REFERENCES bands ( band );

ALTER TABLE bandfrontman
    ADD CONSTRAINT bandfrontman_bands_fk FOREIGN KEY ( band )
        REFERENCES bands ( band );

ALTER TABLE bandfrontman
    ADD CONSTRAINT bandfrontman_person_fk FOREIGN KEY ( person_name )
        REFERENCES person ( person_name );
CREATE TABLE Audits(
  person_name VARCHAR2(50) NOT NULL,
  time_add VARCHAR2(40) NOT NULL,
  cur_user VARCHAR2(75) NOT NULL
  );
  
CREATE or REPLACE TRIGGER record_person
AFTER INSERT on PERSON
for each row
DECLARE 
    person audits.person_name%TYPE;
    u_data audits.time_add%TYPE;
    username audits.cur_user%TYPE;
    cursor sdate is SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') FROM dual;
begin
   open sdate;
   fetch sdate into u_data;
   username := USER;
   person := :NEW.person_name;
   INSERT INTO AUDITS(person_name, time_add, cur_user)
   VALUES (person, u_data, username);
   close sdate;
end;

