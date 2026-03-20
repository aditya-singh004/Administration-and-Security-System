create database AdminANDSecurity;
use AdminANDSecurity;
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Designation VARCHAR(50),
    ContactNumber VARCHAR(15),
    Email VARCHAR(100),
    HireDate DATE,
    Status ENUM('Active', 'Inactive') DEFAULT 'Active',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
desc Employees;

CREATE TABLE Visitors (
    VisitorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    ContactNumber VARCHAR(15),
    Email VARCHAR(100),
    Organization VARCHAR(100),
    HostID INT,
    VisitPurpose VARCHAR(200),
    CheckInTime DATETIME,
    CheckOutTime DATETIME,
    FOREIGN KEY (HostID) REFERENCES Employees(EmployeeID) ON DELETE SET NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
desc Visitors;

CREATE TABLE Meals (
    MealID INT AUTO_INCREMENT PRIMARY KEY,
    MealType ENUM('Breakfast', 'Lunch', 'Dinner') NOT NULL,
    MealTime TIME NOT NULL,
    Price DECIMAL(10, 2) ,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
desc Meals;

CREATE TABLE EmployeeMeals (
    EmployeeMealID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    MealID INT NOT NULL,
    MealDate DATE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY (MealID) REFERENCES Meals(MealID) ON DELETE CASCADE
);
desc EmployeeMeals;

CREATE TABLE VisitorMeals (
    VisitorMealID INT AUTO_INCREMENT PRIMARY KEY,
    VisitorID INT NOT NULL,
    MealID INT NOT NULL,
    MealDate DATE NOT NULL,
    Quantity INT DEFAULT 1,
    FOREIGN KEY (VisitorID) REFERENCES Visitors(VisitorID) ON DELETE CASCADE,
    FOREIGN KEY (MealID) REFERENCES Meals(MealID) ON DELETE CASCADE
);
desc VisitorMeals;

CREATE TABLE MealSchedule (
    ScheduleID INT AUTO_INCREMENT PRIMARY KEY,
    DayOfWeek ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    MealID INT NOT NULL,
    SpecialMenu TEXT,
    FOREIGN KEY (MealID) REFERENCES Meals(MealID) ON DELETE CASCADE
);
desc MealSchedule;

CREATE TABLE Attendance (
    AttendanceID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    AttendanceDate DATE NOT NULL,
    CheckInTime DATETIME,
    CheckOutTime DATETIME,
    WorkHours DECIMAL(5, 2) AS (TIMESTAMPDIFF(MINUTE, CheckInTime, CheckOutTime) / 60.0),
    Status ENUM('Present', 'Absent', 'On Leave') DEFAULT 'Absent',
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);
desc Attendance;

CREATE TABLE LeaveRecords (
    LeaveID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    LeaveDate DATE NOT NULL,
    LeaveType ENUM('Sick Leave', 'Casual Leave', 'Paid Leave', 'Unpaid Leave'),
    Reason TEXT,
    ApprovalStatus ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);
desc LeaveRecords;


INSERT INTO Employees (FirstName, LastName, Department, Designation, ContactNumber, Email, HireDate, Status)
VALUES
('John', 'Doe', 'HR', 'Manager', '1234567890', 'john.doe@example.com', '2023-01-15', 'Active'),
('Jane', 'Smith', 'IT', 'Developer', '9876543210', 'jane.smith@example.com', '2022-11-20', 'Active'),
('Robert', 'Brown', 'Finance', 'Analyst', '4567891230', 'robert.brown@example.com', '2021-08-10', 'Inactive'),
('Alice', 'Johnson', 'Admin', 'Assistant', '7891234560', 'alice.johnson@example.com', '2024-02-01', 'Active'),
('Michael', 'Clark', 'HR', 'Recruiter', '3216549870', 'michael.clark@example.com', '2023-07-25', 'Active');

INSERT INTO Visitors (FirstName, LastName, ContactNumber, Email, Organization, HostID, VisitPurpose, CheckInTime, CheckOutTime)
VALUES
('Emily', 'Davis', '1237894560', 'emily.davis@company.com', 'ABC Corp', 1, 'Business Meeting', '2024-11-28 09:00:00', '2024-11-28 10:30:00'),
('David', 'Wilson', '4561237890', 'david.wilson@client.com', 'XYZ Ltd', 2, 'Project Discussion', '2024-11-28 14:00:00', NULL),
('Sophia', 'Taylor', '7894561230', 'sophia.taylor@partner.com', 'Partner Co', 3, 'Sales Pitch', '2024-11-29 11:00:00', '2024-11-29 12:00:00'),
('James', 'Anderson', '3219876540', 'james.anderson@guest.com', 'Freelancer', 4, 'Consultation', '2024-11-29 15:00:00', NULL),
('Olivia', 'Martinez', '6543219870', 'olivia.martinez@org.com', 'Non-Profit Org', 1, 'Workshop', '2024-11-27 10:00:00', '2024-11-27 12:30:00');

INSERT INTO Meals (MealType, MealTime, Price)
VALUES
('Breakfast', '08:30:00', 5.50),
('Lunch', '13:00:00', 10.00),
('Dinner', '19:30:00', 12.50),
('Lunch', '12:45:00', 8.75),
('Breakfast', '09:00:00', 6.00);

INSERT INTO EmployeeMeals (EmployeeID, MealID, MealDate)
VALUES
(1, 2, '2024-11-28'),
(2, 1, '2024-11-28'),
(3, 3, '2024-11-27'),
(1, 4, '2024-11-29'),
(4, 5, '2024-11-29');

INSERT INTO VisitorMeals (VisitorID, MealID, MealDate, Quantity)
VALUES
(1, 1, '2024-11-28', 1),
(2, 2, '2024-11-28', 2),
(3, 3, '2024-11-29', 1),
(4, 1, '2024-11-29', 3),
(5, 2, '2024-11-27', 2);

INSERT INTO MealSchedule (DayOfWeek, MealID, SpecialMenu)
VALUES
('Monday', 1, 'Vegan Options'),
('Tuesday', 2, 'Grilled Specials'),
('Wednesday', 3, 'Pasta Bar'),
('Thursday', 4, 'Soup & Salad'),
('Friday', 5, 'Burger Feast'),
('Saturday', 2, 'Weekend Brunch'),
('Sunday', 3, 'Chef’s Choice');

INSERT INTO Attendance (EmployeeID, AttendanceDate, CheckInTime, CheckOutTime, Status)
VALUES
(1, '2024-11-28', '2024-11-28 08:00:00', '2024-11-28 16:00:00', 'Present'),
(2, '2024-11-28', '2024-11-28 09:00:00', '2024-11-28 17:00:00', 'Present'),
(3, '2024-11-28', NULL, NULL, 'Absent'),
(4, '2024-11-27', '2024-11-27 08:30:00', '2024-11-27 15:30:00', 'Present'),
(5, '2024-11-29', '2024-11-29 10:00:00', '2024-11-29 18:00:00', 'Present');


INSERT INTO LeaveRecords (EmployeeID, LeaveDate, LeaveType, Reason, ApprovalStatus)
VALUES
(1, '2024-11-25', 'Sick Leave', 'Flu Symptoms', 'Approved'),
(2, '2024-11-26', 'Casual Leave', 'Family Emergency', 'Pending'),
(3, '2024-11-27', 'Paid Leave', 'Vacation', 'Approved'),
(4, '2024-11-28', 'Unpaid Leave', 'Personal Work', 'Rejected'),
(5, '2024-11-29', 'Sick Leave', 'Doctor Appointment', 'Pending');




SELECT * FROM Employees;
SELECT * FROM Employees WHERE Status = 'Active';
SELECT * FROM Employees WHERE Department = 'HR';
SELECT * FROM Employees WHERE HireDate > DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
UPDATE Employees SET Status = 'Inactive' WHERE EmployeeID = 5;
SELECT Department, COUNT(*) AS EmployeeCount FROM Employees GROUP BY Department;
SELECT * FROM Employees ORDER BY HireDate DESC LIMIT 1;
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employees;
DELETE FROM Employees WHERE EmployeeID = 10;
SELECT * FROM Employees WHERE FirstName LIKE '%John%';


SET SQL_SAFE_UPDATES = 0;
SELECT * FROM Visitors;
SELECT * FROM Visitors WHERE DATE(CheckInTime) = CURDATE();
SELECT * FROM Visitors WHERE HostID = 1;
SELECT CONCAT(FirstName, ' ', LastName) AS FullName, Organization FROM Visitors;
SELECT Organization, COUNT(*) AS VisitorCount FROM Visitors GROUP BY Organization;
UPDATE Visitors SET CheckOutTime = '2024-11-29 14:00:00' WHERE VisitorID = 3;
DELETE FROM Visitors WHERE DATE(CheckOutTime) = DATE_SUB(CURDATE(), INTERVAL 1 DAY) AND VisitorID IS NOT NULL;
SELECT *, TIMESTAMPDIFF(HOUR, CheckInTime, CheckOutTime) AS Duration FROM Visitors WHERE TIMESTAMPDIFF(HOUR, CheckInTime, CheckOutTime) > 2;
SELECT * FROM Visitors WHERE CheckOutTime IS NULL;
SELECT * FROM Visitors WHERE VisitPurpose LIKE '%Meeting%';


SELECT * FROM Meals;
SELECT * FROM Meals WHERE Price < 10.00;
SELECT MealType, COUNT(*) AS MealCount FROM Meals GROUP BY MealType;
SELECT * FROM Meals ORDER BY Price DESC LIMIT 1;
SELECT * FROM Meals WHERE MealTime > '18:00:00';
UPDATE Meals SET Price = 15.00 WHERE MealType = 'Lunch';
DELETE FROM Meals WHERE MealID = 4;
SELECT * FROM Meals WHERE MealTime < '12:00:00';
SELECT AVG(Price) AS AveragePrice FROM Meals;
SELECT DISTINCT MealType FROM Meals;


SELECT * FROM EmployeeMeals;
SELECT * FROM EmployeeMeals WHERE EmployeeID = 1;
SELECT EmployeeID, COUNT(*) AS MealCount FROM EmployeeMeals GROUP BY EmployeeID;
SELECT * FROM EmployeeMeals WHERE MealDate = '2024-11-28';
SELECT em.EmployeeID, m.MealType FROM EmployeeMeals em JOIN Meals m ON em.MealID = m.MealID WHERE em.EmployeeID = 1;
SELECT em.EmployeeID, SUM(m.Price) AS TotalCost FROM EmployeeMeals em JOIN Meals m ON em.MealID = m.MealID WHERE em.EmployeeID = 1;
DELETE FROM EmployeeMeals WHERE EmployeeMealID = 5;
SELECT EmployeeID, MealDate, COUNT(*) AS MealCount FROM EmployeeMeals GROUP BY EmployeeID, MealDate HAVING MealCount > 2;
UPDATE EmployeeMeals SET MealDate = '2024-11-29' WHERE EmployeeMealID = 3;
SELECT m.MealType, COUNT(*) AS Frequency FROM EmployeeMeals em JOIN Meals m ON em.MealID = m.MealID GROUP BY m.MealType ORDER BY Frequency DESC LIMIT 1;


SELECT * FROM MealSchedule;
SELECT * FROM MealSchedule WHERE DayOfWeek = 'Monday';
SELECT ms.DayOfWeek, m.MealType, m.MealTime FROM MealSchedule ms JOIN Meals m ON ms.MealID = m.MealID;
SELECT DayOfWeek, COUNT(*) AS MealCount FROM MealSchedule GROUP BY DayOfWeek;
UPDATE MealSchedule SET SpecialMenu = 'Vegetarian Special' WHERE DayOfWeek = 'Wednesday';
DELETE FROM MealSchedule WHERE ScheduleID = 2;
SELECT * FROM MealSchedule WHERE DayOfWeek IN ('Saturday', 'Sunday');
SELECT DayOfWeek FROM MealSchedule WHERE MealID = 1;
SELECT * FROM MealSchedule ORDER BY FIELD(DayOfWeek, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
SELECT DISTINCT SpecialMenu FROM MealSchedule;


SELECT * FROM Attendance;
SELECT * FROM Attendance WHERE EmployeeID = 1;
SELECT * FROM Attendance WHERE AttendanceDate = CURDATE();
SELECT * FROM Attendance WHERE AttendanceDate = '2024-11-28' AND Status = 'Present';
UPDATE Attendance SET CheckOutTime = '2024-11-29 17:30:00' WHERE AttendanceID = 3;
SELECT * FROM Attendance WHERE WorkHours > 8;
SELECT Status, COUNT(*) AS StatusCount FROM Attendance WHERE AttendanceDate = '2024-11-28' GROUP BY Status;
SELECT SUM(WorkHours) AS TotalWorkHours FROM Attendance WHERE EmployeeID = 1 AND MONTH(AttendanceDate) = 11 AND YEAR(AttendanceDate) = 2024;
DELETE FROM Attendance WHERE AttendanceID = 5;
SELECT * FROM Attendance WHERE CheckOutTime IS NULL AND AttendanceDate = CURDATE();


SELECT * FROM LeaveRecords;
SELECT * FROM LeaveRecords WHERE EmployeeID = 1;
SELECT * FROM LeaveRecords WHERE ApprovalStatus = 'Approved';
SELECT LeaveType, COUNT(*) AS LeaveCount FROM LeaveRecords GROUP BY LeaveType;
SELECT * FROM LeaveRecords WHERE MONTH(LeaveDate) = 11 AND YEAR(LeaveDate) = 2024;
UPDATE LeaveRecords SET ApprovalStatus = 'Approved' WHERE LeaveID = 3;
SELECT * FROM LeaveRecords WHERE Reason LIKE '%medical%';
SELECT COUNT(*) AS PendingLeaves FROM LeaveRecords WHERE EmployeeID = 1 AND ApprovalStatus = 'Pending';
DELETE FROM LeaveRecords WHERE LeaveID = 5;
SELECT EmployeeID FROM LeaveRecords WHERE LeaveDate = '2024-11-28';


