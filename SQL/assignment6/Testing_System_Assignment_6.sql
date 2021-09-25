use testing_system_1;

/*Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
account thuộc phòng ban đó*/

delimiter $$
	CREATE PROCEDURE printAccByDpName(IN uName VARCHAR(50))
    BEGIN
		select a.*
        from `account` a
        join department d on a.departmentid = d.departmentid
        ;
    END$$


delimiter ;


/*Question 2: Tạo store để in ra số lượng account trong mỗi group*/

DROP PROCEDURE IF EXISTS SL_Account_In_Group;

delimiter $$
	CREATE PROCEDURE SL_Account_In_Group(in group_name varchar(50))
    BEGIN 
		select g.groupname, count(ga.groupid) as SL
        from groupaccount ga
        join `group` g using(groupid)
        where g.groupname = group_name;
	
    END$$
delimiter ;

call SL_Account_In_Group('nhom 2');



/*Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
trong tháng hiện tại*/

DROP PROCEDURE IF EXISTS SL_Typequestion_In_Month;

delimiter $$
	CREATE PROCEDURE SL_Typequestion_In_Month()
    BEGIN 
		select tq.typename, count(q.typeid) as SL
        from question q
        join typequestion tq using(typeid)
		where month(q.createdate) = month(now())
        group by q.typeid;
	
    END$$
delimiter ;

call SL_Typequestion_In_Month();


/*Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất*/
-- cach 1:
DROP PROCEDURE IF EXISTS NCHN;

delimiter $$
	CREATE PROCEDURE NCHN(out idq int)
    BEGIN
		select t.typeid into idq
        from question q
        join TypeQuestion t  ON	q.typeid = t.typeid
        group by q.typeid
        having count(q.typeid) = 
			(select max(SL) from (select count(q.typeid) as SL from question q group by q.typeid) as hj);
        
    END$$
delimiter ;


set @idq = 0;
call testing_system_1.NCHN(@idq);
select @idq;

-- cach 2:

CREATE OR REPLACE VIEW v_type_questions AS(
			SELECT typeID, Count(*) AS total FROM question q JOIN TypeQuestion tq USING(TypeID) GROUP BY TypeID
		);
SELECT * FROM v_questions;

DELIMITER $$
CREATE PROCEDURE pr_id_maxCQ(OUT IDQ INT)
BEGIN
		
	   SELECT `TypeID` INTO IDQ
       FROM	v_type_questions WHERE total = (SELECT MAX(total) FROM v_type_questions);

END $$
DELIMITER ;

CALL pr_id_maxCQ(@FF);
SELECT @FF;

-- cach 3:

CREATE OR REPLACE VIEW v_type_questions AS(
			SELECT typeID, Count(*) AS total FROM question q JOIN TypeQuestion tq USING(TypeID) GROUP BY TypeID
		);
DELIMITER $$

-- sql error 1418
-- SET GLOBAL log_bin_trust_function_creators = 1;
CREATE FUNCTION f_id_maxCQ() RETURNS INT
BEGIN
	   DECLARE IDQ INT;
	   SELECT `TypeID` INTO IDQ
       FROM	v_type_questions WHERE total = (SELECT MAX(total) FROM v_type_questions) ;
       RETURN IDQ;
END $$
DELIMITER ;

SELECT * FROM TypeQuestion WHERE TypeID = (SELECT f_id_maxCQ());


/*Question 5: Sử dụng store ở question 4 để tìm ra tên của type question*/

DROP PROCEDURE IF EXISTS NCHN;

delimiter $$
	CREATE PROCEDURE NCHN()
    BEGIN
		select t.typename, t.typeid 
        from question q
        join TypeQuestion t  ON	q.typeid = t.typeid
        group by q.typeid
        having count(q.typeid) = 
			(select max(SL) from (select count(q.typeid) as SL from question q group by q.typeid) as hj);
        
    END$$
delimiter ;


call NCHN();

/*Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
chuỗi của người dùng nhập vào*/

DROP PROCEDURE IF EXISTS Input_String_And_Output_GroupName;

delimiter $$
	CREATE PROCEDURE Input_String_And_Output_GroupName(in input_string varchar(50))
    BEGIN
		select g.groupname
        from `group` g
        where g.groupname like concat("%", input_string, "%");
        
    END$$
delimiter ;

call Input_String_And_Output_Group_and_accountInfor('vti1');


-- Hàm CONCAT dùng để nối hai hay nhiều biểu thức lại với nhau
-- Cú pháp của hàm CONCAT trong MySQL là: CONCAT( expression1, expression2, ... expression_n )

/*Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
trong store sẽ tự động gán:

username sẽ giống email nhưng bỏ phần @..mail đi
positionID: sẽ có default là developer
departmentID: sẽ được cho vào 1 phòng chờ

Sau đó in ra kết quả tạo thành công*/

DROP PROCEDURE IF EXISTS insertaccount;

