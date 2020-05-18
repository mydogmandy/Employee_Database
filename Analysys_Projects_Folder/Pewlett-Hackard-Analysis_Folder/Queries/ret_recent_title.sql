-- Create new table for retiring employees by title
SELECT
	a.emp_no,
	a.first_name,
	a.last_name,
	b.salary,
	c.title,
	c.from_date
INTO retiring_titles
FROM 
	employees a
INNER JOIN 
	salaries b
	ON a.emp_no = b.emp_no
INNER JOIN
	titles c
	ON a.emp_no = c.emp_no
WHERE
	a.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
	AND a.hire_date BETWEEN '1985-01-01' AND '1988-12-31';

-- Partition the data to show only most recent 
-- title per employee
SELECT
	emp_no,
	first_name,
	last_name,
	salary,
	title,
	from_date
INTO ret_recent_title
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
	FROM retiring_titles) 
		tmp WHERE rn = 1
ORDER BY emp_no;

-- Get counts of all titles for employees ready to retire
SELECT 
	a.title "Title",
	count(a.title) "Count"
INTO
	ret_title_count
FROM 
	ret_recent_title a
group by 
	a.title
order by 
	a.count;
