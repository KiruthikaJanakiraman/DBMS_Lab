SQL> echo ON
linesize 150
@c:/assign1-104.sql
SQL> set echo on:
SP2-0158: unknown SET option ":"
SQL> 
SQL> prompt DROPPING THE PREVIOUSLY CREATED TABLES
DROPPING THE PREVIOUSLY CREATED TABLES
SQL> 
SQL> DROP TABLE sungby;

Table dropped.

SQL> DROP TABLE song;

Table dropped.

SQL> DROP TABLE artist;

Table dropped.

SQL> DROP TABLE album;

Table dropped.

SQL> DROP TABLE studio;

Table dropped.

SQL> DROP TABLE musician;

Table dropped.

SQL> 
SQL> prompt CREATING THE TABLES
CREATING THE TABLES
SQL> 
SQL> CREATE TABLE musician(
  2  mid VARCHAR(6) PRIMARY KEY,
  3  mname VARCHAR(20),
  4  birthplace VARCHAR(25));

Table created.

SQL> 
SQL> DESC musician;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 MID                                                                                 NOT NULL VARCHAR2(6)
 MNAME                                                                                        VARCHAR2(20)
 BIRTHPLACE                                                                                   VARCHAR2(25)

SQL> 
SQL> CREATE TABLE studio(
  2  stname VARCHAR(20) PRIMARY KEY,
  3  staddr VARCHAR(25),
  4  stdphn NUMBER(14));

Table created.

SQL> 
SQL> DESC studio;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 STNAME                                                                              NOT NULL VARCHAR2(20)
 STADDR                                                                                       VARCHAR2(25)
 STDPHN                                                                                       NUMBER(14)

SQL> 
SQL> CREATE TABLE album(
  2  alname VARCHAR(20),
  3  alid VARCHAR(6) PRIMARY KEY,
  4  release_yr DATE CHECK(EXTRACT(year from release_yr) >= 1945),
  5  no_of_tracks NUMBER(3) NOT NULL,
  6  stname VARCHAR(20) REFERENCES studio(stname),
  7  genre VARCHAR(4) CHECK(genre IN('CAR', 'DIV', 'MOV', 'POP')),
  8  mid VARCHAR(6) REFERENCES musician(mid));

Table created.

SQL> 
SQL> DESC album;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALNAME                                                                                       VARCHAR2(20)
 ALID                                                                                NOT NULL VARCHAR2(6)
 RELEASE_YR                                                                                   DATE
 NO_OF_TRACKS                                                                        NOT NULL NUMBER(3)
 STNAME                                                                                       VARCHAR2(20)
 GENRE                                                                                        VARCHAR2(4)
 MID                                                                                          VARCHAR2(6)

SQL> 
SQL> CREATE TABLE artist(
  2  arid VARCHAR(6) PRIMARY KEY,
  3  arname VARCHAR(20),
  4  CONSTRAINT uniq_aname UNIQUE(arname));

Table created.

SQL> 
SQL> DESC artist;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ARID                                                                                NOT NULL VARCHAR2(6)
 ARNAME                                                                                       VARCHAR2(20)

SQL> 
SQL> CREATE TABLE song(
  2  alid VARCHAR(6),
  3  track_no VARCHAR(6),
  4  sname VARCHAR(20),
  5  length NUMBER(3),
  6  genre VARCHAR(4),
  7  PRIMARY KEY(alid, track_no),
  8  CONSTRAINT fk_alid FOREIGN KEY(alid) REFERENCES album(alid),
  9  CONSTRAINT chk_genre CHECK(genre IN('PHI', 'REL', 'LOV', 'DEV', 'PAT')),
 10  CONSTRAINT chk_len CHECK(length>7 OR genre<>'PAT'));

Table created.

SQL> 
SQL> DESC song;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALID                                                                                NOT NULL VARCHAR2(6)
 TRACK_NO                                                                            NOT NULL VARCHAR2(6)
 SNAME                                                                                        VARCHAR2(20)
 LENGTH                                                                                       NUMBER(3)
 GENRE                                                                                        VARCHAR2(4)

