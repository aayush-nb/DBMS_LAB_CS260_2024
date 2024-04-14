SELECT first_name, last_name FROM students;
SELECT first_name, last_name FROM students;
SELECT first_name, last_name, email FROM instructors;
SELECT courses.course_name, enrollments.grade 
FROM enrollments 
JOIN courses ON enrollments.course_id = courses.course_id;
SELECT first_name, last_name, city FROM students;
SELECT courses.course_name, CONCAT(instructors.first_name, ' ', instructors.last_name) AS instructor_name 
FROM courses 
JOIN instructors ON courses.instructor_id = instructors.instructor_id;
SELECT first_name, last_name, age FROM students;
SELECT courses.course_name, enrollments.enrollment_date 
FROM enrollments 
JOIN courses ON enrollments.course_id = courses.course_id;
SELECT first_name, last_name, email FROM instructors;
SELECT course_name, credit_hours FROM courses;
SELECT instructors.first_name, instructors.last_name, instructors.email
FROM instructors
JOIN courses ON instructors.instructor_id = courses.instructor_id
WHERE courses.course_name = 'Mathematics';
SELECT courses.course_name, enrollments.grade 
FROM enrollments 
JOIN courses ON enrollments.course_id = courses.course_id 
WHERE enrollments.grade = 'A';
SELECT students.first_name, students.last_name, students.state
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.course_id
WHERE courses.course_name = 'Computer Science';
SELECT courses.course_name, enrollments.enrollment_date 
FROM enrollments 
JOIN courses ON enrollments.course_id = courses.course_id 
WHERE enrollments.grade = 'B+';
SELECT instructors.first_name, instructors.last_name, instructors.email
FROM instructors
JOIN courses ON instructors.instructor_id = courses.instructor_id
WHERE courses.credit_hours > 3;

