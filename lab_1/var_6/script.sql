create table a_groups (
	"id" number not null,
	"name" varchar2(11) not null,
	"old_name" varchar2(8) null,
	"term_number" number not null,
	"study_year" varchar2(9) not null,
	"created_at" date not null,
	"updated_at" date not null
);
