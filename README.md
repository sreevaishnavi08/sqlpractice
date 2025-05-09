# 🎓 Advanced SQL Portfolio – Student Management System

This project showcases advanced SQL capabilities through a simulated **Student Management System**. It demonstrates various essential database concepts, ideal for portfolio building or interview preparation.

---

## 🗄️ Database: `student_management`

### 🔧 Features Implemented

1. **Database & Tables Creation**  
   - Students  
   - Courses  
   - Enrollments (with foreign key constraints)

2. **Data Insertion**  
   - Sample data for realistic queries and operations

3. **Subquery**  
   - Get students enrolled in more than one course

4. **Views**  
   - `student_grades`: A view combining student name, course name, and grade

5. **Stored Procedure**  
   - `GetStudentGrades`: Returns courses and grades for a given student ID

6. **Trigger**  
   - Prevents direct update of grades to `'F'` for any enrollment

7. **Window Functions**  
   - Ranks students within each course by grade

8. **LEFT JOIN Usage**  
   - Finds students who haven’t enrolled in any course

9. **HAVING Clause**  
   - Filters courses with more than two enrollments

10. **Indexing**  
    - Creates an index on student names for faster lookups

---

## 🛠️ Technologies Used

- **SQL (MySQL dialect)**
- MySQL Workbench / CLI (or any compatible RDBMS)
  
---

## 📋 How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/advanced-sql-portfolio.git
