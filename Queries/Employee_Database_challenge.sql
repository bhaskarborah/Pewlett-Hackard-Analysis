-- check data from employees
select * from employees;

-- get the employee number, first name and last name from employees
select emp_no, first_name, last_name from employees;

-- check the titles table
select * from titles;

-- get the emp_no, title, from_date, to_date from titles
select emp_no, title, from_date, to_date from titles;

-- join employees and titles tables and load them into table: retirement_titles
select emp.emp_no, emp.first_name, emp.last_name,tit.title, tit.from_date,tit.to_date 
INTO retirement_titles
from employees emp
inner join titles tit
on emp.emp_no=tit.emp_no
where emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
order by emp.emp_no;

-- check the table: retirement_titles
select * from retirement_titles;

-- get only the required columns from retirement_titles
select emp_no, first_name, last_name from retirement_titles;

-- Use Distinct with Orderby to remove duplicate rows
-- Load the unique tiled employees in the table unique_titles
SELECT DISTINCT ON (emp_no) emp_no, 
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- check the data in the unique_titles table
select * from unique_titles;

-- create a new table: retiring_titles_count to hold the count of all the retiring employees, title wise
select count(*), title  
INTO retiring_titles_count
from unique_titles group by title order by count(*) desc;

-- check the data in the table retiring_titles_count
select * from retiring_titles_count;

-- Create the required mentorship eligibilty table
select distinct on (emp.emp_no) emp.emp_no,
emp.first_name,
emp.last_name,
emp.birth_date,
dept_e.from_date,
dept_e.to_date,
tit.title
into mentorship_eligibilty
from employees emp
inner join dept_emp dept_e
on emp.emp_no = dept_e.emp_no
inner join titles tit 
on emp.emp_no = tit.emp_no
WHERE dept_e.to_date = ('9999-01-01')
AND emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp.emp_no;
