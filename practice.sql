-- Advanced SQL Portfolio by Sree Vaishnavi
-- Sample database: Student Management System

-- Use or create database
CREATE DATABASE IF NOT EXISTS student_management;
USE student_management;

-- Drop if exists (for reusability)
DROP TABLE IF EXISTS Enrollments, Courses, Students;

-- Tables
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    enrollment_year INT
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade VARCHAR(2),
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert data
INSERT INTO Students VALUES
(1, 'Alice', 'CSE', 2021),
(2, 'Bob', 'IT', 2020),
(3, 'Charlie', 'ECE', 2021),
(4, 'David', 'CSE', 2022);

INSERT INTO Courses VALUES
(101, 'SQL', 3),
(102, 'DSA', 4),
(103, 'Networks', 3);

INSERT INTO Enrollments (student_id, course_id, grade, enrollment_date) VALUES
(1, 101, 'A', '2022-01-10'),
(1, 102, 'B', '2022-02-12'),
(2, 101, 'A', '2021-01-11'),
(3, 103, 'C', '2021-03-15'),
(4, 101, 'B', '2023-01-09');

-- 1. Subquery: Students who enrolled in more than one course
SELECT name
FROM Students
WHERE student_id IN (
    SELECT student_id
    FROM Enrollments
    GROUP BY student_id
    HAVING COUNT(*) > 1
);

-- 2. View: Student-course-grade
CREATE OR REPLACE VIEW student_grades AS
SELECT s.name, c.course_name, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- 3. Stored Procedure: Get grades for a student
DELIMITER //
CREATE PROCEDURE GetStudentGrades(IN stu_id INT)
BEGIN
    SELECT s.name, c.course_name, e.grade
    FROM Students s
    JOIN Enrollments e ON s.student_id = e.student_id
    JOIN Courses c ON e.course_id = c.course_id
    WHERE s.student_id = stu_id;
END //
DELIMITER ;

-- Call Example:
-- CALL GetStudentGrades(1);

-- 4. Trigger: Prevent grade update to 'F'
DELIMITER //
CREATE TRIGGER prevent_failing_grade
BEFORE UPDATE ON Enrollments
FOR EACH ROW
BEGIN
    IF NEW.grade = 'F' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Failing grades not allowed directly.';
    END IF;
END //
DELIMITER ;

-- 5. Window Function: Rank students by course
SELECT
    s.name,
    c.course_name,
    e.grade,
    RANK() OVER (PARTITION BY c.course_id ORDER BY e.grade) AS rank_in_course
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- 6. LEFT JOIN: Students who haven’t enrolled
SELECT s.name, e.course_id
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- 7. HAVING Clause: Courses with > 2 enrollments
SELECT c.course_name, COUNT(*) AS total_enrollments
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY e.course_id
HAVING COUNT(*) > 2;

-- 8. Index for fast student lookup
CREATE INDEX idx_student_name ON Students(name);
