REM: 			ASSIGNMENT 2
REM: *************************************************
REM: Part – I : DML Update operations & TCL statements
REM: *************************************************
	
drop table classes;

REM: Creating classes table

	create table classes(class varchar2(20),
	type varchar2(5),
	country varchar2(20),
	numGuns number(2),
	bore number(2),
	displacement number(5),
	CONSTRAINT classes_pk PRIMARY KEY(class));

REM: Classes schema

	desc classes

REM: 1)Add first two tuples from the above sample data.
REM:   List the columns explicitly in the INSERT clause. (No ordering of columns)

	INSERT into classes
	(class,country,bore,type,numGuns,displacement)	
	VALUES('Bismark','Germany',14,'bb',8,32000);

	
	INSERT into classes
	(class,country,bore,type,numGuns,displacement)	
	VALUES('Iowa','USA',16,'bb',9,46000);
	
	select * from classes;	

REM: 2)Populate the relation with the remaining set of tuples. This time,
REM:   do not list the columns in the INSERT clause. 

	INSERT into classes	
	VALUES('Kongo','bc','Japan',8,15,42000);

	INSERT into classes	
	VALUES('North Carolina','bb','USA',9,16,37000);

	INSERT into classes	
	VALUES('Revenge','bb','Gt. Britain',8,15,29000);

	INSERT into classes	
	VALUES('Renown','bc','Gt. Britain',6,15,32000);

REM: 3)Display the populated relation.

	select * from classes;

REM: 4)Mark an intermediate point here in this transaction.

	SAVEPOINT A;

REM: 5)Change the displacement of Bismark to 34000.

	UPDATE classes
	SET displacement = 34000 WHERE class = 'Bismark';

REM: Displaying after updating
	
	select * from classes;

REM:6)For the battleships having at least 9 number of guns or the ships
REM:  with at least 15 inch bore, increase the displacement by 10%. 
REM:  Verify your changes to the table.

	UPDATE classes
	SET displacement=displacement+(0.1*displacement)
	WHERE numGuns>=9 OR bore>=15;
	
	select * from classes;

REM: 7)Delete Kongo class of ship from Classes table.

	DELETE from classes
	where class='Kongo';	

REM: 8)Display your changes to the table.

	select * from classes;

REM: 9)Discard the recent updates to the relation without discarding the earlier INSERT operation(s)

	ROLLBACK TO A;

	select * from classes;

REM: 10)Commit the changes.

	COMMIT;