SQL> 
SQL> CREATE TABLE sungby(
  2  alid VARCHAR(6),
  3  track_no VARCHAR(6),
  4  arid VARCHAR(6) REFERENCES artist(arid),
  5  recording_date DATE,
  6  PRIMARY KEY(alid, track_no, arid),
  7  CONSTRAINT fk_sungby FOREIGN KEY(alid, track_no) REFERENCES song(alid, track_no));

Table created.

SQL> 
SQL> DESC sungby;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALID                                                                                NOT NULL VARCHAR2(6)
 TRACK_NO                                                                            NOT NULL VARCHAR2(6)
 ARID                                                                                NOT NULL VARCHAR2(6)
 RECORDING_DATE                                                                               DATE

SQL> 
SQL> prompt DESCRIBING THE TABLES
DESCRIBING THE TABLES
SQL> 
SQL> DESC musician;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 MID                                                                                 NOT NULL VARCHAR2(6)
 MNAME                                                                                        VARCHAR2(20)
 BIRTHPLACE                                                                                   VARCHAR2(25)

SQL> DESC studio;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 STNAME                                                                              NOT NULL VARCHAR2(20)
 STADDR                                                                                       VARCHAR2(25)
 STDPHN                                                                                       NUMBER(14)

SQL> DESC album;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALNAME                                                                                       VARCHAR2(20)
 ALID                                                                                NOT NULL VARCHAR2(6)
 RELEASE_YR                                                                                   DATE
 NO_OF_TRACKS                                                                        NOT NULL NUMBER(3)
 STNAME                                                                                       VARCHAR2(20)
 GENRE                                                                                        VARCHAR2(4)
 MID                                                                                          VARCHAR2(6)

SQL> DESC artist;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ARID                                                                                NOT NULL VARCHAR2(6)
 ARNAME                                                                                       VARCHAR2(20)

SQL> DESC song;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALID                                                                                NOT NULL VARCHAR2(6)
 TRACK_NO                                                                            NOT NULL VARCHAR2(6)
 SNAME                                                                                        VARCHAR2(20)
 LENGTH                                                                                       NUMBER(3)
 GENRE                                                                                        VARCHAR2(4)

SQL> DESC sungby;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALID                                                                                NOT NULL VARCHAR2(6)
 TRACK_NO                                                                            NOT NULL VARCHAR2(6)
 ARID                                                                                NOT NULL VARCHAR2(6)
 RECORDING_DATE                                                                               DATE

SQL> 
SQL> prompt INSERTING VALUES INTO THE TABLES
INSERTING VALUES INTO THE TABLES
SQL> 
SQL> INSERT INTO musician VALUES('m03', 'calvin', 'usa');

1 row created.

SQL> INSERT INTO musician VALUES('m01', 'miguel', 'mexico');

1 row created.

SQL> INSERT INTO musician VALUES('m02', 'elaine', 'france');

1 row created.

SQL> 
SQL> INSERT INTO studio VALUES('big machine', '122 pinwheel road, texas', 7445578787);

1 row created.

SQL> INSERT INTO studio VALUES('yg', 'seoul circle, s.korea', 4445578787);

1 row created.

SQL> INSERT INTO studio VALUES('sm', 'shibuya, tokyo, japan', 3445578787);

1 row created.

SQL> 
SQL> INSERT INTO album VALUES('square up', 'al01', '27-jun-2019', 4, 'yg', 'POP', 'm03');

1 row created.

SQL> INSERT INTO album VALUES('lionheart', 'al11', '23-may-2017', 10, 'sm', 'POP', 'm02');

1 row created.

SQL> INSERT INTO album VALUES('red', 'al04', '12-nov-2012', 13, 'big machine', 'MOV', 'm03');

1 row created.

SQL> INSERT INTO album VALUES('1989', 'al05', '2-oct-2015', 13, 'big machine', 'POP', 'm01');

1 row created.

SQL> 
SQL> INSERT INTO artist VALUES('a01', 'taylor');

1 row created.

SQL> INSERT INTO artist VALUES('a099', 'jennie');

1 row created.

SQL> INSERT INTO artist VALUES('a07', 'yuri');

1 row created.

