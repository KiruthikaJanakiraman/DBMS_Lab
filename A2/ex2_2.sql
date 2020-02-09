REM: 			ASSIGNMENT 2
REM: ***********************************************************************************************
REM: Part –  II : DML Retrieval operations
REM: ***********************************************************************************************

drop table employees;

@z:/employees.sql

REM:Displaying all

	select * from employees;

REM:11. Display firsy name, job id and salary of all the employees.

	select first_name, job_id, salary from employees;

REM:12. Display the id, name(first & last), salary and annual salary 
REM:of all the employees. Sort the employees by first name.
REM:Label the columns as shown below:(EMPLOYEE_ID, FULL NAME, MONTHLY SAL, ANNUAL SALARY)

	SELECT employee_id, first_name||' '||last_name AS full_name,salary as monthly_salary,salary*12 AS annual_salary
	FROM employees
	ORDER by first_name; 

REM:13. List the different jobs in which the employees are working for.

	SELECT DISTINCT(job_id) from employees;


REM:14. Display the id, first name, job id, salary and commission of employees who are earning commissions.

	SELECT employee_id,first_name,last_name,job_id,salary,commission_pct
	FROM employees
	WHERE commission_pct is NOT NULL;

REM:15. Display the details (id, first name, job id, salary and dept id) of employees who are MANAGERS.

	SELECT employee_id,first_name,job_id,salary,department_id
	FROM employees
	WHERE employee_id IN(select manager_id from employees);

REM:16. Display the details of employees other than sales representatives
REM:(id, first name, hire date, job id, salary and dept id) who are 
REM:hired after ‘01­May­1999’ or whose salary is at least 10000.

	SELECT employee_id,first_name,hire_date,job_id,salary,department_id
	FROM employees
	WHERE job_id <> 'SA_REP' AND (hire_date > '01­May­1999' OR salary>=10000);

REM:17. Display the employee details (first name, salary, hire date and dept id) whose salary falls in the
REM:range of 5000 to 15000 and his/her name begins with any of characters (A,J,K,S). Sort the output by first name.

	SELECT first_name,salary,hire_date,department_id
	FROM employees
	WHERE (salary BETWEEN 5000 AND 15000) AND (first_name LIKE 'A%' OR first_name LIKE 'J%' OR first_name LIKE 'K%' OR first_name LIKE 'S%')
	ORDER BY first_name;

REM:18. Display the experience of employees in no. of years and months who were hired after 1998. Label the columns as: 
REM:(EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, EXP­YRS, EXP­MONTHS)

	SELECT employee_id,first_name,hire_date,(extract(year from sysdate) - extract(year from hire_date)) AS exp_yrs,floor(mod(months_between(sysdate,hire_date),12)) AS exp_months
	FROM employees
	WHERE extract(YEAR from hire_date)>1998;

REM:19. Display the total number of departments.

	SELECT COUNT(DISTINCT(department_id)) AS count_dept
	FROM employees;

REM:20. Show the number of employees hired by year­wise. Sort the result by year­wise.

	SELECT extract(year from hire_date) as hire_year,count(*) as no_of_emp
	FROM employees
	GROUP BY extract(year from hire_date)
	ORDER BY hire_year;

REM:21. Display the minimum, maximum and average salary, number of employees for each department. Exclude the employee(s) who are not in 
REM:any department. Include the department(s) with 
REM:at least 2 employees and the average salary is more than 10000. Sort the result by minimum salary in descending order.

	SELECT department_id,min(salary) AS min_sal ,max(salary) AS max_sal ,avg(salary) AS avg_sal,count(*) as no_of_emp
	FROM employees
	WHERE department_id IS NOT NULL
	GROUP BY department_id
	HAVING count(*)>=2 AND avg(salary)>10000
	ORDER BY min_sal desc;