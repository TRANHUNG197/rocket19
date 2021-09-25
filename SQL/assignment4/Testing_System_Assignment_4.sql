use Testing_System_1;

						-- Exercise 1: Join
/*Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ*/

(SELECT 
    username, d.departmentid, a.fullname
FROM
    `account` a
        JOIN
    department d ON a.DepartmentID = d.DepartmentID
ORDER BY DepartmentID)
union
(SELECT 
    username, departmentid, 'khong co phong ban'
FROM
    `account` where DepartmentID not in(select departmentid from department));
    
    -- cach 2
    
SELECT 
    username, d.departmentid, a.fullname
    
FROM
    `account` a
       left JOIN
    department d ON a.DepartmentID = d.DepartmentID
ORDER BY DepartmentID;

/*Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010*/

select * from `account` where CreateDate < '2010-12-20';

/*Question 3: Viết lệnh để lấy ra tất cả các developer*/

SELECT 
    p.positionid, positionname, a.username
FROM
    `account` a
        JOIN
    `position` p ON a.PositionID = p.PositionID
WHERE P.PositionName like 'Dev%'
ORDER BY PositionID;

/*Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên*/

SELECT 
    d.DepartmentName, COUNT(a.DepartmentID) AS count_NV
FROM
    `account` a
        JOIN
    department d ON a.DepartmentID = d.DepartmentID
GROUP BY a.DepartmentID
HAVING  count_NV > 3;


/*Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất*/
select QuestionID, q.Content  from question q join examquestion e on q.QuestionID = e.QuestionID group by e.QuestionID;

SELECT E.QuestionID, Q.Content FROM examquestion E
INNER JOIN question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQues) as maxcountQues FROM (
SELECT COUNT(E.QuestionID) AS countQues FROM examquestion E
GROUP BY E.QuestionID) AS countTable);


/*Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question*/

SELECT * FROM testing_system_1.categoryquestion; -- check table

SELECT * FROM testing_system_1.question;-- check table

SELECT 
    c.categoryid,
    c.categoryname,
    COUNT(q.categoryid) AS COUNT_Category
FROM
    categoryquestion c
        JOIN
    question q ON c.categoryid = q.categoryid
GROUP BY q.categoryid
ORDER BY categoryid;

/*Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam*/

SELECT * FROM testing_system_1.examquestion;

SELECT * FROM testing_system_1.question;

SELECT 
    eq.ExamID,
    eq.QuestionID,
    q.Content,
    COUNT(eq.QuestionID) AS COUNT_Q_ID
FROM
    examquestion eq
        RIGHT JOIN
    question q ON q.QuestionID = eq.QuestionID
GROUP BY q.QuestionID;

/*Question 8: Lấy ra Question có nhiều câu trả lời nhất*/

SELECT 
    a.AnswerID,
    q.QuestionID,
    a.content,
    COUNT(a.questionID) AS COUNT_Q_ID
FROM
    answer a
        RIGHT JOIN
    question q ON a.questionID = q.questionID
GROUP BY a.questionID
HAVING COUNT_Q_ID = (SELECT 
        MAX(count1)
    FROM
        (SELECT 
            COUNT(ans.questionid) AS count1
        FROM
            answer ans
        GROUP BY ans.questionid) AS fun);



/*Question 9: Thống kê số lượng account trong mỗi group*/

select g.groupID, g.groupname, count(ga.accountid) as COUNT_AC_ID
from groupaccount ga
join `group` g on ga.groupid = g.groupid
group by g.groupID
order by groupid;

/*Question 10: Tìm chức vụ có ít người nhất*/

SELECT 
    p.positionid,
    p.positionname,
    COUNT(a.positionid) AS COUNT_P_ID
FROM
    `account` a
        JOIN
    position p ON a.positionid = p.positionid
GROUP BY a.positionid
HAVING COUNT_P_ID = (SELECT 
        MIN(acp)
    FROM
        (SELECT 
            COUNT(ac.positionid) AS acp
        FROM
            `account` ac
        GROUP BY ac.positionid) AS fun);


/*Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM*/