SQL> 
SQL> INSERT INTO song VALUES('al04', 't01', '22', 212, 'PHI');

1 row created.

SQL> INSERT INTO song VALUES('al05', 't01', 'blank space', 221, 'LOV');

1 row created.

SQL> INSERT INTO song VALUES('al04', 't04', 'safe', 271, 'PAT');

1 row created.

SQL> 
SQL> INSERT INTO sungby VALUES('al05', 't01', 'a01', '27-sep-2014');

1 row created.

SQL> INSERT INTO sungby VALUES('al04', 't04', 'a01', '23-aug-2013');

1 row created.

SQL> INSERT INTO sungby VALUES('al04', 't01', 'a01', '9-may-2009');

1 row created.

SQL> 
SQL> prompt DISPLAYING THE TABLE CONTENTS
DISPLAYING THE TABLE CONTENTS
SQL> 
SQL> SELECT * FROM musician;

MID    MNAME                BIRTHPLACE                                                                                                                
------ -------------------- -------------------------                                                                                                 
m03    calvin               usa                                                                                                                       
m01    miguel               mexico                                                                                                                    
m02    elaine               france                                                                                                                    

SQL> SELECT * FROM studio;

STNAME               STADDR                        STDPHN                                                                                             
-------------------- ------------------------- ----------                                                                                             
big machine          122 pinwheel road, texas  7445578787                                                                                             
yg                   seoul circle, s.korea     4445578787                                                                                             
sm                   shibuya, tokyo, japan     3445578787                                                                                             

SQL> SELECT * FROM album;

ALNAME               ALID   RELEASE_Y NO_OF_TRACKS STNAME               GENR MID                                                                      
-------------------- ------ --------- ------------ -------------------- ---- ------                                                                   
square up            al01   27-JUN-19            4 yg                   POP  m03                                                                      
lionheart            al11   23-MAY-17           10 sm                   POP  m02                                                                      
red                  al04   12-NOV-12           13 big machine          MOV  m03                                                                      
1989                 al05   02-OCT-15           13 big machine          POP  m01                                                                      

SQL> SELECT * FROM artist;

ARID   ARNAME                                                                                                                                         
------ --------------------                                                                                                                           
a01    taylor                                                                                                                                         
a099   jennie                                                                                                                                         
a07    yuri                                                                                                                                           

SQL> SELECT * FROM song;

ALID   TRACK_ SNAME                    LENGTH GENR                                                                                                    
------ ------ -------------------- ---------- ----                                                                                                    
al04   t01    22                          212 PHI                                                                                                     
al05   t01    blank space                 221 LOV                                                                                                     
al04   t04    safe                        271 PAT                                                                                                     

SQL> SELECT * FROM sungby;

ALID   TRACK_ ARID   RECORDING                                                                                                                        
------ ------ ------ ---------                                                                                                                        
al05   t01    a01    27-SEP-14                                                                                                                        
al04   t04    a01    23-AUG-13                                                                                                                        
al04   t01    a01    09-MAY-09                                                                                                                        

SQL> 
SQL> prompt 1)The genre for Album can be generally categorized as CAR for Carnatic, DIV for Divine, MOV for Movies, POP for Pop songs.
1)The genre for Album can be generally categorized as CAR for Carnatic, DIV for Divine, MOV for Movies, POP for Pop songs.
SQL> 
SQL> SELECT * FROM album;

ALNAME               ALID   RELEASE_Y NO_OF_TRACKS STNAME               GENR MID                                                                      
-------------------- ------ --------- ------------ -------------------- ---- ------                                                                   
square up            al01   27-JUN-19            4 yg                   POP  m03                                                                      
lionheart            al11   23-MAY-17           10 sm                   POP  m02                                                                      
red                  al04   12-NOV-12           13 big machine          MOV  m03                                                                      
1989                 al05   02-OCT-15           13 big machine          POP  m01                                                                      

SQL> INSERT INTO album VALUES('square up', 'al01', '01-dec-2019', 4, 'yg', 'RAP', 'm03');
INSERT INTO album VALUES('square up', 'al01', '01-dec-2019', 4, 'yg', 'RAP', 'm03')
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.SYS_C005677) violated 


