SQL> @z:/ex1.sql
SQL> REM : Deleting table based on hierarchy
SQL> 
SQL> 	     drop table sungby;

Table dropped. 

SQL> 
SQL> 	     drop table artist;

Table dropped.

SQL> 
SQL> 	     drop table song;

Table dropped.

SQL> 
SQL> 	     drop table album;

Table dropped.

SQL> 
SQL> 	     drop table musician;

Table dropped.

SQL> 
SQL> 	     drop table studio;

Table dropped.

SQL> 
SQL> REM: a)create musician table
SQL> 
SQL> 	     create table musician(m_id varchar2(4),
  2  	     m_name varchar(20),
  3  	     birthplace varchar2(20),
  4  	     CONSTRAINT m_id_pk PRIMARY KEY(m_id));

Table created.

SQL> 
SQL> 	     desc musician;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 M_ID                                                                                NOT NULL VARCHAR2(4)
 M_NAME                                                                                       VARCHAR2(20)
 BIRTHPLACE                                                                                   VARCHAR2(20)

SQL> 
SQL> REM: Entering values into MUSICIAN
SQL> 
SQL> 	     insert into musician values('001','AR Rahman','Chennai');

1 row created.

SQL> 	     insert into musician values('002','Anirudh','Chennai');

1 row created.

SQL> 	     insert into musician values('003','Ilayaraja','Chennai');

1 row created.

SQL> 
SQL> REM: Displaying MUSICIAN table
SQL> 
SQL> 	     select * from musician;

M_ID M_NAME               BIRTHPLACE                                                                                                                  
---- -------------------- --------------------                                                                                                        
001  AR Rahman            Chennai                                                                                                                     
002  Anirudh              Chennai                                                                                                                     
003  Ilayaraja            Chennai                                                                                                                     

SQL> 
SQL> REM: f)Creating STUDIO table
SQL> 
SQL> 	     create table studio(st_name varchar2(20),
  2  	     address varchar2(20),
  3  	     phone number(10),
  4  	     CONSTRAINT st_name_pk primary key(st_name));

Table created.

SQL> 
SQL> 	     desc studio;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ST_NAME                                                                             NOT NULL VARCHAR2(20)
 ADDRESS                                                                                      VARCHAR2(20)
 PHONE                                                                                        NUMBER(10)

SQL> 
SQL> REM: Entering values into STUDIO
SQL> 
SQL> 	     insert into studio values('Medley Studio','KK Nagar','1234567897');

1 row created.

SQL> 	     insert into studio values('Lakshman Shruti','Vadapalani','7584948345');

1 row created.

SQL> 	     insert into studio values('Raja Studio','Ashok Nagar','7549368345');

1 row created.

SQL> 
SQL> REM: Displaying STUDIO table
SQL> 
SQL> 	     select * from studio;

ST_NAME              ADDRESS                   PHONE                                                                                                  
-------------------- -------------------- ----------                                                                                                  
Medley Studio        KK Nagar             1234567897                                                                                                  
Lakshman Shruti      Vadapalani           7584948345                                                                                                  
Raja Studio          Ashok Nagar          7549368345                                                                                                  

SQL> 
SQL> REM: b)Creating ALBUM table
SQL> 
SQL> 	     create table album(alb_name varchar2(20),
  2  	     alb_id varchar2(10),
  3  	     year number(4),
  4  	     num_tracks number(2),
  5  	     st_name varchar2(20),
  6  	     alb_genre varchar2(20),
  7  	     m_id varchar2(4),
  8  	     CONSTRAINT alb_id_pk PRIMARY KEY(alb_id),
  9  	     CONSTRAINT m_id_fk FOREIGN KEY(m_id) REFERENCES musician(m_id),
 10  	     CONSTRAINT st_name_fk FOREIGN KEY(st_name) REFERENCES studio(st_name),
 11  	     CONSTRAINT yr_check check(year>=1945),
 12  	     CONSTRAINT alb_genre_check check( alb_genre in('CAR', 'DIV', 'MOV', 'POP')));

Table created.

SQL> 
SQL> 
SQL> 	     desc album;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALB_NAME                                                                                     VARCHAR2(20)
 ALB_ID                                                                              NOT NULL VARCHAR2(10)
 YEAR                                                                                         NUMBER(4)
 NUM_TRACKS                                                                                   NUMBER(2)
 ST_NAME                                                                                      VARCHAR2(20)
 ALB_GENRE                                                                                    VARCHAR2(20)
 M_ID                                                                                         VARCHAR2(4)

SQL> 
SQL> REM: Entering values into ALBUM
SQL> 
SQL> 	     insert into album values('I','A01','2017','6','Medley Studio','MOV','001');

