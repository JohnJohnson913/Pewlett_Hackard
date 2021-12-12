-- Challenge Part One

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

SELECT * FROM retirement_titles;

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;


SELECT * FROM retiring_titles;

-- Challenge Part 2

select
	e.emp_no,
	e.last_name,
	e.first_name,
	e.birth_date,
	string_agg(ttl.title, '/') as titles,
	de.from_date,
	de.to_date
into mentorship_elegibility
from employees as e
	left join titles as ttl
		on e.emp_no = ttl.emp_no
	left join dept_employees as de
		on e.emp_no = de.emp_no
where e.birth_date between '1965-01-01' and '1965-12-31'
	and de.to_date = ('9999-01-01')
group by
	e.emp_no,
	e.first_name,
	e.last_name,
	de.from_date,
	de.to_date
order by emp_no;

SELECT * FROM mentorship_elegibility;

SELECT COUNT(emp_no), titles
FROM mentorship_elegibility
GROUP BY titles
ORDER BY COUNT(titles) DESC;

--Additional research, not specific challenge requirements

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO total_folks
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
ORDER BY emp_no ASC;

SELECT * FROM total_folks

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_total_folks
FROM total_folks
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_total_folks

SELECT COUNT(emp_no), title
INTO unique_total_folks_titles
FROM unique_total_folks
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM unique_total_folks_titles

--NEW MENTOR ##'s

select
	e.emp_no,
	e.last_name,
	e.first_name,
	e.birth_date,
	string_agg(ttl.title, '/') as titles,
	de.from_date,
	de.to_date
into mentorship_elegibility_expanded
from employees as e
	left join titles as ttl
		on e.emp_no = ttl.emp_no
	left join dept_employees as de
		on e.emp_no = de.emp_no
where e.birth_date between '1964-01-01' and '1965-12-31'
	and de.to_date = ('9999-01-01')
group by
	e.emp_no,
	e.first_name,
	e.last_name,
	de.from_date,
	de.to_date
order by last_name;

SELECT * FROM mentorship_elegibility_expanded

SELECT COUNT(emp_no), birth_date
FROM mentorship_elegibility_expanded
GROUP BY birth_date
ORDER BY COUNT(birth_date) DESC;