SQL> 
SQL> prompt 2)The genre for Song can be PHI for philosophical, REL for relationship, LOV for duet, DEV for devotional, PAT for patriotic type of songs.
2)The genre for Song can be PHI for philosophical, REL for relationship, LOV for duet, DEV for devotional, PAT for patriotic type of songs.
SQL> 
SQL> SELECT * FROM song;

ALID   TRACK_ SNAME                    LENGTH GENR                                                                                                    
------ ------ -------------------- ---------- ----                                                                                                    
al04   t01    22                          212 PHI                                                                                                     
al05   t01    blank space                 221 LOV                                                                                                     
al04   t04    safe                        271 PAT                                                                                                     

SQL> INSERT INTO song VALUES('al01', 't04', 'solo', 233, 'JAZZ');
INSERT INTO song VALUES('al01', 't04', 'solo', 233, 'JAZZ')
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.CHK_GENRE) violated 


SQL> 
SQL> prompt 3)The artist ID, album ID, musician ID, and track number, studio name are used toretrieve tuple(s) individually from respective relations.
3)The artist ID, album ID, musician ID, and track number, studio name are used toretrieve tuple(s) individually from respective relations.
SQL> 
SQL> SELECT * FROM artist;

ARID   ARNAME                                                                                                                                         
------ --------------------                                                                                                                           
a01    taylor                                                                                                                                         
a099   jennie                                                                                                                                         
a07    yuri                                                                                                                                           

SQL> INSERT INTO artist VALUES('a01', 'mark');
INSERT INTO artist VALUES('a01', 'mark')
*
ERROR at line 1:
ORA-00001: unique constraint (SYSTEM.SYS_C005681) violated 


SQL> SELECT * FROM album;

ALNAME               ALID   RELEASE_Y NO_OF_TRACKS STNAME               GENR MID                                                                      
-------------------- ------ --------- ------------ -------------------- ---- ------                                                                   
square up            al01   27-JUN-19            4 yg                   POP  m03                                                                      
lionheart            al11   23-MAY-17           10 sm                   POP  m02                                                                      
red                  al04   12-NOV-12           13 big machine          MOV  m03                                                                      
1989                 al05   02-OCT-15           13 big machine          POP  m01                                                                      

SQL> INSERT INTO album VALUES('bigbang', 'al01', 2019, 4, 'yg', 'POP', 'm03');
INSERT INTO album VALUES('bigbang', 'al01', 2019, 4, 'yg', 'POP', 'm03')
                                            *
ERROR at line 1:
ORA-00932: inconsistent datatypes: expected DATE got NUMBER 


SQL> SELECT * FROM musician;

MID    MNAME                BIRTHPLACE                                                                                                                
------ -------------------- -------------------------                                                                                                 
m03    calvin               usa                                                                                                                       
m01    miguel               mexico                                                                                                                    
m02    elaine               france                                                                                                                    

SQL> INSERT INTO musician VALUES('m03', 'canary', 'usa');
INSERT INTO musician VALUES('m03', 'canary', 'usa')
*
ERROR at line 1:
ORA-00001: unique constraint (SYSTEM.SYS_C005673) violated 


SQL> SELECT * FROM sungby;

ALID   TRACK_ ARID   RECORDING                                                                                                                        
------ ------ ------ ---------                                                                                                                        
al05   t01    a01    27-SEP-14                                                                                                                        
al04   t04    a01    23-AUG-13                                                                                                                        
al04   t01    a01    09-MAY-09                                                                                                                        

SQL> INSERT INTO sungby VALUES('al04', 't04', 'a01', '2-dec-2018');
INSERT INTO sungby VALUES('al04', 't04', 'a01', '2-dec-2018')
*
ERROR at line 1:
ORA-00001: unique constraint (SYSTEM.SYS_C005687) violated 


SQL> SELECT * FROM studio;

STNAME               STADDR                        STDPHN                                                                                             
-------------------- ------------------------- ----------                                                                                             
big machine          122 pinwheel road, texas  7445578787                                                                                             
yg                   seoul circle, s.korea     4445578787                                                                                             
sm                   shibuya, tokyo, japan     3445578787                                                                                             

