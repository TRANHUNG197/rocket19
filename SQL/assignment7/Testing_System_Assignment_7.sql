use testing_system_1;

/*Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
trước 1 năm trước*/

DROP TRIGGER IF EXISTS not_insert_createdate_before_1y;
DELIMITER $$
	CREATE TRIGGER not_insert_createdate_before_1y
    BEFORE INSERT ON `group`
    FOR EACH ROW
    BEGIN
		IF (year(now()) - year(NEW.CreateDate) > 1) THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'createDate khong dung';
        END IF;
    END $$
DELIMITER ;


INSERT INTO `testing_system_1`.`group` (`GroupID`, `GroupName`, `CreatorID`, `CreateDate`) VALUES ('15', 'Nhom 11', '3', '2017-05-05');


/*Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
"Sale" cannot add more user"*/

DROP TRIGGER IF EXISTS not_insert_user_in_PhongSale;
DELIMITER $$
	CREATE TRIGGER not_insert_user_in_PhongSale
    BEFORE INSERT ON `account`
    FOR EACH ROW
    BEGIN
		declare N_departmentid int;
        
        select d.departmentid into N_departmentid 
        from department d
        where d.departmentname = "Phong sale";
		IF (new.departmentid = N_departmentid) THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Department "Phong sale" cannot add more user';
        END IF;
    END $$
DELIMITER ;

INSERT INTO `testing_system_1`.`account` (`AccountID`, `Email`, `Username`, `FullName`, `DepartmentID`, `PositionID`, `CreateDate`) VALUES ('14', 'gahasd@ghs.com', 'thuthuy123', 'bui thu thuy', '5', '3', '2014-05-16');

/*Question 3: Cấu hình 1 group có nhiều nhất là 5 user*/

DROP TRIGGER IF EXISTS group_max_5_user;
DELIMITER $$
	CREATE TRIGGER group_max_5_user
    BEFORE INSERT ON `groupaccount`
    FOR EACH ROW
    BEGIN
		declare N_countGroupid int;
        select count(ga.groupid) into  N_countGroupid
        from groupaccount ga
        where ga.groupid = new.groupid;
        
		IF (N_countgroupid > 5) THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'max so luong group';
        END IF;
    END $$
DELIMITER ;


INSERT INTO `groupaccount` (`GroupID`, `AccountID`, `JoinDate`) 
VALUES (1, 1, '2020-05-11 00:00:00');

/*Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question*/

DROP TRIGGER IF EXISTS exam_max_10_question;
DELIMITER $$
	CREATE TRIGGER exam_max_10_question
    BEFORE INSERT ON `examquestion`
    FOR EACH ROW
    BEGIN
		declare N_examid int;
        select count(eq.examid) into N_examid
        from examquestion eq
        where eq.examid = new.examid;
        
		IF (N_examid > 10) THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'max question in the exam';
        END IF;
    END $$
DELIMITER ;

INSERT INTO `testing_system_1`.`examquestion` (`ExamID`, `QuestionID`) VALUES ('18', '1');

/*Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
tin liên quan tới user đó*/


DROP TRIGGER IF EXISTS delete_account;
DELIMITER $$
	CREATE TRIGGER delete_account
    BEFORE DELETE ON `account`
    FOR EACH ROW
    BEGIN
		declare N_email varchar(50) default "admin@gmail.com";
        
		IF(old.email = N_email) THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'this is admin, can not delete it';
        END IF;
    END $$
DELIMITER ;

DELETE FROM `account` WHERE Email = 'admin@gmail.com';

/*Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
vào departmentID thì sẽ được phân vào phòng ban "waiting Department"*/

DROP TRIGGER IF EXISTS set_depID_waiting;
DELIMITER $$
	CREATE TRIGGER set_depID_waiting
    BEFORE INSERT ON `account`
    FOR EACH ROW
    BEGIN
		declare N_DepID_waiting varchar(50);
        
        select d.departmentid into N_DepID_waiting 
        from department d
        where d.departmentname = "waiting Department";
        
		IF (new.departmentid is null) THEN
            SET new.departmentid = N_DepID_waiting;
        END IF;
    END $$
DELIMITER ;

