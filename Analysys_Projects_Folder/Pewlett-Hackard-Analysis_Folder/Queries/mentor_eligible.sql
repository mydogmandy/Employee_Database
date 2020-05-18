-- Employees eligible for mentorship program
SELECT 
	a.emp_no,
	a.first_name, 
	a.last_name,
	b.title,
	b.from_date,
	b.to_date
INTO mentor_eligible
    -- The INTO command used for new table creation, as reference
FROM employees a
INNER JOIN titles b
	ON a.emp_no = b.emp_no
WHERE 
	(birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (to_date = '9999-01-01');