SQL> INSERT INTO studio VALUES('sm', 'big ben, london, uk', 3445578787);
INSERT INTO studio VALUES('sm', 'big ben, london, uk', 3445578787)
*
ERROR at line 1:
ORA-00001: unique constraint (SYSTEM.SYS_C005674) violated 


SQL> 
SQL> prompt 6)It was learnt that the artists do not have the same name.
6)It was learnt that the artists do not have the same name.
SQL> 
SQL> SELECT * FROM artist;

ARID   ARNAME                                                                                                                                         
------ --------------------                                                                                                                           
a01    taylor                                                                                                                                         
a099   jennie                                                                                                                                         
a07    yuri                                                                                                                                           

SQL> INSERT INTO artist VALUES('a23', 'taylor');
INSERT INTO artist VALUES('a23', 'taylor')
*
ERROR at line 1:
ORA-00001: unique constraint (SYSTEM.UNIQ_ANAME) violated 


SQL> 
SQL> prompt 7)The number of tracks in an album must always be recorded.
7)The number of tracks in an album must always be recorded.
SQL> 
SQL> SELECT * FROM album;

ALNAME               ALID   RELEASE_Y NO_OF_TRACKS STNAME               GENR MID                                                                      
-------------------- ------ --------- ------------ -------------------- ---- ------                                                                   
square up            al01   27-JUN-19            4 yg                   POP  m03                                                                      
lionheart            al11   23-MAY-17           10 sm                   POP  m02                                                                      
red                  al04   12-NOV-12           13 big machine          MOV  m03                                                                      
1989                 al05   02-OCT-15           13 big machine          POP  m01                                                                      

SQL> INSERT INTO album VALUES('square up', 'al01', '01-dec-2019', NULL, 'yg', 'POP', 'm03');
INSERT INTO album VALUES('square up', 'al01', '01-dec-2019', NULL, 'yg', 'POP', 'm03')
                                                             *
ERROR at line 1:
ORA-01400: cannot insert NULL into ("SYSTEM"."ALBUM"."NO_OF_TRACKS") 


SQL> 
SQL> prompt 8)The length of each song must be greater than 7 for PAT songs.
8)The length of each song must be greater than 7 for PAT songs.
SQL> 
SQL> SELECT * FROM song;

ALID   TRACK_ SNAME                    LENGTH GENR                                                                                                    
------ ------ -------------------- ---------- ----                                                                                                    
al04   t01    22                          212 PHI                                                                                                     
al05   t01    blank space                 221 LOV                                                                                                     
al04   t04    safe                        271 PAT                                                                                                     

SQL> INSERT INTO song VALUES('al04', 't04', 'safe', 5, 'PAT');
INSERT INTO song VALUES('al04', 't04', 'safe', 5, 'PAT')
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.CHK_LEN) violated 


SQL> 
SQL> prompt 9)The year of release of an album can not be earlier than 1945.
9)The year of release of an album can not be earlier than 1945.
SQL> 
SQL> SELECT * FROM album;

ALNAME               ALID   RELEASE_Y NO_OF_TRACKS STNAME               GENR MID                                                                      
-------------------- ------ --------- ------------ -------------------- ---- ------                                                                   
square up            al01   27-JUN-19            4 yg                   POP  m03                                                                      
lionheart            al11   23-MAY-17           10 sm                   POP  m02                                                                      
red                  al04   12-NOV-12           13 big machine          MOV  m03                                                                      
1989                 al05   02-OCT-15           13 big machine          POP  m01                                                                      

SQL> INSERT INTO album VALUES('green', 'al05', '8-feb-1922', 13, 'big machine', 'POP', 'm01');
INSERT INTO album VALUES('green', 'al05', '8-feb-1922', 13, 'big machine', 'POP', 'm01')
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.SYS_C005676) violated 


SQL> 
SQL> prompt 10)It is necessary to represent the gender of an artist in the table.
10)It is necessary to represent the gender of an artist in the table.
SQL> 
SQL> DESC artist;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ARID                                                                                NOT NULL VARCHAR2(6)
 ARNAME                                                                                       VARCHAR2(20)

SQL> ALTER TABLE artist ADD gender VARCHAR(20);

