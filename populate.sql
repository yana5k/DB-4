---INSERTING DATA INTO Bands
INSERT INTO Bands VALUES('Black Sabbath');
INSERT INTO Bands VALUES('The Doors');
INSERT INTO Bands VALUES('Pink Floyd');


---INSERTING DATA INTO Genres
INSERT INTO Genres VALUES('Rock');
INSERT INTO Genres VALUES('Funk / Soul');
INSERT INTO Genres VALUES('Pop');

---INSERTING DATA INTO AlbumInfo
INSERT INTO AlbumInfo VALUES(1, 'Black Sabbath', 'Paranoid', 1970);
INSERT INTO AlbumInfo VALUES(2, 'Pink Floyd', 'The Dark Side of the Moon', 1973);
INSERT INTO AlbumInfo VALUES(3, 'The Doors', 'The Doors', 1967);


---INSERTING DATA INTO AlbumGenre
INSERT INTO AlbumGenre VALUES(1, 'Rock');
INSERT INTO AlbumGenre VALUES(2, 'Rock');
INSERT INTO AlbumGenre VALUES(3, 'Rock');

---INSERTING DATA INTO Person
INSERT INTO Person VALUES('Ozzy Osbourne');
INSERT INTO Person VALUES('Nick Mason');
INSERT INTO Person VALUES('Jim Morrison');

---INSERTING DATA INTO BandFrontman
INSERT INTO BandFrontman VALUES('Black Sabbath', 'Ozzy Osbourne', TO_DATE('1968/01/01','yyyy/mm/dd'), null);
INSERT INTO BandFrontman VALUES('Pink Floyd', 'Nick Mason', TO_DATE('1965/01/01','yyyy/mm/dd'), TO_DATE('1994/01/01','yyyy/mm/dd'));
INSERT INTO BandFrontman VALUES('The Doors', 'Jim Morrison', TO_DATE('1965/01/01','yyyy/mm/dd'), TO_DATE('1971/01/01','yyyy/mm/dd'));