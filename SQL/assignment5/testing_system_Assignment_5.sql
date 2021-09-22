use testing_system_1;      

/*Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale*/
-- cach 1:

create or replace view V_DSNV_sale as
	select a.accountid, a.email, a.username, a.fullname, d.departmentname
    from `account` a
    join department d on a.departmentid = d.departmentid
    where d.departmentname = 'sale';

-- cach 2:
with CTE_DSNV_sale as
	(select a.accountid, a.email, a.username, a.fullname, d.departmentname
    from `account` a
    join department d on a.departmentid = d.departmentid
    where d.departmentname = 'sale')
    
select * from CTE_DSNV_sale;

/*Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất*/

create or replace view V_MAX_ACCOUNTGROUP as
	select a.accountid, a.username, a.email, a.fullname, count(ga.accountid) as SL 
	from groupaccount ga 
	join `account` a on ga.accountid = a.accountid
	group by ga.accountid
	having count(ga.accountid) = 
		(
		select max(SL1) as MaxAccount
		from (select 
				count(ga1.accountid) as SL1 
				from groupaccount ga1 
				group by ga1.accountid) as NHOM
		);





/*Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
được coi là quá dài) và xóa nó đi*/

begin work;
create or replace view vQuestionLong as 
	(select questionid from question where char_length(content) > 30);


DELETE FROM vQuestionLong;
rollback;
select * from question;


/*Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất*/
-- cach 1:
create or replace view V_DSPB_MAX_NV as
	select d.departmentname, count(a.departmentid) as COUNT_D_ID
	from `account` a
	join department d on a.departmentid = d.departmentid
	group by a.departmentid
	having count(a.departmentid) = 	
		(select max(c) as c1 from (select count(b.departmentid) as c from `account` b group by b.departmentid) as e);
        
-- cach 2:
with CTE_DSPB_MAX_NV as
	(
    select d.departmentname, count(a.departmentid) as COUNT_D_ID
	from `account` a
	join department d on a.departmentid = d.departmentid
	group by a.departmentid
	having count(a.departmentid) = 	
		(select max(c) as c1 from (select count(b.departmentid) as c from `account` b group by b.departmentid) as e)
	)
select * from CTE_DSPB_MAX_NV;

/*Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo*/
-- cach 1:
create or replace view V_question_user_Ho_NG as
	select q.content, a.fullname 
    from question q
    join `account` a on a.accountid = q.creatorid
    where substring_index(a.fullname, ' ', 1) = 'nguyen';
    
-- cach 2:
with CTE_Q_H_NG as
	(select q.content, a.fullname 
    from question q
    join `account` a on a.accountid = q.creatorid
    where substring_index(a.fullname, ' ', 1) = 'nguyen')
select * from CTE_Q_H_NG;
    