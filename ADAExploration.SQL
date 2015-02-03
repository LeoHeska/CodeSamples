create table not_found_ad_emails
   (email varchar2(45))

select EMAIL_ADDRESS, USERNAME, FULLNAME, USER_ID
from mds_users
order by email_address

select max(lastconnect) from mds_users;

select * from mds_users where lastconnect > to_date('2003-apr-07', 'yyyy-mm-dd');

select * from mds_users where email_address = 'null@molex.com';
select * from mds_users where email_address = 'null';

select * from mds_users 
where email_address = ''
or email_address = 'null'
or email_address = 'null@molex.com';

select distinct email_address
from mds_users
order by email_address;

select count(*)
from mds_users
where email_address is null;

select m.email_address, m.login_count, m.lastconnect, m.active_flag,
m.username, m.fullname, m.phone_no, m.fax_no,
m.USER_GROUP_ID, m.PHONE_EXT, m.USER_ID,
m.VALID_LENGTH, m.LASTRENEW_DATE
from mds_users m, not_found_ad_emails a
where m.email_address = a.email
union
select m.email_address, m.login_count, m.lastconnect, m.active_flag,
m.username, m.fullname, m.phone_no, m.fax_no,
m.USER_GROUP_ID, m.PHONE_EXT, m.USER_ID,
m.VALID_LENGTH, m.LASTRENEW_DATE
from mds_users m
where m.email_address is null
or m.email_address = 'na'
or m.email_address = 'null'
or m.email_address = 'null@molex.com'
order by login_count, lastconnect

select m.email_address, m.login_count, m.lastconnect, m.active_flag,
m.username, m.fullname, m.phone_no, m.fax_no,
m.USER_GROUP_ID, m.PHONE_EXT, m.USER_ID,
m.VALID_LENGTH, m.LASTRENEW_DATE
from mds_users m, not_found_ad_emails a
where m.email_address = a.email
union
select m.email_address, m.login_count, m.lastconnect, m.active_flag,
m.username, m.fullname, m.phone_no, m.fax_no,
m.USER_GROUP_ID, m.PHONE_EXT, m.USER_ID,
m.VALID_LENGTH, m.LASTRENEW_DATE
from mds_users m
where m.email_address is null
or m.email_address = 'na'
or m.email_address = 'null'
or m.email_address = 'null@molex.com'
order by lastconnect

select * from mds_users
where email_address in
   (
   select email_address from mds_users
   having count(*) > 1
   group by email_address
   )
order by email_address

select * from mds_users
where lastconnect < to_date('2002-oct-12', 'yyyy-mm-dd')
or login_count = 0

-- Used the following query to generate list of 1300 expired mds_users
select 
   login_count, lastconnect,
   username, FullName,  phone_no, fax_no, email_address, lab_office
from mds_users
where lastconnect < to_date('2002-oct-24', 'yyyy-mm-dd')
or login_count = 0
order by login_count, lastconnect, username

-- Used the following query to generate list of mds_users not found in AD
select * from (
   select m.email_address, m.login_count, m.lastconnect, m.active_flag,
   m.username, m.fullname, m.phone_no, m.fax_no,
   -- m.USER_GROUP_ID,
   m.PHONE_EXT, m.USER_ID, m.lab_office
   -- m.VALID_LENGTH, m.LASTRENEW_DATE
   from mds_users m, not_found_ad_emails a
   where m.email_address = a.email
   union
   select m.email_address, m.login_count, m.lastconnect, m.active_flag,
   m.username, m.fullname, m.phone_no, m.fax_no,
   -- m.USER_GROUP_ID,
   m.PHONE_EXT, m.USER_ID, m.lab_office
   -- m.VALID_LENGTH, m.LASTRENEW_DATE
   from mds_users m
   where m.email_address is null
   or m.email_address = 'na'
   or m.email_address = 'null'
   or m.email_address = 'null@molex.com'
   )
where login_count > 0
and lastconnect > to_date('2002-oct-24', 'yyyy-mm-dd')

create table mds_users_found_in_ad
   (
   email varchar2(45),
   mds_username varchar2(100),
   fullname varchar2(255),
   mds_user_id number,
   distinguised_name varchar2(255),
   employee_number number
   )

