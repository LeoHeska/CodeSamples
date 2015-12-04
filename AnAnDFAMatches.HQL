hive

use canon;
select count(*) from ac2dfa;
-- 64469255
-- We have 64,469,255 records in our CAnon DFA feed table

select count(distinct dfa_user_id) from CAnon.ac2dfa;
-- 28136908
-- We have 28,136,908 distinct DFA user IDs in our CAnon DFA feed table.

select count(*) from 5279pe.ac2dfa;
-- 1341398007
-- We have 1,341,398,007 records in our AAnon DFA feed table.

select count(distinct dfa_user_id) from 5279pe.ac2dfa;
-- Query bogged - taking 30 minutes to run
-- 476617002
-- We have 476,617,002 distinct DFA user IDs in our AAnon DFA feed table.

select count(*)
from 5279pe.ac2dfa acdfa
join ac2dfa cdfa on (acdfa.dfa_user_id = cdfa.dfa_user_id);
-- 40771015
-- So, 40,771,015 records that match based on dfa_user_id.

select count (distinct dfa_user_id)
from
  (
  select acdfa.dfa_user_id
  from 5279pe.ac2dfa acdfa
  join ac2dfa cdfa on (acdfa.dfa_user_id = cdfa.dfa_user_id)
  ) sub;
-- 2584939
-- So, 2,584,939 distinct dfa_user_id values that match in the two tables

-- -- --
use 5279pe;

select count (*)
from dfauserid_to_ashid;
-- 2980429

select count (*)
from dfauserid_to_ashid
where ashid is null;
-- OK, zero, as expected and as it should be, so OK to proceed.

-- NOTE: This query compares AAnon to AAnon!!! If run (as it was) after use 5279pe;
select count (distinct dfa_user_id)
from
  (
  select xref.dfa_user_id
  from 5279pe.dfauserid_to_ashid xref
  join ac2dfa cdfa on (xref.dfa_user_id = cdfa.dfa_user_id)
  ) sub;
-- 2793938
-- We have 2,793,938

select count (distinct dfa_user_id)
from
  (
  select xref.dfa_user_id
  from 5279pe.dfauserid_to_ashid xref
  join CAnon.ac2dfa cdfa on (xref.dfa_user_id = cdfa.dfa_user_id)
  ) sub;
-- 113264
-- 113,264 unique instances of a CAnon dfa_user_id, for which we have an AshID



