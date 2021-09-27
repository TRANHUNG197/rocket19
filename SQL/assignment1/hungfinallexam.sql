/*Requirement 1:
Ta có 1 database để quản lý điểm của học sinh như dưới (trường có dấu gạch chân là
PrimaryKey)
 Student(ID,Name,Age,Gender)
 Subject(ID, Name)
 StudentSubject(StudentID,SubjectID,Mark,Date)*/


/*1. Tạo table với các ràng buộc và kiểu dữ liệu
Thêm ít nhất 3 bản ghi vào table*/


DROP database if exists exam_1;
create database if not exists exam_1;
use exam_1;

CREATE TABLE Student 
(
    ID 		TINYINT AUTO_INCREMENT PRIMARY KEY,
    `Name` 	VARCHAR(50),
    Age 	TINYINT,
    Gender	BIT
);

CREATE TABLE `Subject` 
(
    ID 		TINYINT AUTO_INCREMENT PRIMARY KEY,
    `Name` 	VARCHAR(50)
);

CREATE TABLE StudentSubject 
(
    StudentID 	TINYINT AUTO_INCREMENT,
    SubjectID 	TINYINT,
    Mark		TINYINT,
    `Date`		datetime, 
    primary key (StudentID, SubjectID)
);



INSERT INTO `student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('1', 'Nguyen Van A', 14, 0);
INSERT INTO `student` (`ID`, `Name`, `Age`, `Gender`) VALUES ('2', 'Nguyen Van B', 15, 1);
INSERT INTO `student` (`ID`, `Name`, `Age`) VALUES ('3', 'Nguyen Van C', 18);


INSERT INTO `exam_1`.`subject` (`ID`, `Name`) VALUES ('1', 'Toan');
INSERT INTO `exam_1`.`subject` (`ID`, `Name`) VALUES ('2', 'IT');
INSERT INTO `exam_1`.`subject` (`ID`, `Name`) VALUES ('3', 'TA');

INSERT INTO `studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('1', '2', '90', '2021-05-05');
INSERT INTO `studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('2', '1', '40', '2021-05-06');
INSERT INTO `studentsubject` (`StudentID`, `SubjectID`, `Mark`, `Date`) VALUES ('3', '3', '60', '2021-05-20');


/*2. Viết lệnh để
a) Lấy tất cả các môn học không có bất kì điểm nào
b) Lấy danh sách các môn học có ít nhất 2 điểm*/

/*a) Lấy tất cả các môn học không có bất kì điểm nào*/

select s.`name`
from studentsubject ss
join `subject` s on ss.SubjectID = s.ID
where ss.mark is null;

/*b) Lấy danh sách các môn học có ít nhất 2 điểm*/

select s.`name`, count(ss.SubjectID) as SL
from studentsubject ss
join `subject` s on ss.SubjectID = s.ID 
group by SubjectID and Mark
having Sl > 1;


-- kkk

with CTE_mon_hoc as
(
	select sub.ID, sub.`name`, count(sub.ID) as SL
    from studentsubject ss
    join `subject` sub on ss.subjectid = sub.id
    group by sub.ID
)

select `name`, SL from CTE_mon_hoc where SL >= 2;
 

/*3. Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm:
Student ID,Subject ID, Student Name, Student Age, Student Gender,
Subject Name, Mark, Date
(Với cột Gender show 'Male' để thay thế cho 0, 'Female' thay thế cho 1 và
'Unknow' thay thế cho null)*/



create or replace view V_StudentInfo as
	select ss.StudentID, s.ID, hs.`name` as Student_Name, hs.age, s.`name`, ss.mark, ss.`date`, 
		case
			when hs.gender = 0 then 'Male'
			when hs.gender = 1 then 'Female'
            else 'Unknow'
        end as gender
    
    from student hs
    left join `studentsubject` ss on hs.ID = ss.StudentID
    join `subject` s on ss.SubjectID = s.ID;

    
    
/*4. Không sử dụng On Update Cascade & On Delete Cascade
a) Tạo trigger cho table Subject có tên là SubjectUpdateID:
Khi thay đổi data của cột ID của table Subject, thì giá trị tương
ứng với cột SubjectID của table StudentSubject cũng thay đổi
theo
b) Tạo trigger cho table Student có tên là StudentDeleteID:
Khi xóa data của cột ID của table Student, thì giá trị tương ứng với
cột SubjectID của table StudentSubject cũng bị xóa theo*/


/*a) Tạo trigger cho table Subject có tên là SubjectUpdateID:
Khi thay đổi data của cột ID của table Subject, thì giá trị tương
ứng với cột SubjectID của table StudentSubject cũng thay đổi
theo*/


DROP TRIGGER IF EXISTS SubjectUpdateID;
DELIMITER $$
	CREATE TRIGGER SubjectUpdateID
    BEFORE update ON `Subject`
    FOR EACH ROW
    BEGIN
		UPDATE `studentsubject` SET `SubjectID` =  new.id where `SubjectID` = old.ID;
    END $$
DELIMITER ;

select * FROm subject;
select * FROm studentsubject;
begin work;
	UPDATE `subject` SET `ID` =  30 where `ID` = 3;
rollback;

/*b) Tạo trigger cho table Student có tên là StudentDeleteID:
Khi xóa data của cột ID của table Student, 
thì giá trị tương ứng với cột SubjectID của table StudentSubject cũng bị xóa theo*/

DROP TRIGGER IF EXISTS SubjectUpdateID;
DELIMITER $$
	CREATE TRIGGER SubjectUpdateID
    BEFORE delete ON `student`
    FOR EACH ROW
    BEGIN
		delete from studentsubject where StudentID = old.id;
    END $$
DELIMITER ;

begin work;
delete from `student` where `ID` =  3;
rollback;

/*5. Viết 1 store procedure (có 1 parameters: student name) sẽ xóa tất cả các
thông tin liên quan tới học sinh có cùng tên như parameter
Trong trường hợp nhập vào student name = "*" thì procedure sẽ xóa tất cả
các học sinh*/

DROP procedure IF EXISTS delete_student;
delimiter $$
	CREATE PROCEDURE delete_student(in input_student_name varchar(50))
    BEGIN
        if (input_student_name != '*') then 
			delete from student where `name` = input_student_name;
		else 
			delete from student;
        end if;
    END$$
delimiter ;


begin work;
call exam_1.delete_student('Nguyen Van C');
rollback;