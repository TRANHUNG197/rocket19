DROP database if exists testing_system_1;
create database if not exists testing_system_1;
use testing_system_1;

CREATE TABLE Department 
(
    DepartmentID 	TINYINT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName 	VARCHAR(50)
);

CREATE TABLE Position
(
    PositionID 		TINYINT AUTO_INCREMENT PRIMARY KEY,
    PositionName 	ENUM('Dev1', 'Dev2', 'Test', 'Leader', 'Scrum Master', 'PM')
);

CREATE TABLE `Account`
(
    AccountID 		INT AUTO_INCREMENT PRIMARY KEY,
    Email 			VARCHAR(100),
    Username		VARCHAR(50),
    FullName		VARCHAR(50),
    gender			varchar(20),
    DepartmentID	TINYINT,
    PositionID	 	TINYINT,
    CreateDate		datetime
    
);

CREATE TABLE `Group`
(
    GroupID		INT AUTO_INCREMENT PRIMARY KEY,
	GroupName	VARCHAR(50),
    CreatorID	INT,
    CreateDate	datetime
);

CREATE TABLE GroupAccount
(
    GroupID		INT,
	AccountID	INT,
    JoinDate	datetime
);

CREATE TABLE TypeQuestion
(
    TypeID		TINYINT AUTO_INCREMENT PRIMARY KEY,
	TypeName	VARCHAR(50)
);

CREATE TABLE CategoryQuestion
(
    CategoryID			TINYINT AUTO_INCREMENT PRIMARY KEY,
	CategoryName		ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')
);

CREATE TABLE Question
(
    QuestionID			TINYINT AUTO_INCREMENT PRIMARY KEY,
	Content				VARCHAR(200),
    CategoryID			INT,
    TypeID				INT,
    CreatorID			INT,
    CreateDate			datetime
);

CREATE TABLE Answer
(
    AnswerID			TINYINT AUTO_INCREMENT PRIMARY KEY,
	Content				VARCHAR(200),
    QuestionID			INT,
    isCorrect			BIT
);

CREATE TABLE Exam
(
    ExamID				INT AUTO_INCREMENT PRIMARY KEY,
	`Code`				VARCHAR(30),
    Title				VARCHAR(50),
    CategoryID			INT,
    Duration			INT,
    CreatorID			INT,
    CreateDate			datetime
);

CREATE TABLE ExamQuestion
(
    ExamID				INT PRIMARY KEY,
	QuestionID			INT
);