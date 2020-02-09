REM : Deleting table based on hierarchy
 
	drop table sungby;

	drop table artist;

	drop table song;

	drop table album;

	drop table musician;

	drop table studio;

REM: a)create musician table

    	create table musician(m_id varchar2(4),
    	m_name varchar(20),
    	birthplace varchar2(20),
   	CONSTRAINT m_id_pk PRIMARY KEY(m_id));

     	desc musician;

REM: Entering values into MUSICIAN
	
	insert into musician values('001','AR Rahman','Chennai');
	insert into musician values('002','Anirudh','Chennai');
	insert into musician values('003','Ilayaraja','Chennai');

REM: Displaying MUSICIAN table
 
	select * from musician; 

REM: f)Creating STUDIO table
 
	create table studio(st_name varchar2(20),
      	address varchar2(20),
      	phone number(10),
     	CONSTRAINT st_name_pk primary key(st_name));

	desc studio;
 
REM: Entering values into STUDIO
 
 	insert into studio values('Medley Studio','KK Nagar','1234567897');
	insert into studio values('Lakshman Shruti','Vadapalani','7584948345');
   	insert into studio values('Raja Studio','Ashok Nagar','7549368345');

REM: Displaying STUDIO table
 
	select * from studio;

REM: b)Creating ALBUM table

    	create table album(alb_name varchar2(20),
      	alb_id varchar2(10),
      	year number(4),
      	num_tracks number(2),
      	st_name varchar2(20),
      	alb_genre varchar2(20),
      	m_id varchar2(4),
      	CONSTRAINT alb_id_pk PRIMARY KEY(alb_id),
      	CONSTRAINT m_id_fk FOREIGN KEY(m_id) REFERENCES musician(m_id),
   	CONSTRAINT st_name_fk FOREIGN KEY(st_name) REFERENCES studio(st_name),
   	CONSTRAINT yr_check check(year>=1945),
  	CONSTRAINT alb_genre_check check( alb_genre in('CAR', 'DIV', 'MOV', 'POP')));
 

 	desc album;

REM: Entering values into ALBUM
 
   	insert into album values('I','A01','2017','6','Medley Studio','MOV','001');
 	insert into album values('Raja Rani','A02','2015','7','Raja Studio','MOV','003');
     	insert into album values('Super Deluxe','A03','2019','3','Lakshman Shruti','MOV','002');

REM: Year check constraint violation

  	insert into album values('Vaaranam Aayiram','A03','1942','3','Lakshman Shruti','MOV','002');

REM: Album genre check constraint viloation

   	insert into album values('Bigil','A03','1942','3','Lakshman Shruti','HIP','002');

REM: Displaying ALBUM table

	select * from album;

REM: c)Creating SONG table

	create table song(alb_id varchar2(10),
    	track_num number(2),
    	song_name varchar2(20) CONSTRAINT sname_null NOT NULL,
    	length number(4),
    	song_genre varchar2(20),
    	CONSTRAINT song_pk PRIMARY KEY(alb_id,track_num),
    	CONSTRAINT alb_id_fk FOREIGN KEY(alb_id) REFERENCES album(alb_id),
    	CONSTRAINT song_genre_check check(song_genre in('PHI', 'REL', 'LOV', 'PAT')),
    	constraint chk check((length>7 AND song_genre='PAT') OR song_genre<>'PAT'));
 
	desc song;
                                                                          
REM: Entering values into SONG

 	insert into song values('A01',1,'Ladio',4,'REL');
  	insert into song values('A02',2,'Hey Baby',3,'LOV');
  	insert into song values('A03',3,'Oh Shanti',4,'LOV');

REM: Genre PAT length check constraint violation

   	insert into song values('A03',3,'Vandhe Mataram',6,'PAT');

REM: Song genre check constraint violation

	insert into song values('A03',3,'Wow',6,'EDM');

REM: Displaying SONG table
 
	select * from song;
  
