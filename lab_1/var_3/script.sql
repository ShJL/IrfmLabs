create table a_groups (
	"id" number not null,
	"name" varchar2(11) not null,
	"old_name" varchar2(8) null,
	"term_number" number not null,
	"study_year" varchar2(9) not null,
	"created_at" date not null,
	"updated_at" date not null
);


create sequence seq_a_groups_id
start with 1
increment by 1
nomaxvalue;


create or replace trigger trig_a_groups_id
before insert on a_groups
for each row
begin
	select seq_a_groups_id.nextval
	into :new."id"
	from dual;
end;
