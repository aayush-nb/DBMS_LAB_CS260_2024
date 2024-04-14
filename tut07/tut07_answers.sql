CREATE PROCEDURE CalculateAvgSalaryInDepartment(IN dept_id INT)
    SELECT AVG(salary) AS avg_salary
    FROM employees
    WHERE department_id = dept_id;
CREATE PROCEDURE ListEmployeesInDepartment(IN dept_id INT)
    SELECT *
    FROM employees
    WHERE department_id = dept_id;
CREATE PROCEDURE CalculateProjectBudget(IN proj_id INT)
    SELECT SUM(budget) AS total_budget
    FROM projects
    WHERE project_id = proj_id;
CREATE PROCEDURE FindHighestSalaryEmployeeInDepartment(IN dept_id INT)
    SELECT *
    FROM employees
    WHERE department_id = dept_id
    ORDER BY salary DESC
    LIMIT 1;
CREATE PROCEDURE ListProjectsEndingSoon(IN days INT)
    SELECT *
    FROM projects
    WHERE DATEDIFF(end_date, CURDATE()) <= days;
CREATE PROCEDURE CalculateTotalSalaryExpenditure(IN dept_id INT)
    SELECT SUM(salary) AS total_salary_expenditure
    FROM employees
    WHERE department_id = dept_id;
CREATE PROCEDURE GenerateEmployeeReport()
    SELECT e.emp_id, e.first_name, e.last_name, d.department_name, e.salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id;
CREATE PROCEDURE FindProjectWithHighestBudget()
    SELECT *
    FROM projects
    ORDER BY budget DESC
    LIMIT 1;
CREATE PROCEDURE CalculateAverageSalaryAcrossDepartments()
    SELECT AVG(salary) AS average_salary
    FROM employees;
CREATE PROCEDURE AssignNewManager(IN dept_id INT, IN new_manager_id INT)
    UPDATE departments
    SET manager_id = new_manager_id
    WHERE department_id = dept_id;
CREATE PROCEDURE CalculateRemainingProjectBudget(IN proj_id INT)
    SELECT budget - SUM(expense) AS remaining_budget
    FROM projects
    JOIN project_expenses ON projects.project_id = project_expenses.project_id
    WHERE projects.project_id = proj_id;
CREATE PROCEDURE GenerateEmployeeJoinReport(IN join_year INT)
    SELECT *
    FROM employees
    WHERE YEAR(join_date) = join_year;
CREATE PROCEDURE UpdateProjectEndDate(IN proj_id INT, IN duration INT)
    UPDATE projects
    SET end_date = DATE_ADD(start_date, INTERVAL duration DAY)
    WHERE project_id = proj_id;
CREATE PROCEDURE CalculateTotalEmployeesInEachDepartment()
    SELECT d.department_name, COUNT(e.emp_id) AS total_employees
    FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_name;




















    