1 row created.

SQL> 	     insert into album values('Raja Rani','A02','2015','7','Raja Studio','MOV','003');

1 row created.

SQL> 	     insert into album values('Super Deluxe','A03','2019','3','Lakshman Shruti','MOV','002');

1 row created.

SQL> 
SQL> REM: Year check constraint violation
SQL> 
SQL> 	     insert into album values('Vaaranam Aayiram','A03','1942','3','Lakshman Shruti','MOV','002');
  	insert into album values('Vaaranam Aayiram','A03','1942','3','Lakshman Shruti','MOV','002')
*
ERROR at line 1:
ORA-02290: check constraint (1078.YR_CHECK) violated 


SQL> 
SQL> REM: Album genre check constraint viloation
SQL> 
SQL> 	     insert into album values('Bigil','A03','1942','3','Lakshman Shruti','HIP','002');
   	insert into album values('Bigil','A03','1942','3','Lakshman Shruti','HIP','002')
*
ERROR at line 1:
ORA-02290: check constraint (1078.ALB_GENRE_CHECK) violated 


SQL> 
SQL> REM: Displaying ALBUM table
SQL> 
SQL> 	     select * from album;

ALB_NAME             ALB_ID           YEAR NUM_TRACKS ST_NAME              ALB_GENRE            M_ID                                                  
-------------------- ---------- ---------- ---------- -------------------- -------------------- ----                                                  
I                    A01              2017          6 Medley Studio        MOV                  001                                                   
Raja Rani            A02              2015          7 Raja Studio          MOV                  003                                                   
Super Deluxe         A03              2019          3 Lakshman Shruti      MOV                  002                                                   

SQL> 
SQL> REM: c)Creating SONG table
SQL> 
SQL> 	     create table song(alb_id varchar2(10),
  2  	     track_num number(2),
  3  	     song_name varchar2(20) CONSTRAINT sname_null NOT NULL,
  4  	     length number(4),
  5  	     song_genre varchar2(20),
  6  	     CONSTRAINT song_pk PRIMARY KEY(alb_id,track_num),
  7  	     CONSTRAINT alb_id_fk FOREIGN KEY(alb_id) REFERENCES album(alb_id),
  8  	     CONSTRAINT song_genre_check check(song_genre in('PHI', 'REL', 'LOV', 'PAT')),
  9  	     constraint chk check((length>7 AND song_genre='PAT') OR song_genre<>'PAT'));

Table created.

SQL> 
SQL> 	     desc song;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALB_ID                                                                              NOT NULL VARCHAR2(10)
 TRACK_NUM                                                                           NOT NULL NUMBER(2)
 SONG_NAME                                                                           NOT NULL VARCHAR2(20)
 LENGTH                                                                                       NUMBER(4)
 SONG_GENRE                                                                                   VARCHAR2(20)

SQL> 
SQL> REM: Entering values into SONG
SQL> 
SQL> 	     insert into song values('A01',1,'Ladio',4,'REL');

1 row created.

SQL> 	     insert into song values('A02',2,'Hey Baby',3,'LOV');

1 row created.

SQL> 	     insert into song values('A03',3,'Oh Shanti',4,'LOV');

1 row created.

SQL> 
SQL> REM: Genre PAT length check constraint violation
SQL> 
SQL> 	     insert into song values('A03',3,'Vandhe Mataram',6,'PAT');
   	insert into song values('A03',3,'Vandhe Mataram',6,'PAT')
*
ERROR at line 1:
ORA-02290: check constraint (1078.CHK) violated 


SQL> 
SQL> REM: Song genre check constraint violation
SQL> 
SQL> 	     insert into song values('A03',3,'Wow',6,'EDM');
	insert into song values('A03',3,'Wow',6,'EDM')
*
ERROR at line 1:
ORA-02290: check constraint (1078.SONG_GENRE_CHECK) violated 


SQL> 
SQL> REM: Displaying SONG table
SQL> 
SQL> 	     select * from song;

ALB_ID      TRACK_NUM SONG_NAME                LENGTH SONG_GENRE                                                                                      
---------- ---------- -------------------- ---------- --------------------                                                                            
A01                 1 Ladio                         4 REL                                                                                             
A02                 2 Hey Baby                      3 LOV                                                                                             
A03                 3 Oh Shanti                     4 LOV                                                                                             

SQL> 
SQL> REM: d)Creating ARTIST table
SQL> 
SQL> 	     create table artist(art_id varchar2(4),
  2  	     art_name varchar2(20),
  3  	     CONSTRAINT art_id_pk PRIMARY KEY(art_id),
  4  	     CONSTRAINT art_name_uniq UNIQUE(art_name));

