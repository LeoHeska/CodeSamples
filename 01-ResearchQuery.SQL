select username, fullname, phone_no, email_address
from mds_users
order by username;

select * from mds_users
where fullname in
   (
   select fullname from mds_users
   having count(*) > 1
   group by fullname
   )
order by fullname

select * from mds_users

-- The below query works, but since the output of the two
-- subqueries gets mixed up, so does the reader of the report.
-- Just keep the two separate.
select * from (
select * from mds_users
where fullname in
   (
   select fullname from mds_users
   having count(*) > 1
   group by fullname
   )
union
select * from mds_users
where email_address in
   (
   select email_address from mds_users
   where email_address is not null
   and upper(email_address) not like 'NUL%'
   and email_address != ''
   having count(*) > 1
   group by email_address
   )
)
order by username
-- Too many duplicate phone numbers...
-- union
-- select * from mds_users
-- where phone_no in
--    (
--    select phone_no from mds_users
--    having count(*) > 1
--    group by phone_no
--    )

-- Here is the first of the two "find duplicate user" queries
select * from mds_users
where fullname in
   (
   select fullname from mds_users
   having count(*) > 1
   group by fullname
   )
order by username

-- Here is the second of the two "find duplicate user" queries
select * from mds_users
where email_address in
   (
   select email_address from mds_users
   where email_address is not null
   and upper(email_address) not like 'NUL%'
   -- and email_address != '' -- this doesn't work...
   and length(email_address) != 0  -- no effect; no such records
   having count(*) > 1
   group by email_address
   )
order by email_address

select *
from mds_users
where upper(username) not in
   (
   select upper(alias) from AllADUsers
   where alias is not null
   )
-- 1948 mismatches; from Andy's extract 

select *
from mds_users
where upper(username) not in
   (
   select upper(login) from ADUsersFromBK
   where login is not null
   )
-- 1051 mismatches; from Bill Kuglich's extract

select * from mds_users
where email_address in
   (
   select email_address from mds_users
   having count(*) > 1
   group by email_address
   )

