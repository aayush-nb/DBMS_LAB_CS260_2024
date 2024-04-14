CREATE TRIGGER increase_salary_trigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 60000 THEN
        SET NEW.salary = NEW.salary * 1.1;
    END IF;
END;
CREATE TRIGGER prevent_delete_department_trigger
BEFORE DELETE ON departments
FOR EACH ROW
BEGIN
    DECLARE employee_count INT;
    SELECT COUNT(*) INTO employee_count FROM employees WHERE department_id = OLD.department_id;
    IF employee_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete department with assigned employees';
    END IF;
END;
CREATE TRIGGER log_salary_update_trigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_audit (old_salary, new_salary, employee_name, date)
    VALUES (OLD.salary, NEW.salary, CONCAT(NEW.first_name, ' ', NEW.last_name), NOW());
END;
CREATE TRIGGER assign_department_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary <= 60000 THEN
        SET NEW.department_id = 3;
    END IF;
    -- Add more conditions for other salary ranges and departments as needed
END;
CREATE TRIGGER update_manager_salary_trigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    UPDATE employees AS e
    JOIN (SELECT department_id, MAX(salary) AS max_salary FROM employees GROUP BY department_id) AS m
    ON e.department_id = m.department_id
    SET e.salary = NEW.salary
    WHERE e.salary = m.max_salary;
END;
CREATE TRIGGER prevent_update_department_trigger
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    DECLARE project_count INT;
    SELECT COUNT(*) INTO project_count FROM works_on WHERE emp_id = NEW.emp_id;
    IF project_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update department_id of employee who worked on projects';
    END IF;
END;
CREATE TRIGGER update_average_salary_trigger
AFTER INSERT, UPDATE ON employees
FOR EACH ROW
BEGIN
    UPDATE departments AS d
    SET d.average_salary = (
        SELECT AVG(e.salary)
        FROM employees AS e
        WHERE e.department_id = d.department_id
    );
END;
CREATE TRIGGER delete_employee_records_trigger
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    DELETE FROM works_on WHERE emp_id = OLD.emp_id;
END;
CREATE TRIGGER prevent_insert_low_salary_employee_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE min_salary DECIMAL;
    SELECT MINIMUM_SALARY INTO min_salary FROM departments WHERE department_id = NEW.department_id;
    IF NEW.salary < min_salary THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee salary is less than department minimum salary';
    END IF;
END;
CREATE TRIGGER update_department_budget_trigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    UPDATE departments AS d
    SET d.total_budget = (
        SELECT SUM(e.salary)
        FROM employees AS e
        WHERE e.department_id = d.department_id
    );
END;
-- Assuming you have a stored procedure or function to send emails
CREATE TRIGGER notify_hr_new_hire_trigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    CALL send_email('hr@example.com', 'New employee hired', CONCAT('New employee: ', NEW.first_name, ' ', NEW.last_name));
END;
CREATE TRIGGER prevent_insert_department_without_location_trigger
BEFORE INSERT ON departments
FOR EACH ROW
BEGIN
    IF NEW.location IS NULL OR NEW.location = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Department location must be specified';
    END IF;
END;
CREATE TRIGGER update_department_name_trigger
AFTER UPDATE ON departments
FOR EACH ROW
BEGIN
    UPDATE employees AS e
    SET e.department_name = NEW.department_name
    WHERE e.department_id = NEW.department_id;
END;
CREATE TRIGGER log_employee_operations_trigger
AFTER INSERT, UPDATE, DELETE ON employees
FOR EACH ROW
BEGIN
    DECLARE operation_type VARCHAR(10);
    IF INSERTING THEN
        SET operation_type = 'INSERT';
    ELSEIF UPDATING THEN
        SET operation_type = 'UPDATE';
    ELSE
        SET operation_type = 'DELETE';
    END IF;
    
    INSERT INTO employee_audit (operation_type, emp_id, first_name, last_name, salary, department_id, date)
    VALUES (operation_type, OLD.emp_id, OLD.first_name, OLD.last_name, OLD.salary, OLD.department_id, NOW());
END;
-- Assuming you have a sequence named emp_id_sequence
CREATE TRIGGER generate_employee_id_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.emp_id = NEXT VALUE FOR emp_id_sequence;
END;