INSERT INTO `testing_system_1`.`account` (`AccountID`, `Email`, `Username`, `FullName`, `PositionID`) VALUES ('15', 'sfja@adhf.com', 'ihasjb', 'ji asg dja', '2');

/*Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
question, trong đó có tối đa 2 đáp án đúng.*/

DROP TRIGGER IF EXISTS set_Max_anwser_1question;
DELIMITER $$
	CREATE TRIGGER set_Max_anwser_1question
    BEFORE INSERT ON answer
    FOR EACH ROW
    BEGIN
		declare SL_Answer int;
        declare SL_Ans_correct int;
        
        select count(a.questionid) into SL_Answer
        from answer a
        where a.questionid = new.questionid;
        
        
        select count(1) into SL_Ans_correct 
        from answer a
        where a.questionid = new.questionid and a.isCorrect = new.isCorrect;
        
		IF (SL_Answer > 4 or SL_Ans_correct > 2) THEN
            SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'can not insert data anymore';
        END IF;
    END $$
DELIMITER ;

INSERT INTO answer (`AnswerID`, `Content`, `QuestionID`, `isCorrect`) VALUES ('33', 'abcxyz', 1, 1);


/*Question 8: Viết trigger sửa lại dữ liệu cho đúng:
Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database*/


DROP TRIGGER IF EXISTS set_gender;
DELIMITER $$
	CREATE TRIGGER set_gender
    BEFORE UPDATE ON `account`
    FOR EACH ROW
    BEGIN
		IF new.gender = 'nam' THEN
			set new.gender = 'M';
            
		elseif new.gender = 'nu' THEN
            set new.gender = 'F';
            
		elseif new.gender = 'chua xac dinh' THEN
            set new.gender = 'U';
        END IF;
    END $$
DELIMITER ;

UPDATE `testing_system_1`.`account` SET `gender` = 'nu' WHERE (`AccountID` = '1');
UPDATE `testing_system_1`.`account` SET `gender` = 'nam' WHERE (`AccountID` = '2');
UPDATE `testing_system_1`.`account` SET `gender` = 'chua xac dinh' WHERE (`AccountID` = '3');

/*Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày*/

DROP TRIGGER IF EXISTS delete_exam;
DELIMITER $$
	CREATE TRIGGER delete_exam
    BEFORE DELETE ON exam
    FOR EACH ROW
    BEGIN
		declare N_createdate datetime default date_sub(now(), interval 2 day);
        
		IF(old.createdate > N_createdate) THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'can not delete it';
        END IF;
    END $$
DELIMITER ;

begin work;
delete from exam where examid = 11;
rollback;

/*Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
question khi question đó chưa nằm trong exam nào*/

DROP TRIGGER IF EXISTS delete_question;
DELIMITER $$
	CREATE TRIGGER delete_question
    BEFORE DELETE ON question
    FOR EACH ROW
    BEGIN
		declare N_createdate datetime default date_sub(now(), interval 2 day);
        
		IF(old.createdate > N_createdate) THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'can not delete it';
        END IF;
    END $$
DELIMITER ;



/* Question 12: Lấy ra thông tin exam trong đó:
Duration <= 30 thì sẽ đổi thành giá trị "Short time"
30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
Duration > 60 thì sẽ đổi thành giá trị "Long time" */

select ExamID, `Code`, Title, Duration, 
	case 
		when Duration <= 30 then "Short time"
		when Duration <= 60 then "Medium time"
		when Duration > 60 then "Long time"
    end as Duration
from exam;

/*Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
là the_number_user_amount và mang giá trị được quy định như sau:
		Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
		Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
		Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher */
        
select GroupID, count(AccountID) as SL, 
	case
		when count(AccountID) <= 5 then 'few'
		when count(AccountID) <= 20 then 'normal'
		when count(AccountID) > 20 then 'higher'
    end as the_number_user_amount
from groupaccount 
group by GroupID
order by GroupID;       

/*Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
không có user thì sẽ thay đổi giá trị 0 thành "Không có User"*/

select departmentid, 
	case
		when count(a.accountid) = 0 then 'Không có User'
        when count(a.accountid) != 0 then count(a.accountid)
    end as SL
from department d
left join `account` a using(departmentid)
group by departmentid;
