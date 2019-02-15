create table specialities (
	"id" number not null,
	"name" varchar2(102) not null,
	"code" varchar2(8) not null,
	"level" varchar2(12) not null,
	"level_id" number not null,
	"generation" varchar2(6) not null,
	"generation_id" number not null,
	"type" varchar2(13) not null,
	"type_id" number not null,
	constraint check_specialities_level check ("level" in ('Аспирантура', 'Бакалавриат', 'Магистратура', 'Специалитет')),
	constraint check_specialities_level_id check ("level_id" in ('0', '1', '2', '3')),
	constraint check_specialities_generation check ("generation" in ('ГОС2', 'ФГОС3+')),
	constraint check_specialities_generation_id check ("generation_id" in ('0', '1')),
	constraint check_specialities_type check ("type" in ('направление', 'специальность')),
	constraint check_specialities_type_id check ("type_id" in ('0', '1'))
);


create sequence seq_specialities_id
start with 1
increment by 1
nomaxvalue;


create or replace trigger trig_specialities_id
before insert on specialities
for each row
begin
	select seq_specialities_id.nextval
	into :new."id"
	from dual;
end;
