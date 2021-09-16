use Testing_System_1;

/* INSERT DATA bang Department */
INSERT INTO Department (DepartmentName)
VALUES ('Phong Ky Thuat 1'),
       ('Phong Ky Thuat 2'),
       ('Phong Dev 1'),
       ('Phong Dev 2'),
       ('Phong Sale'),
       ('Phong Marketing'),
       ('Phong Giam Doc'),
       ('Phong Tai Chinh');
       
/* INSERT DATA bang Position */
INSERT INTO Position (PositionName)
VALUES ('Dev1'),
       ('Dev2'),
       ('Test'),
       ('PM'),
       ('Leader'),
       ('Scrum Master');
       
/* INSERT DATA bang Account */
INSERT INTO Account (Email, Username, Fullname, DepartmentID, PositionID, CreateDate)
VALUES ('vti_account1@vtiacademy.com', 'vti1', 'Nguyen Van Tinh', 1, 1, '2019-12-01'),
       ('vti_account2@vtiacademy.com', 'vti2', 'Trinh Hoai Linh', 1, 2, '2020-12-01'),
       ('vti_account3@vtiacademy.com', 'vti3', 'Nguyen Van Test', 1, 1, '2020-07-01'),
       ('vti_account4@vtiacademy.com', 'vti4', 'Tran Van Tinh', 1, 2, '2019-09-01'),
       ('vti_account5@vtiacademy.com', 'account5', 'Ho Van Tinh', 3, 2, '2021-07-01'),
       ('vti_account6@vtiacademy.com', 'account_vti6', 'Cao Thai Son', 3, 1, NOW()),
       ('vti_1@vtiacademy.com', 'account_vti', 'Tam Thất Tùu', 3, 3, '2020-11-01'),
       ('vti_7@vtiacademy.com', 'account_vti7', 'Tam Thất Tùng', 3, 3, '2020-10-01'),
       ('vti_8@vtiacademy.com', 'account_vti8', 'Nguyen Quynh Thu', 3, 4, '2019-04-01'),
       ('vti_9@vtiacademy.com', 'account_vti9', 'Tran Kim Tuyen', 2, 1, NOW()),
       ('vti_account10@vtiacademy.com', 'account_vti10', 'Nguyen Ba Dao', 1, 5, '2019-10-01'),
       ('vti_account11@vtiacademy.com', 'account_vti11', 'Nguyen Van Binh', 1, 3, '2020-12-01');
       
/* INSERT DATA bang Group */
INSERT INTO `Group` (GroupName, CreatorID, CreateDate)
VALUES ('Nhom 1', '3', '2021-04-03'),
       ('Nhom 2', '3', '2019-01-03'),
       ('Nhom 3', '2', '2020-04-03'),
       ('Nhom 4', '1', NOW()),
       ('Nhom 5', '3', '2021-06-03'),
       ('Nhom 6', '1', '2020-04-03'),
       ('Nhom 7', '5', '2021-04-03'),
       ('Nhom 8', '5', '2019-05-03'),
       ('Nhom 9', '3', '2019-01-03'),
       ('Nhom 10', '1', NOW());
       
/* INSERT DATA bang GroupAccount */
INSERT INTO GroupAccount (GroupID, AccountID, JoinDate)
VALUES ('1', '1', '2021-06-01'),
       ('1', '3', '2020-01-01'),
       ('1', '2', NOW()),
       ('1', '4', '2021-06-01'),
       ('2', '1', '2021-06-01'),
       ('2', '10', '2019-05-01'),
       ('5', '1', '2021-06-01'),
       ('5', '3', '2020-01-01'),
       ('5', '4', '2021-07-01'),
       ('3', '1', '2021-06-01'),
       ('9', '2', '2021-06-01'),
       ('10', '1', NOW()),
       ('11', '6', NOW()),
       ('12', '3', NOW()),
       ('13', '9', NOW());
       
/* INSERT DATA bang TypeQuestion */
INSERT INTO TypeQuestion (TypeName)
VALUES ('Trac nghiem'),
       ('Tu Luan');
       
