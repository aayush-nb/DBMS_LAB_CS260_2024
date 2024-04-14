SELECT first_name, last_name FROM employees;
SELECT department_name, location FROM departments;
SELECT project_name, budget FROM projects;
SELECT employees.first_name, employees.last_name, employees.salary 
FROM employees 
JOIN departments ON employees.department_id = departments.department_id 
WHERE departments.department_name = 'Engineering';
SELECT project_name, start_date FROM projects;
SELECT employees.first_name, employees.last_name, departments.department_name 
FROM employees 
JOIN departments ON employees.department_id = departments.department_id;
SELECT project_name FROM projects WHERE budget > 90000;
SELECT SUM(budget) AS total_budget FROM projects;
SELECT first_name, last_name, salary FROM employees WHERE salary > 60000;
SELECT project_name, end_date FROM projects;
SELECT AVG(salary) AS average_salary FROM employees;
SELECT employees.first_name, employees.last_name, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id
WHERE departments.department_name = 'Finance';
SELECT project_name FROM projects WHERE budget BETWEEN 70000 AND 100000;
SELECT departments.department_name, COUNT(employees.emp_id) AS employee_count
FROM departments
LEFT JOIN employees ON departments.department_id = employees.department_id
GROUP BY departments.department_name;
