# Administration and Security Management System

A comprehensive database-driven system for managing employee administration, visitor management, attendance tracking, leave records, and meal services in an organization.

## 📋 Project Overview

This project implements a complete Administration and Security Management System using MySQL. It provides robust solutions for managing day-to-day administrative operations including employee records, visitor check-in/check-out, attendance monitoring, leave management, and meal scheduling services.

## 🏗️ Database Schema

The system consists of 8 interconnected tables:

### 1. Employees
Stores employee information within the organization.

| Column | Type | Description |
|--------|------|-------------|
| EmployeeID | INT (PK) | Unique identifier |
| FirstName | VARCHAR(50) | Employee's first name |
| LastName | VARCHAR(50) | Employee's last name |
| Department | VARCHAR(50) | Department name |
| Designation | VARCHAR(50) | Job title |
| ContactNumber | VARCHAR(15) | Phone number |
| Email | VARCHAR(100) | Email address |
| HireDate | DATE | Date of joining |
| Status | ENUM | Active/Inactive |
| CreatedAt | TIMESTAMP | Record creation time |

### 2. Visitors
Tracks all visitors entering the premises.

| Column | Type | Description |
|--------|------|-------------|
| VisitorID | INT (PK) | Unique identifier |
| FirstName | VARCHAR(50) | Visitor's first name |
| LastName | VARCHAR(50) | Visitor's last name |
| ContactNumber | VARCHAR(15) | Phone number |
| Email | VARCHAR(100) | Email address |
| Organization | VARCHAR(100) | Visiting organization |
| HostID | INT (FK) | Employee being visited |
| VisitPurpose | VARCHAR(200) | Reason for visit |
| CheckInTime | DATETIME | Entry time |
| CheckOutTime | DATETIME | Exit time |

### 3. Meals
Manages meal options available in the facility.

| Column | Type | Description |
|--------|------|-------------|
| MealID | INT (PK) | Unique identifier |
| MealType | ENUM | Breakfast/Lunch/Dinner |
| MealTime | TIME | Serving time |
| Price | DECIMAL(10,2) | Meal price |
| CreatedAt | TIMESTAMP | Record creation time |

### 4. EmployeeMeals
Tracks employee meal selections and history.

| Column | Type | Description |
|--------|------|-------------|
| EmployeeMealID | INT (PK) | Unique identifier |
| EmployeeID | INT (FK) | Employee reference |
| MealID | INT (FK) | Meal reference |
| MealDate | DATE | Date of meal |

### 5. VisitorMeals
Tracks visitor meal requirements during visits.

| Column | Type | Description |
|--------|------|-------------|
| VisitorMealID | INT (PK) | Unique identifier |
| VisitorID | INT (FK) | Visitor reference |
| MealID | INT (FK) | Meal reference |
| MealDate | DATE | Date of meal |
| Quantity | INT | Number of meals |

### 6. MealSchedule
Weekly meal planning and special menu management.

| Column | Type | Description |
|--------|------|-------------|
| ScheduleID | INT (PK) | Unique identifier |
| DayOfWeek | ENUM | Day of the week |
| MealID | INT (FK) | Meal reference |
| SpecialMenu | TEXT | Special menu details |

### 7. Attendance
Monitors employee attendance and work hours.

| Column | Type | Description |
|--------|------|-------------|
| AttendanceID | INT (PK) | Unique identifier |
| EmployeeID | INT (FK) | Employee reference |
| AttendanceDate | DATE | Date of attendance |
| CheckInTime | DATETIME | Arrival time |
| CheckOutTime | DATETIME | Departure time |
| WorkHours | DECIMAL | Calculated work hours |
| Status | ENUM | Present/Absent/On Leave |

### 8. LeaveRecords
Manages employee leave applications and approvals.

| Column | Type | Description |
|--------|------|-------------|
| LeaveID | INT (PK) | Unique identifier |
| EmployeeID | INT (FK) | Employee reference |
| LeaveDate | DATE | Date of leave |
| LeaveType | ENUM | Type of leave |
| Reason | TEXT | Leave reason |
| ApprovalStatus | ENUM | Pending/Approved/Rejected |

