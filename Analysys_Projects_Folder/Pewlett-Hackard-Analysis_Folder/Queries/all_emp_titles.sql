-- Create new table for all employees by title
SELECT
	a.emp_no,
	a.first_name,
	a.last_name,
	b.salary,
	c.title,
	c.from_date
INTO all_emp_titles
FROM 
	employees a
INNER JOIN 
	salaries b
	ON a.emp_no = b.emp_no
INNER JOIN
	titles c
	ON a.emp_no = c.emp_no;
	
-- Partition the data to show only most recent title per employee
SELECT
	emp_no,
	first_name,
	last_name,
	salary,
	title,
	from_date
INTO all_recent_title
FROM
	(SELECT
		emp_no,
		first_name,
		last_name,
		salary,
		title,
		from_date,
		ROW_NUMBER() OVER
	(PARTITION BY (emp_no)
	ORDER BY from_date DESC) rn
	FROM all_emp_titles) 
		tmp WHERE rn = 1
ORDER BY emp_no
;