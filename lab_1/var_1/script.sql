create table specialities (
    "id" number not null,
    code varchar2(8) not null,
    "name" varchar2(75) not null,
    department varchar2(64) not null,
    "level" varchar2(12) not null
);


create sequence seq_specialities_id
start with 1
increment by 1
nomaxvalue;


create or replace trigger trig_specialities_insert_id
before insert on specialities
for each row
begin
    select seq_specialities_id.nextval
    into :new."id"
    from dual;
end;

