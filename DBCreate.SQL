CREATE TABLESPACE AGENTS 
    LOGGING 
    DATAFILE 'C:\ORACLE\ORADATA\ASIA\AGENTS.ora' SIZE 126M 
    EXTENT MANAGEMENT LOCAL

CREATE USER AGENT_INFO  PROFILE DEFAULT 
    IDENTIFIED BY voglrules DEFAULT TABLESPACE AGENTS
    ACCOUNT UNLOCK;

GRANT CONNECT TO AGENT_INFO;

grant unlimited tablespace to agent_info;

GRANT CREATE TABLE TO AGENT_INFO;

create table agent_info.agent_extract
   (
   dw_agt_ent_id char(10),
   dw_agy_src_cd char(1),
   dw_first_nm varchar2(30),
   dw_mid_init char(1),
   dw_last_nm varchar2(30),
   dw_birth_dt date,
   dw_tin char(10),
   dw_tin_typ_ind char(1),
   dw_email varchar2(75),
   dw_hom_phone char(10),
   dw_bus_phone char(10),
   primary key (dw_agt_ent_id, dw_agy_src_cd)
   )
   tablespace agents
   pctfree 5
   pctused 75
   initrans 2
   storage (initial 3200000 next 12000 pctincrease 0)
   
create table agent_info.agent_auth
   (
   ASIA_agent_id int,
   ASIA_agent_pw varchar2(32),
   ASIA_extern_user_id varchar2(32),
   primary key (ASIA_agent_id)
   )
   tablespace agents
   pctfree 5
   pctused 75
   initrans 2
   storage (initial 500000 next 5000 pctincrease 0)

create table agent_info.agent_join
   (
   ASIA_agent_id int,
   dw_agt_ent_id char(10),
   dw_agy_src_cd char(1),
   primary key (ASIA_agent_id)
   )
   tablespace agents
   pctfree 5
   pctused 75
   initrans 2
   storage (initial 500000 next 5000 pctincrease 0)