SELECT 
    d.DepartmentID,
    p.PositionID,
    p.PositionName,
    d.DepartmentName,
    COUNT(p.PositionName) AS count_position
FROM
    `account` a
        JOIN
    department d ON a.DepartmentID = d.DepartmentID
        JOIN
    position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID , p.PositionID
order by DepartmentID, PositionID;


-- cach 2

SELECT 
    DepartmentID,
    PositionID,
    COUNT(a.DepartmentID) AS count_D_ID
FROM
    `account` a
        RIGHT JOIN
    (SELECT 
        DepartmentID, DepartmentName, PositionID, PositionName
    FROM
        department
    CROSS JOIN position
    ORDER BY DepartmentID , PositionID) AS t ON 
    (a.departmentID = t.DepartmentID and a.positionid = t.positionid)
GROUP BY t.DepartmentID , t.PositionID;


/*Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì,... */

select q.questionid, q.content, tq.typename, ac.fullname, a.content
from question q
join typequestion tq on q.typeID = tq.typeID
join categoryquestion cq on q.categoryID = cq.categoryID
join answer a on q.questionid = a.questionid
join `account` ac on q.creatorid = ac.accountid;


/*Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm*/

SELECT tq.TypeName, COUNT(q.TypeID) AS COUNT_TYPEID 
FROM question q
JOIN typequestion tq ON q.TypeID = tq.TypeID
GROUP BY q.TypeID;

/*Question 14:Lấy ra group không có account nào*/

select *
from `group` g
left join groupaccount ga on g.groupid = ga.groupid
where ga.groupid is null;


/*Question 16: Lấy ra question không có answer nào*/

select *
from question q
left join answer a on q.questionid = a.questionid
where a.answerid is null;


					-- Exercise 2: Union
/*Question 17:
a) Lấy các account thuộc nhóm thứ 1
b) Lấy các account thuộc nhóm thứ 2
c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau*/

/* a) Lấy các account thuộc nhóm thứ 1:*/

select *
from `account` a
join groupaccount ga on a.accountid = ga.accountid
where ga.groupid = 1;

/*Lấy các account thuộc nhóm thứ 2*/
select *
from `account` a
join groupaccount ga on a.accountid = ga.accountid
where ga.groupid = 2;

/*c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau*/
select *
from `account` a
join groupaccount ga on a.accountid = ga.accountid
where ga.groupid = 1
union
select *
from `account` a
join groupaccount ga on a.accountid = ga.accountid
where ga.groupid = 2;


/*Question 18:
a) Lấy các group có lớn hơn 5 thành viên
b) Lấy các group có nhỏ hơn 7 thành viên
c) Ghép 2 kết quả từ câu a) và câu b)*/

/*a) Lấy các group có lớn hơn 5 thành viên*/
		
        /* INSERT DATA bang GroupAccount */
INSERT INTO GroupAccount (GroupID, AccountID, JoinDate)
VALUES ('1', '5', '2011-06-01'),
	   ('1', '6', '2011-05-01');

select g.groupname, count(ga.groupid) as COUNT_G_ID
from groupaccount ga 
join `group` g on ga.groupid = g.groupid
group by ga.groupid
having COUNT_G_ID > 5;

/*b) Lấy các group có nhỏ hơn 7 thành viên*/

select g.groupname, count(ga.groupid) as COUNT_G_ID
from groupaccount ga 
join `group` g on ga.groupid = g.groupid
group by ga.groupid
having COUNT_G_ID < 7;

/*c) Ghép 2 kết quả từ câu a) và câu b)*/

SELECT 
    g.groupname, COUNT(ga.groupid) AS COUNT_G_ID
FROM
    groupaccount ga
        JOIN
    `group` g ON ga.groupid = g.groupid
GROUP BY ga.groupid
HAVING COUNT_G_ID > 5 
UNION SELECT 
    g.groupname, COUNT(ga.groupid) AS COUNT_G_ID
FROM
    groupaccount ga
        JOIN
    `group` g ON ga.groupid = g.groupid
GROUP BY ga.groupid
HAVING COUNT_G_ID < 7;