Table altered.

SQL> DESC artist;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ARID                                                                                NOT NULL VARCHAR2(6)
 ARNAME                                                                                       VARCHAR2(20)
 GENDER                                                                                       VARCHAR2(20)

SQL> 
SQL> prompt 12)The phone number of each studio should be different.
12)The phone number of each studio should be different.
SQL> 
SQL> ALTER TABLE studio ADD CONSTRAINT uniq_phn UNIQUE(stdphn);

Table altered.

SQL> DESC studio;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 STNAME                                                                              NOT NULL VARCHAR2(20)
 STADDR                                                                                       VARCHAR2(25)
 STDPHN                                                                                       NUMBER(14)

SQL> SELECT * FROM studio;

STNAME               STADDR                        STDPHN                                                                                             
-------------------- ------------------------- ----------                                                                                             
big machine          122 pinwheel road, texas  7445578787                                                                                             
yg                   seoul circle, s.korea     4445578787                                                                                             
sm                   shibuya, tokyo, japan     3445578787                                                                                             

SQL> INSERT INTO studio VALUES('sm', 'shibuya, tokyo, japan', 4445578787);
INSERT INTO studio VALUES('sm', 'shibuya, tokyo, japan', 4445578787)
*
ERROR at line 1:
ORA-00001: unique constraint (SYSTEM.SYS_C005674) violated 


SQL> 
SQL> prompt 13)An artist who sings a song for a particular track of an album can not be recorded without the record_date.
13)An artist who sings a song for a particular track of an album can not be recorded without the record_date.
SQL> 
SQL> ALTER TABLE sungby MODIFY recording_date DATE NOT NULL;

Table altered.

SQL> DESC sungby;
 Name                                                                                Null?    Type
 ----------------------------------------------------------------------------------- -------- --------------------------------------------------------
 ALID                                                                                NOT NULL VARCHAR2(6)
 TRACK_NO                                                                            NOT NULL VARCHAR2(6)
 ARID                                                                                NOT NULL VARCHAR2(6)
 RECORDING_DATE                                                                      NOT NULL DATE

SQL> SELECT * FROM sungby;

ALID   TRACK_ ARID   RECORDING                                                                                                                        
------ ------ ------ ---------                                                                                                                        
al05   t01    a01    27-SEP-14                                                                                                                        
al04   t04    a01    23-AUG-13                                                                                                                        
al04   t01    a01    09-MAY-09                                                                                                                        

SQL> INSERT INTO sungby VALUES('al04', 't01', 'a01', NULL);
INSERT INTO sungby VALUES('al04', 't01', 'a01', NULL)
                                                *
ERROR at line 1:
ORA-01400: cannot insert NULL into ("SYSTEM"."SUNGBY"."RECORDING_DATE") 


SQL> 
SQL> prompt 14)It was decided to include the genre NAT for nature songs.
14)It was decided to include the genre NAT for nature songs.
SQL> 
SQL> SELECT * FROM song;

ALID   TRACK_ SNAME                    LENGTH GENR                                                                                                    
------ ------ -------------------- ---------- ----                                                                                                    
al04   t01    22                          212 PHI                                                                                                     
al05   t01    blank space                 221 LOV                                                                                                     
al04   t04    safe                        271 PAT                                                                                                     

SQL> ALTER TABLE song DROP CONSTRAINT chk_genre;

Table altered.

SQL> ALTER TABLE song ADD CONSTRAINT chk_genre CHECK(genre IN('PHI', 'REL', 'LOV', 'DEV', 'PAT', 'NAT'));

Table altered.

SQL> INSERT INTO song VALUES('al01', 't04', 'solo', 233, 'NAT');

1 row created.

SQL> SELECT * FROM song;

ALID   TRACK_ SNAME                    LENGTH GENR                                                                                                    
------ ------ -------------------- ---------- ----                                                                                                    
al04   t01    22                          212 PHI                                                                                                     
al05   t01    blank space                 221 LOV                                                                                                     
al04   t04    safe                        271 PAT                                                                                                     
al01   t04    solo                        233 NAT                                                                                                     