Table created.

SQL> 
SQL> 	     desc artist;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ART_ID                                                                              NOT NULL VARCHAR2(4)
 ART_NAME                                                                                     VARCHAR2(20)

SQL> 
SQL> REM: Entering values into ARTIST
SQL> 
SQL> 	     insert into artist values('a001','Sid Sriram');

1 row created.

SQL> 	     insert into artist values('a002','Anirudh');

1 row created.

SQL> 	     insert into artist values('a003','Shankar Mahadevan');

1 row created.

SQL> 
SQL> REM: Unique constraint violation
SQL> 
SQL> 	     insert into artist values('a004','Shankar Mahadevan');
   	insert into artist values('a004','Shankar Mahadevan')
*
ERROR at line 1:
ORA-00001: unique constraint (1078.ART_NAME_UNIQ) violated 


SQL> 
SQL> REM: Displaying ARTIST table
SQL> 
SQL> 	     select * from artist;

ART_ ART_NAME                                                                                                                                         
---- --------------------                                                                                                                             
a001 Sid Sriram                                                                                                                                       
a002 Anirudh                                                                                                                                          
a003 Shankar Mahadevan                                                                                                                                

SQL> 
SQL> REM: e)Creating SUNGBY table
SQL> 
SQL> 	     create table sungby(alb_id varchar2(4),
  2  	     art_id varchar2(4),
  3  	     track_num number(2),
  4  	     rec_date date,
  5  	     CONSTRAINT sungby_pk PRIMARY KEY(alb_id,art_id,track_num),
  6  	     CONSTRAINT alb_id_track_num_fk FOREIGN KEY(alb_id,track_num) REFERENCES song(alb_id,track_num),
  7  	     CONSTRAINT art_id_fk FOREIGN KEY(art_id) REFERENCES artist(art_id));

Table created.

SQL> 
SQL> 	     desc sungby;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALB_ID                                                                              NOT NULL VARCHAR2(4)
 ART_ID                                                                              NOT NULL VARCHAR2(4)
 TRACK_NUM                                                                           NOT NULL NUMBER(2)
 REC_DATE                                                                                     DATE

SQL> 
SQL> REM: Entering values into SUNGBY
SQL> 
SQL> 	     insert into sungby values('A01','a001',1,'20FEB2016');

1 row created.

SQL> 	     insert into sungby values('A02','a002',2,'25JUN2013');

1 row created.

SQL> 	     insert into sungby values('A03','a003',3,'28MAY2013');

1 row created.

SQL> 
SQL> REM: Displaying SUNGBY table
SQL> 
SQL> 	     select * from sungby;

ALB_ ART_  TRACK_NUM REC_DATE                                                                                                                         
---- ---- ---------- ---------                                                                                                                        
A01  a001          1 20-FEB-16                                                                                                                        
A02  a002          2 25-JUN-13                                                                                                                        
A03  a003          3 28-MAY-13                                                                                                                        

SQL> 
SQL> REM ********************************************************************
SQL> REM				     ALTER TABLE QUERIES
SQL> REM ********************************************************************
SQL> 
SQL> REM 10)It is necessary to represent the gender of an artist in the table
SQL> 
SQL> 	     ALTER TABLE artist ADD gender CHAR(1);

Table altered.

SQL> 	     desc artist;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ART_ID                                                                              NOT NULL VARCHAR2(4)
 ART_NAME                                                                                     VARCHAR2(20)
 GENDER                                                                                       CHAR(1)

SQL> 
SQL> 	     INSERT INTO artist VALUES('a004','Yuvan','M');

1 row created.

SQL> 	     select * from artist;

ART_ ART_NAME             G                                                                                                                           
---- -------------------- -                                                                                                                           
a001 Sid Sriram                                                                                                                                       
a002 Anirudh                                                                                                                                          
a003 Shankar Mahadevan                                                                                                                                
a004 Yuvan                M                                                                                                                           

SQL> 
SQL> REM 11)The first few words of the lyrics constitute the song name. The song name do not accommodate some of the words (in lyrics).
SQL> 
SQL> 	     ALTER TABLE song MODIFY song_name VARCHAR2(50);

Table altered.

SQL> 	     desc song;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALB_ID                                                                              NOT NULL VARCHAR2(10)
 TRACK_NUM                                                                           NOT NULL NUMBER(2)
 SONG_NAME                                                                           NOT NULL VARCHAR2(50)
 LENGTH                                                                                       NUMBER(4)
 SONG_GENRE                                                                                   VARCHAR2(20)