-- A different way of generating a "mismatch" list for PDM administrators
select * from (
   select email_address, login_count, lastconnect, active_flag,
   username, fullname, phone_no, fax_no, phone_ext, lab_office
   from mds_users
   where user_id not in
      (
      select mds_user_id from mds_users_found_in_ad
      )
   union
   select email_address, login_count, lastconnect, active_flag,
   username, fullname, phone_no, fax_no, phone_ext, lab_office
   from mds_users
   where email_address is null
   or email_address = 'na'
   or email_address = 'null'
   or email_address = 'null@molex.com'
   )
where login_count > 0
and lastconnect > to_date('2002-oct-24', 'yyyy-mm-dd')

-- Used the following query to generate a list of all users in the
-- FES region.  Query designed by EngKee Goh.
select 
   login_count, lastconnect,
   username, FullName,  phone_no, fax_no, email_address, lab_office
from mds_users
where lab_office in ('S', 'THL', 'I', 'HK', 'DG', 'SH', 'T')
order by lab_office, login_count, lastconnect, username

-- Another way of generating a "mismatch" list for PDM administrators
select * from (
   select email_address, login_count, lastconnect, active_flag,
   username, fullname, phone_no, fax_no, phone_ext, lab_office
   from mds_users
   where user_id not in
      (
      select mds_user_id from mds_users_found_in_ad
      )
   union
   select email_address, login_count, lastconnect, active_flag,
   username, fullname, phone_no, fax_no, phone_ext, lab_office
   from mds_users
   where email_address is null
   or email_address = 'na'
   or email_address = 'null'
   or email_address = 'null@molex.com'
   )
where login_count > 0
and lastconnect > add_months(sysdate, -6) 
and active_flag != 'N' 

-- Yet another "mismatch" list for PDM administrators
select lab_office, username, email_address, login_count, lastconnect,
       fullname, phone_no, fax_no, phone_ext
from mds_users
where email_address in
   (
   select email from not_found_ad_emails
   )
and login_count > 0
and lastconnect > add_months(sysdate, -6) 
and active_flag != 'N'   
order by lab_office, username


-- This is the raw number for "current MIDAS users"
select count(*) 
from mds_users
where login_count > 0
and lastconnect > add_months(sysdate, -6) 
and active_flag != 'N'   
-- 1914 as of 20030502

-- Used this to generate the "Not recently logged in" list.
select lab_office, username, email_address, login_count, lastconnect,
       fullname, phone_no, fax_no, phone_ext
from mds_users
where 
   (
   login_count = 0
   or lastconnect < add_months(sysdate, -6) 
   )
and active_flag != 'N'   
order by lab_office, username


select count(*)
from mds_users
where
   (
   login_count = 0
   or lastconnect < add_months(sysdate, -6
   )
and active_flag != 'N'
order by lab_office, username
-- There were 1157 of these on 20030515

-------------------------------------------------------------

-- Here is the first of the three things I did to keep a list
-- of mds_users entries I inactivated on 20030515.
create table mds_users_inactivated
as select * from mds_users
where
   (
   login_count = 0
   or lastconnect < add_months(sysdate, -6)
   )
and active_flag != 'N'

-- Here is the second of the three things I did to keep a list
-- of mds_users entries I inactivated on 20030515.
alter table mds_users_inactivated
add (date_inactivated date)

-- Here is the third of the three things I did to keep a list
-- of mds_users entries I inactivated on 20030515.
update mds_users_inactivated
set date_inactivated = sysdate;

-------------------------------------------------------------

-- Here is what I used on 20030515 to disable accounts which
-- haven't been used in at least 6 months.
update mds_users set active_flag = 'N'
where
   (
   login_count = 0
   or lastconnect < add_months(sysdate, -6)
   )
-- 1254 rows updated on 20030515.  This is more
-- than the 1157 from the above query - the remainder, I 
-- suppose, were already inactive.


select count(*) from mds_users_found_in_ad
where employee_number is null;

select * from mds_users_found_in_ad
where employee_number is null

select * from (
   select lab_office, username, email_address, login_count,
   lastconnect, -- active_flag,
   fullname, phone_no, fax_no, phone_ext
   from mds_users
   where user_id not in
      (
      select mds_user_id from mds_users_found_in_ad
      where active_flag != 'N'
      )
   union
   select lab_office, username, email_address, login_count,
   lastconnect, -- active_flag,
   fullname, phone_no, fax_no, phone_ext
   from mds_users
   where active_flag != 'N'
   and (
      email_address is null
      or email_address = ''
      or email_address = 'na'
      or email_address = 'null'
      or email_address = 'null@molex.com'
      )
   )
where login_count > 0
and lastconnect > add_months(sysdate, -6) 