REM: d)Creating ARTIST table

    	create table artist(art_id varchar2(4),
      	art_name varchar2(20),
    	CONSTRAINT art_id_pk PRIMARY KEY(art_id),
   	CONSTRAINT art_name_uniq UNIQUE(art_name));
 
	desc artist;

REM: Entering values into ARTIST
 
	insert into artist values('a001','Sid Sriram');
 	insert into artist values('a002','Anirudh');
 	insert into artist values('a003','Shankar Mahadevan');
  
REM: Unique constraint violation

   	insert into artist values('a004','Shankar Mahadevan');

REM: Displaying ARTIST table

 	select * from artist;

REM: e)Creating SUNGBY table

    	create table sungby(alb_id varchar2(4),
       	art_id varchar2(4),
      	track_num number(2),
      	rec_date date,
      	CONSTRAINT sungby_pk PRIMARY KEY(alb_id,art_id,track_num),
      	CONSTRAINT alb_id_track_num_fk FOREIGN KEY(alb_id,track_num) REFERENCES song(alb_id,track_num),
     	CONSTRAINT art_id_fk FOREIGN KEY(art_id) REFERENCES artist(art_id));
 
 	desc sungby;
                                                                
REM: Entering values into SUNGBY

   	insert into sungby values('A01','a001',1,'20FEB2016');
  	insert into sungby values('A02','a002',2,'25JUN2013');
	insert into sungby values('A03','a003',3,'28MAY2013');

REM: Displaying SUNGBY table
 
	select * from sungby;
                               
REM ********************************************************************
REM 					ALTER TABLE QUERIES
REM ********************************************************************

REM 10)It is necessary to represent the gender of an artist in the table

	ALTER TABLE artist ADD gender CHAR(1);
	desc artist;

	INSERT INTO artist VALUES('a004','Yuvan','M');
	select * from artist;

REM 11)The first few words of the lyrics constitute the song name. The song name do not accommodate some of the words (in lyrics).

	ALTER TABLE song MODIFY song_name VARCHAR2(50);
	desc song;

	insert into song values('A03',4,'Nenjukul peithidum maamazhai','20','LOV');

REM 12)The phone number of each studio should be different.

	ALTER TABLE studio ADD CONSTRAINT ph_uk UNIQUE(phone);
	
	REM: Phone unique constraint violation
	INSERT INTO studio VALUES('6D','Bangalore', 1234567897);

REM 13)An artist who sings a song for a particular track of an album can not be recorded without the record_date.

	ALTER TABLE sungby MODIFY (rec_date NOT NULL);
	INSERT INTO sungby(track_num,alb_id,art_id) VALUES(1,'A01','a002');

REM 14)It was decided to include the genre NAT for nature songs.

	ALTER TABLE song DROP CONSTRAINT song_genre_check;

	ALTER TABLE song ADD CONSTRAINT song_genre_check CHECK(song_genre IN ('PHI','REL','LOV','DEV','PAT','NAT'));

	INSERT INTO song VALUES('A03',5,'Breeze',4.00, 'NAT');

REM 15)Due to typo error, there may be a possibility of false information. Hence while deleting the song information, make sure that all the corresponding information are also deleted.

	ALTER TABLE sungby DROP CONSTRAINT alb_id_track_num_fk;

	ALTER TABLE sungby ADD	CONSTRAINT alb_id_track_num_fk 
						FOREIGN KEY(alb_id, track_num) 
						REFERENCES song(alb_id, track_num) ON DELETE CASCADE;


	SELECT * FROM song;
	SELECT * FROM sungby;
 
REM REMOVAL OF EXISTING RECORD, TO CHECK THE EFFECT OF ON DELETE CASCADE
	DELETE FROM song WHERE alb_id = 'A01' AND track_num = 1;

	SELECT * FROM song;
	SELECT * FROM sungby;


REM ********************************************************************
REM 					END OF SCRIPT FILE
REM ********************************************************************                                                                             

                                                                               