/* INSERT DATA bang CategoryQuestion */
INSERT INTO CategoryQuestion (CategoryName)
VALUES ('Java'),
       ('SQL'),
       ('HTML'),
       ('CSS '),
       ('.NET'),
       ('Python'),
       ('Ruby'),
       ('JavaScript');
	
/* INSERT DATA bang Question */
INSERT INTO Question (Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES ('Câu hỏi SQL 1', 2, 2, 1, '2021-04-01'),
       ('Câu hỏi SQL 2', 2, 2, 2, '2020-01-01'),
       ('Câu hỏi SQL 3', 2, 2, 2, '2020-05-01'),
       ('Câu hỏi SQL 4', 2, 2, 2, '2020-07-09'),
       ('Câu hỏi JAVA 1', 1, 1, 10, '2021-07-01'),
       ('Câu hỏi JAVA 2', 1, 2, 5, '2021-07-01'),
       ('Câu hỏi JAVA 3', 1, 2, 5, '2021-06-25'),
       ('Câu hỏi JAVA 4', 1, 2, 5, '2021-06-08'),
       ('Câu hỏi HTML 1', 2, 3, 2, NOW()),
       ('Câu hỏi HTML 2', 1, 1, 3, NOW()),
       ('Câu hỏi Ruby', 2, 2, 2, NOW()),
       ('Câu hỏi python', 2, 2, 1, NOW()),
       ('Câu hỏi .net', 3, 3, 1, NOW());
       
/* INSERT DATA bang Answer */
INSERT INTO Answer (Content, QuestionID, isCorrect)
VALUES ('Câu trả lời 1 - question SQL 1', 1, 1),
       ('Câu trả lời 2 - question SQL 1', 1, 0),
       ('Câu trả lời 3 - question SQL 1', 1, 0),
       ('Câu trả lời 4 - question SQL 1', 1, 1),
       ('Câu trả lời 1 - question SQL 2', 2, 0),
       ('Câu trả lời 2 - question SQL 2', 2, 0),
       ('Câu trả lời 3 - question SQL 2', 2, 0),
       ('Câu trả lời 4 - question SQL 2', 2, 1),
       ('Câu trả lời 1 - question JAVA 1', 3, 0),
       ('Câu trả lời 2 - question JAVA 1', 3, 1),
       ('Câu trả lời 1 - question JAVA 2', 4, 0),
       ('Câu trả lời 2 - question JAVA 2', 4, 0),
       ('Câu trả lời 3 - question JAVA 2', 4, 0),
       ('Câu trả lời 4 - question JAVA 2', 4, 1),
       ('Câu trả lời 1 - question HTML 1', 5, 1),
       ('Câu trả lời 2 - question HTML 2', 5, 0);
       
/* INSERT DATA bang Exam */
INSERT INTO Exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES ('MS_01', 'De thi 01', 1, 90, 1, NOW()),
       ('MS_02', 'De thi 02', 1, 60, 5, NOW()),
       ('MS_03', 'De thi 03', 2, 60, 9, NOW()),
       ('MS_04', 'De thi 04', 2, 90, 1, NOW()),
       ('MS_05', 'De thi 05', 1, 60, 2, NOW()),
       ('MS_06', 'De thi 06', 2, 90, 2, NOW()),
       ('MS_07', 'De thi 07', 3, 90, 1, NOW()),
       ('MS_08', 'De thi 08', 1, 90, 2, NOW()),
       ('MS_09', 'De thi 09', 3, 90, 1, NOW()),
       ('MS_10', 'De thi 10', 1, 60, 1, NOW());
       
/* INSERT DATA bang Examquestion */
INSERT INTO ExamQuestion
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 1),
       (5, 2),
       (6, 2),
       (7, 2),
       (8, 2),
       (9, 3),
       (10, 3),
       (11, 4),
       (12, 4),
       (13, 4),
       (14, 4),
       (15, 5),
       (16, 5);
       

-- testing_system_assignment_2:
/*Question 1: Thêm ít nhất 10 record vào mỗi table*/

            /* INSERT DATA bang Exam */