SQL> 
SQL> prompt 15)Due to typo­error, there may be a possibility of false information.
15)Due to typo­error, there may be a possibility of false information.
SQL> REM:Hence while deleting the song information, make sure that all the corresponding information are also deleted.
SQL> 
SQL> ALTER TABLE sungby DROP CONSTRAINT fk_sungby;

Table altered.

SQL> ALTER TABLE sungby ADD CONSTRAINT fk_sungby FOREIGN KEY(alid, track_no) REFERENCES song(alid, track_no) ON DELETE CASCADE;

Table altered.

SQL> 
SQL> SELECT * FROM song;

ALID   TRACK_ SNAME                    LENGTH GENR                                                                                                    
------ ------ -------------------- ---------- ----                                                                                                    
al04   t01    22                          212 PHI                                                                                                     
al05   t01    blank space                 221 LOV                                                                                                     
al04   t04    safe                        271 PAT                                                                                                     
al01   t04    solo                        233 NAT                                                                                                     

SQL> SELECT * FROM sungby;

ALID   TRACK_ ARID   RECORDING                                                                                                                        
------ ------ ------ ---------                                                                                                                        
al05   t01    a01    27-SEP-14                                                                                                                        
al04   t04    a01    23-AUG-13                                                                                                                        
al04   t01    a01    09-MAY-09                                                                                                                        

SQL> DELETE FROM song WHERE sname='safe';

1 row deleted.

SQL> SELECT * FROM song;

ALID   TRACK_ SNAME                    LENGTH GENR                                                                                                    
------ ------ -------------------- ---------- ----                                                                                                    
al04   t01    22                          212 PHI                                                                                                     
al05   t01    blank space                 221 LOV                                                                                                     
al01   t04    solo                        233 NAT                                                                                                     

SQL> SELECT * FROM sungby;

ALID   TRACK_ ARID   RECORDING                                                                                                                        
------ ------ ------ ---------                                                                                                                        
al05   t01    a01    27-SEP-14                                                                                                                        
al04   t01    a01    09-MAY-09                                                                                                                        

SQL> 
SQL> SELECT * FROM musician;

MID    MNAME                BIRTHPLACE                                                                                                                
------ -------------------- -------------------------                                                                                                 
m03    calvin               usa                                                                                                                       
m01    miguel               mexico                                                                                                                    
m02    elaine               france                                                                                                                    

SQL> SELECT * FROM studio;

STNAME               STADDR                        STDPHN                                                                                             
-------------------- ------------------------- ----------                                                                                             
big machine          122 pinwheel road, texas  7445578787                                                                                             
yg                   seoul circle, s.korea     4445578787                                                                                             
sm                   shibuya, tokyo, japan     3445578787                                                                                             

SQL> SELECT * FROM album;

ALNAME               ALID   RELEASE_Y NO_OF_TRACKS STNAME               GENR MID                                                                      
-------------------- ------ --------- ------------ -------------------- ---- ------                                                                   
square up            al01   27-JUN-19            4 yg                   POP  m03                                                                      
lionheart            al11   23-MAY-17           10 sm                   POP  m02                                                                      
red                  al04   12-NOV-12           13 big machine          MOV  m03                                                                      
1989                 al05   02-OCT-15           13 big machine          POP  m01                                                                      

SQL> SELECT * FROM artist;

ARID   ARNAME               GENDER                                                                                                                    
------ -------------------- --------------------                                                                                                      
a01    taylor                                                                                                                                         
a099   jennie                                                                                                                                         
a07    yuri                                                                                                                                           

SQL> SELECT * FROM song;

ALID   TRACK_ SNAME                    LENGTH GENR                                                                                                    
------ ------ -------------------- ---------- ----                                                                                                    
al04   t01    22                          212 PHI                                                                                                     
al05   t01    blank space                 221 LOV                                                                                                     
al01   t04    solo                        233 NAT                                                                                                     

SQL> SELECT * FROM sungby;

ALID   TRACK_ ARID   RECORDING                                                                                                                        
------ ------ ------ ---------                                                                                                                        
al05   t01    a01    27-SEP-14                                                                                                                        
al04   t01    a01    09-MAY-09                                                                                                                        

SQL> spool off