## 🔧 Features

### Employee Management
- Add, update, and delete employee records
- Track employee department and designation
- Monitor employment status (Active/Inactive)
- Search employees by name, department, or hire date

### Visitor Management
- Register visitors with complete details
- Track check-in and check-out times
- Link visitors to host employees
- Monitor active visitors on premises
- Track visit purposes and organizations

### Meal Management
- Multiple meal types (Breakfast, Lunch, Dinner)
- Flexible meal scheduling by day of week
- Special menu planning
- Employee meal booking and tracking
- Visitor meal allocation

### Attendance Tracking
- Daily attendance recording
- Automatic work hours calculation
- Present/Absent/On Leave status
- Monthly attendance reports

### Leave Management
- Multiple leave types (Sick, Casual, Paid, Unpaid)
- Leave approval workflow
- Pending/Approved/Rejected status tracking
- Leave history per employee

## 🚀 Getting Started

### Prerequisites
- MySQL 5.7 or higher
- MySQL Workbench (optional but recommended)

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/aditya-singh004/Administration-and-Security-System.git
   ```

2. **Open MySQL**
   ```bash
   mysql -u root -p
   ```

3. **Run the Script**
   ```sql
   SOURCE path/to/AandS.sql;
   ```
   
   Or simply execute the `AandS.sql` file in MySQL Workbench.

### Verify Installation

```sql
USE AdminANDSecurity;
SHOW TABLES;
SELECT * FROM Employees;
```

## 📊 Sample Queries

### Employee Queries
```sql
-- Get all active employees
SELECT * FROM Employees WHERE Status = 'Active';

-- Get employees by department
SELECT * FROM Employees WHERE Department = 'HR';

-- Count employees per department
SELECT Department, COUNT(*) AS EmployeeCount FROM Employees GROUP BY Department;
```

### Visitor Queries
```sql
-- Get today's visitors
SELECT * FROM Visitors WHERE DATE(CheckInTime) = CURDATE();

-- Get current visitors on premises
SELECT * FROM Visitors WHERE CheckOutTime IS NULL;

-- Get visitors by host
SELECT * FROM Visitors WHERE HostID = 1;
```

### Attendance Queries
```sql
-- Today's attendance
SELECT * FROM Attendance WHERE AttendanceDate = CURDATE();

-- Present employees on specific date
SELECT * FROM Attendance WHERE AttendanceDate = '2024-11-28' AND Status = 'Present';

-- Calculate work hours
SELECT SUM(WorkHours) AS TotalWorkHours FROM Attendance 
WHERE EmployeeID = 1 AND MONTH(AttendanceDate) = 11;
```

### Leave Queries
```sql
-- Pending leave requests
SELECT * FROM LeaveRecords WHERE ApprovalStatus = 'Pending';

-- Approved leaves by type
SELECT LeaveType, COUNT(*) AS LeaveCount FROM LeaveRecords 
GROUP BY LeaveType;
```

## 📁 Project Structure

```
Administration-and-Security-System/
├── README.md                 # This file
├── AandS.sql                # Complete database schema and queries
├── DB design.pdf            # Database design documentation
├── DB foundations Exam.pdf # Database foundations exam
├── PL SQL Exam.pdf          # PL/SQL exam content
└── SQL Exam.pdf             # SQL exam content
```

## 🔐 Security Features

- Foreign key constraints for data integrity
- Cascade delete for related records
- Enum constraints for standardized data
- Timestamp tracking for audit purposes
- Status-based access control through queries

## 👨‍💻 Author

**Aditya Singh**
- GitHub: [@aditya-singh004](https://github.com/aditya-singh004)

## 📝 License

This project is for educational purposes as part of the DBMS curriculum.

## 🙏 Acknowledgments

- Database Management System (DBMS) Course
- Administration and Security Systems Module

---

<p align="center">Made with ❤️ for efficient administration management</p>