INSERT INTO Exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES ('MS_11', 'De thi 11', 3, 30, 8, '2018-02-24'),
	   ('MS_12', 'De thi 12', 5, 15, 7, '2018-03-11'),
	   ('MS_13', 'De thi 13', 4, 15, 9, '2017-03-11'),
	   ('MS_14', 'De thi 14', 7, 25, 10, '2016-03-11'),
	   ('MS_15', 'De thi 15', 7, 60, 7, '2014-03-11'),
	   ('MS_16', 'De thi 16', 4, 75, 2, '2018-07-11'),
	   ('MS_17', 'De thi 17', 5, 50, 6, '2018-07-21'),
	   ('MS_18', 'De thi 18', 6, 90, 4, '2018-03-18'),
	   ('MS_19', 'De thi 19', 3, 40, 6, '2015-03-11'),
	   ('MS_20', 'De thi 20', 4, 80, 9, '2016-03-15');
       
          /* INSERT DATA bang GroupAccount */
INSERT INTO GroupAccount (GroupID, AccountID, JoinDate)
VALUES ('4', '9', '2020-04-12'),
	   ('13', '5', '2018-08-24');
       

/*Question 2: lấy ra tất cả các phòng ban*/
select * from department;

/* Question 3: lấy ra id của phòng ban "Sale" */
SELECT 
    departmentid, departmentname
FROM
    department
WHERE
    DepartmentName LIKE '%sale%';

/*Question 4: lấy ra thông tin account có full name dài nhất */
SELECT 
    *
FROM
    `account`
WHERE
    CHAR_LENGTH(fullname) = (SELECT 
            MAX(CHAR_LENGTH(fullname))
        FROM
            `account`);

/*Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id
= 3*/

SELECT 
    *
FROM
    `account`
WHERE
    CHAR_LENGTH(fullname) = (SELECT 
            MAX(CHAR_LENGTH(fullname))
        FROM
            `account`
        WHERE
            DepartmentID = 3)
        AND DepartmentID = 3;

/* Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019*/

select GroupName from `group` where createdate < '2019/12/20';

/*Question 7: Lấy ra ID của question có >= 4 câu trả lời*/

SELECT 
    a.QuestionID, COUNT(a.QuestionID) AS COUNT_Q_ID
FROM
    answer AS a
GROUP BY a.QuestionID
HAVING
    COUNT(a.QuestionID) >= 4;

/*Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày
20/12/2019*/

select * from exam; -- kiem tra 

SELECT 
    `code`
FROM
    exam
WHERE
    Duration >= 60
        AND CreateDate < '2019-12-20';

/*Question 9: Lấy ra 5 group được tạo gần đây nhất */

SELECT 
    *
FROM
    `group`
ORDER BY CreateDate DESC
LIMIT 5;

/* Question 10: Đếm số nhân viên thuộc department có id = 2*/

select accountid, departmentid from `account`; -- kiem tra

SELECT 
    COUNT(AccountID) AS COUNT_D_ID
FROM
    `account`
WHERE
    departmentid = 2;
    
/*Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"*/
-- SUBSTRING(string, start, length)
-- SUBSTRING_INDEX(column, start, lenghth)

select fullname from `account`;

select * from `account` where (substring_index(fullname, ' ', -1)) like'D%O';


/* Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019*/ 

select * from exam where createdate < '2019-12-20'; -- kiem tra

delete from exam where createdate < '2019-12-20';

/*Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"*/

select * from question;

begin work;
delete from question where (substring_index(content, ' ', 2)) like'câu hỏi';
rollback;

/*Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và
email thành loc.nguyenba@vti.com.vn*/

select fullname, email from `account` where accountid = 5; -- kiem tra

update `account` set fullname = 'Nguyễn Bá Lộc', email = 'loc.nguyenba@vti.com.vn' where accountid = 5;

/*Question 15: update account có id = 5 sẽ thuộc group có id = 4*/

select AccountID, GroupID from groupaccount where GroupID = 4; -- kiem tra

UPDATE groupaccount 
SET 
    AccountID = 5
WHERE
    GroupID = 4;

