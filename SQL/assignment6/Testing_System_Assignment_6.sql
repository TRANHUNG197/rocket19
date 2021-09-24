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