SQL> 
SQL> 	     insert into song values('A03',4,'Nenjukul peithidum maamazhai','20','LOV');

1 row created.

SQL> 
SQL> REM 12)The phone number of each studio should be different.
SQL> 
SQL> 	     ALTER TABLE studio ADD CONSTRAINT ph_uk UNIQUE(phone);

Table altered.

SQL> 
SQL> 	     REM: Phone unique constraint violation
SQL> 	     INSERT INTO studio VALUES('6D','Bangalore', 1234567897);
	INSERT INTO studio VALUES('6D','Bangalore', 1234567897)
*
ERROR at line 1:
ORA-00001: unique constraint (1078.PH_UK) violated 


SQL> 
SQL> REM 13)An artist who sings a song for a particular track of an album can not be recorded without the record_date.
SQL> 
SQL> 	     ALTER TABLE sungby MODIFY (rec_date NOT NULL);

Table altered.

SQL> 	     INSERT INTO sungby(track_num,alb_id,art_id) VALUES(1,'A01','a002');
	INSERT INTO sungby(track_num,alb_id,art_id) VALUES(1,'A01','a002')
*
ERROR at line 1:
ORA-01400: cannot insert NULL into ("1078"."SUNGBY"."REC_DATE") 


SQL> 
SQL> REM 14)It was decided to include the genre NAT for nature songs.
SQL> 
SQL> 	     ALTER TABLE song DROP CONSTRAINT song_genre_check;

Table altered.

SQL> 
SQL> 	     ALTER TABLE song ADD CONSTRAINT song_genre_check CHECK(song_genre IN ('PHI','REL','LOV','DEV','PAT','NAT'));

Table altered.

SQL> 
SQL> 	     INSERT INTO song VALUES('A03',5,'Breeze',4.00, 'NAT');

1 row created.

SQL> 
SQL> REM 15)Due to typo error, there may be a possibility of false information. Hence while deleting the song information, make sure that all the corresponding information are also deleted.
SQL> 
SQL> 	     ALTER TABLE sungby DROP CONSTRAINT alb_id_track_num_fk;

Table altered.

SQL> 
SQL> 	     ALTER TABLE sungby ADD  CONSTRAINT alb_id_track_num_fk
  2  						     FOREIGN KEY(alb_id, track_num)
  3  						     REFERENCES song(alb_id, track_num) ON DELETE CASCADE;

Table altered.

SQL> 
SQL> 
SQL> 	     SELECT * FROM song;

ALB_ID      TRACK_NUM SONG_NAME                                              LENGTH SONG_GENRE                                                        
---------- ---------- -------------------------------------------------- ---------- --------------------                                              
A01                 1 Ladio                                                       4 REL                                                               
A02                 2 Hey Baby                                                    3 LOV                                                               
A03                 3 Oh Shanti                                                   4 LOV                                                               
A03                 4 Nenjukul peithidum maamazhai                               20 LOV                                                               
A03                 5 Breeze                                                      4 NAT                                                               

SQL> 	     SELECT * FROM sungby;

ALB_ ART_  TRACK_NUM REC_DATE                                                                                                                         
---- ---- ---------- ---------                                                                                                                        
A01  a001          1 20-FEB-16                                                                                                                        
A02  a002          2 25-JUN-13                                                                                                                        
A03  a003          3 28-MAY-13                                                                                                                        

SQL> 
SQL> REM REMOVAL OF EXISTING RECORD, TO CHECK THE EFFECT OF ON DELETE CASCADE
SQL> 	     DELETE FROM song WHERE alb_id = 'A01' AND track_num = 1;

1 row deleted.

SQL> 
SQL> 	     SELECT * FROM song;

ALB_ID      TRACK_NUM SONG_NAME                                              LENGTH SONG_GENRE                                                        
---------- ---------- -------------------------------------------------- ---------- --------------------                                              
A02                 2 Hey Baby                                                    3 LOV                                                               
A03                 3 Oh Shanti                                                   4 LOV                                                               
A03                 4 Nenjukul peithidum maamazhai                               20 LOV                                                               
A03                 5 Breeze                                                      4 NAT                                                               

SQL> 	     SELECT * FROM sungby;

ALB_ ART_  TRACK_NUM REC_DATE                                                                                                                         
---- ---- ---------- ---------                                                                                                                        
A02  a002          2 25-JUN-13                                                                                                                        
A03  a003          3 28-MAY-13                                                                                                                        

SQL> 
SQL> 
SQL> REM ********************************************************************
SQL> REM				     END OF SCRIPT FILE
SQL> REM ********************************************************************
SQL> 
SQL> 
SQL> spool off