delimiter $$
	CREATE PROCEDURE insertaccount(in input_fullname char(50), in input_email char(50))
    BEGIN
		declare N_username varchar(50) default substring_index(input_email, '@', 1);
        declare N_positionid int unsigned default 1;
        declare N_departmentid int unsigned default 12;
        
        insert into `account` (email, username, fullname, departmentid, positionid)
        value(input_email, N_username, input_fullname, N_departmentid, N_positionid);
		
        
    END$$
delimiter ;

call insertaccount('Cao Van Kien', 'caokien@gmail.com');

SELECT * FROM `account`;


/*Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất*/

DROP PROCEDURE IF EXISTS question_content_long;

delimiter $$
	CREATE PROCEDURE question_content_long(in input_choice varchar(50))
    BEGIN
		declare N_typeID int;
        
        select tq.typeid into N_typeid 
        from typequestion tq
        where tqtypename = input_choice;
        
        if input_choice = "Essay" then
			with CTE_long_content as
				(
					select length(q.content) as leng
                    from question q
                    where typeid = n_typeid
                )
			
            select * from question q
            where typeid = N_typeid and length(q.content) = (select max(leng) from CTE_long_content);
            
		elseif input_choice = "Multiple-Choice" then
			with CTE_long_content as
				(
					select length(q.content) as leng
                    from question q
                    where typeid = n_typeid
                )
			
            select * from question q
            where typeid = N_typeid and length(q.content) = (select max(leng) from CTE_long_content);
        end if;
		
    END$$
delimiter ;



/*Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID*/

DROP PROCEDURE IF EXISTS Delete_exam;

delimiter $$
	CREATE PROCEDURE Delete_exam(in input_examid int)
    BEGIN
		delete from exam where examid = input_examid;
        delete from examquestion where examid = input_examid;
		
    END$$
delimiter ;

call Delete_exam("10");



/*Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
dụng store ở câu 9 để xóa)
Sau đó in số lượng record đã remove từ các table liên quan trong khi
removing*/


DROP PROCEDURE IF EXISTS Delete_before_3y;

delimiter $$
	CREATE PROCEDURE Delete_before_3y()
    BEGIN
		declare i int default 1;
        declare countex int;
        
        drop table if exists tbTem;
        
        create table tbTem
        (
			id int primary key auto_increment,
            idExam int 
        );
        
		select count(examid) into countex 
        from exam
        where (year(now()) - year(createdate)) > 2;
        
        insert into tbtemp(idexam)
			(
            select count(examid) into countex 
			from exam
			where (year(now()) - year(createdate)) > 2
            );
            
		while( i <= countex) do
			delete from exam where examid = (select idexam from tbtemp where id = i);
            delete from examquestion where examid = (select idexam from tbtemp where id = i);
			set i = i + 1;
            
        end while;
        
        select countex as `So Luong Da Xoa`;
        
    END$$
delimiter ;


call Delete_before_3y;
SELECT * FROM exam;


/*Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm
nay*/

DROP PROCEDURE IF EXISTS SL_question_in_month;

delimiter $$
	CREATE PROCEDURE SL_question_in_month()
    BEGIN
		with CTE_12month as(
			select 1 as `month`
            union
            select 2 as `month`
            union
            select 3 as `month`
            union
            select 4 as `month`
            union
            select 5 as `month`
            union
            select 6 as `month`
            union
            select 7 as `month`
            union
            select 8 as `month`
            union
            select 9 as `month`
            union
            select 10 as `month`
            union
            select 11 as `month`
            union
            select 12 as `month`
        )
		
        select m.`month`, count(month(createdate)) as SL
        from CTE_12month m
        left join (select * from question q1 where year(q1.createdate) = year(now())) as q
        on m.`month` = month(q.createdate)
        group by m.`month`;
        
    END$$
delimiter ;



call SL_question_in_month;







/*Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6
tháng gần đây nhất
(Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong
tháng")*/

delimiter $$
	CREATE PROCEDURE question_in_6month()
    BEGIN
		with cte_6month as
        (
			SELECT month(now()) as m , year(now()) as y
            union
			SELECT month(date_sub(now(), interval 1 month)), year(date_sub(now(), interval 1 month)) as y
            union
			SELECT month(date_sub(now(), interval 2 month)), year(date_sub(now(), interval 2 month)) as y
            union
			SELECT month(date_sub(now(), interval 3 month)), year(date_sub(now(), interval 3 month)) as y
            union
			SELECT month(date_sub(now(), interval 4 month)), year(date_sub(now(), interval 4 month)) as y
            union
			SELECT month(date_sub(now(), interval 5 month)), year(date_sub(now(), interval 5 month)) as y
        )
        select m, y, if (count(questionid) = 0, 'khong co cau nao', count(questionid)) as total
        from cte_6month
		left join question on m = month(createdate) and y = year(createdate)
        group by m, y;
        
    END$$
delimiter ;

	