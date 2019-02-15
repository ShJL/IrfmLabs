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


insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Технологии разделения изотопов и ядерное топливо', '14.05.03', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерные физика и технологии', '14.04.02', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Юриспруденция', '030501', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная математика', '230401', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационная безопасность', '090900', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Конструкторско-технологическое обеспечение машиностроительных производств', '151900', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика кинетических явлений', '140303', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная информатика', '09.03.03', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная математика и информатика', '01.03.02', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Бизнес-информатика', '38.04.05', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационные системы и технологии', '09.04.02', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Применение и эксплуатация автоматизированных систем специального назначения', '09.05.01', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Безопасность и нераспространение ядерных материалов', '140309', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Техническая физика', '140400', 'Магистратура', 2, 'ГОС2', 0, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерные физика и технологии', '140800', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная математика и информатика', '010501', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Атомные станции: проектирование, эксплуатация и инжиниринг', '14.05.02', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Юриспруденция', '40.03.01', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экономика', '38.03.01', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная информатика (по областям)', '080801', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Материаловедение и технологии материалов', '22.03.01', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Юриспруденция', '40.04.01', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационно-аналитические системы безопасности', '10.05.04', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Материаловедение и технологии материалов', '150100', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Электроника и автоматика физических установок', '14.05.04', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Международные отношения', '41.03.05', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Технологии разделения изотопов и ядерное топливо', '141405', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Безопасность информационных технологий в правоохранительной сфере', '10.05.05', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экономика', '080100', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная информатика', '230700', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерные физика и технологии', '14.03.02', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информатика и вычислительная техника', '09.04.01', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Бизнес-информатика', '38.03.05', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Системный анализ и управление', '27.03.03', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационная безопасность', '090900', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерная энергетика и теплофизика', '14.04.01', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информатика и вычислительная техника', '230100', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Вычислительные машины, комплексы, системы и сети', '230101', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная математика и информатика', '010400', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная математика', '01.03.04', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Комплексная защита объектов информатизации', '090104', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная математика и информатика', '010400', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Правовое обеспечение национальной безопасности', '40.05.01', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика', '03.03.02', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационная безопасность', '10.03.01', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика металлов', '150702', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика пучков заряженных частиц и ускорительная техника', '140304', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Медицинская физика', '010707', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная математика и информатика', '01.04.02', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационная безопасность', '10.04.01', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Комплексное обеспечение информационной безопасности автоматизированных систем', '090105', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладные математика и физика', '03.04.01', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Материаловедение и технологии материалов', '22.04.01', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная информатика', '09.04.03', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Международные отношения', '030701', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерные реакторы и материалы', '14.05.01', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная математика и информатика', '010500', 'Бакалавриат', 0, 'ГОС2', 0, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладные математика и физика', '010600', 'Бакалавриат', 0, 'ГОС2', 0, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информатика и вычислительная техника', '09.03.01', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Программная инженерия', '09.04.04', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная математика и информатика', '010500', 'Магистратура', 2, 'ГОС2', 0, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика', '010700', 'Бакалавриат', 0, 'ГОС2', 0, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Менеджмент', '080500', 'Бакалавриат', 0, 'ГОС2', 0, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика', '011200', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационная безопасность автоматизированных систем', '10.05.03', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладные математика и физика', '010900', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Материаловедение и технологии материалов', '150100', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Математические методы в экономике', '080116', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика', '011200', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экономика и управление на предприятии (по отраслям)', '080502', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Международные отношения', '41.04.05', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика', '03.04.02', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладные математика и физика', '010600', 'Магистратура', 2, 'ГОС2', 0, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Электроника и микроэлектроника', '210100', 'Магистратура', 2, 'ГОС2', 0, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Менеджмент', '38.03.02', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Финансы и кредит', '080105', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информатика и вычислительная техника', '230100', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экономика', '080100', 'Бакалавриат', 0, 'ГОС2', 0, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика конденсированного состояния вещества', '140301', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерные реакторы и энергетические установки', '140305', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационная безопасность автоматизированных систем', '090303', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика атомного ядра и частиц', '140302', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Менеджмент', '38.04.02', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационные системы и технологии', '09.03.02', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Бухгалтерский учет, анализ и аудит', '080109', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Программная инженерия', '231000', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладные математика и физика', '03.03.01', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экономика', '38.04.01', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерные физика и технологии', '140800', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Конструкторско-технологическое обеспечение машиностроительных производств', '15.04.05', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Автоматизированные системы обработки информации и управления', '230102', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Прикладная математика', '01.04.04', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экономическая безопасность', '38.05.01', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Радиационная безопасность человека и окружающей среды', '140307', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экономика', '080100', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Менеджмент', '080200', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Программная инженерия', '09.03.04', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Системный анализ и управление', '27.04.03', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Менеджмент', '080200', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерная энергетика и теплофизика', '140700', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Электроника и автоматика физических установок', '140306', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Дифференциальные уравнения', '01.01.02', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Приборы и методы экспериментальной физики', '01.04.01', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика и астрономия', '03.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Теоретическая физика', '01.04.02', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика конденсированного состояния', '01.04.07', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика плазмы', '01.04.08', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Электрофизика, электрофизические установки', '01.04.13', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Теплофизика и теоретическая теплотехника', '01.04.14', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Электро- и теплотехника', '13.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика атомного ядра и элементарных частиц', '01.04.16', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика пучков заряженных частиц и ускорительная техника', '01.04.20', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Лазерная физика', '01.04.21', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физика высоких энергий', '01.04.23', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационно-измерительные и управляющие системы (по отраслям)', '05.11.16', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Управление в технических системах', '27.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Системный анализ, управление и обработка информации (по отраслям)', '05.13.01', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информатика и вычислительная техника', '09.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Элементы и устройства вычислительной техники и систем управления', '05.13.05', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Автоматизация и управление технологическими процессами и производствами (по отраслям)', '05.13.06', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Математическое и программное обеспечение вычислительных машин, комплексов и компьютерных сетей', '05.13.11', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Математическое моделирование, численные методы и комплексы программ', '05.13.18', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Компьютерные и информационные науки ', '02.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Методы и системы защиты информации, информационная безопасность', '05.13.19', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Информационная безопасность', '10.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерные энергетические установки, включая проектирование, эксплуатацию и вывод из эксплуатации', '05.14.03', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерная, тепловая и возобновляемая энергетика и сопутствующие технологии', '14.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Твердотельная электроника, радиоэлектронные компоненты, микро- и наноэлектроника на квантовых эффектах', '05.27.01', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Электроника, радиотехника и системы связи', '11.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экономика и управление народным хозяйством (по отраслям и сферам деятельности)', '08.00.05', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экономика', '38.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Бухгалтерский учет, статистика', '08.00.12', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Математические  и инструментальные методы экономики', '08.00.13', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Административное право, финансовое право, информационное право', '12.00.14', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Юриспруденция', '40.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Материаловедение', '05.16.09', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Химическая технология', '18.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Порошковая металлургия и композиционные материалы', '05.16.06', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Технологии материалов', '22.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Лазерная техника и лазерные технологии', '12.03.05', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Математика и механика', '01.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Юриспруденция', '030900', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Компьютерные и информаионные науки', '02.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Психология', '37.04.01', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Лазерная техника и лазерные технологии', '12.04.05', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Физико-технические науки и технологии', '16.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экономическая безопасность', '080101', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Химические науки', '04.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Фотоника, приборостроение, оптические и биотехнические системы и технологии', '12.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Машиностроение', '15.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Психологические науки', '37.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Биологические науки', '06.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Электроника и наноэлектроника', '11.04.04', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Электроника и наноэлектроника', '11.03.04', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Авиационная и ракетно-космическая техника', '24.06.01', 'Аспирантура', 3, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Биология', '06.03.01', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Лечебное дело', '31.05.01', 'Специалитет', 1, 'ФГОС3+', 1, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Менеджмент организации', '080507', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Приборостроение', '12.03.01', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Химия', '04.03.01', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Химия, физика и механика материалов', '04.04.02', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Экология и природопользование', '05.03.06', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Атомные электрические станции и установки', '140404', 'Специалитет', 1, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Ядерная энергетика и теплофизика', '14.03.01', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Технология редких, рассеянных и радиоактивных элементов', '05.17.02', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Технология электрохимических процессов и защита от коррозии', '05.17.03', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Химическая технология топлива и высокоэнергетических веществ', '05.17.07', 'Аспирантура', 3, 'ГОС2', 0, 'специальность', 1);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Фотоника и оптоинформатика', '12.04.03', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Биотехнические системы и технологии', '12.03.04', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Фотоника и оптоинформатика', '12.03.03', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Высокотехнологические плазменные и энергетические установки', '16.03.02', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Высокотехнологические плазменные и энергетические установки', '16.04.02', 'Магистратура', 2, 'ФГОС3+', 1, 'направление', 0);
insert into specialities ("name", "code", "level", "level_id", "generation", "generation_id", "type", "type_id") values ('Мехатроника и робототехника', '15.03.06', 'Бакалавриат', 0, 'ФГОС3+', 1, 'направление', 0);
