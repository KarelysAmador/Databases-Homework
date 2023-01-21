tablas
create TABLE mentors (
  id   serial primary key,
  name varchar(30) not null unique,
  years_in_Glasgow  int,
  address varchar(90),
  favorite_language varchar(30)
);
create table students(
  id   serial primary key,
  name varchar(30),
  address varchar(60),
  graduated_from_Code_Your_Future boolean
);
create table classes(
  id serial primary key,
  mentor_id int references mentors(id),
  topic varchar(30),
  date_classes date,
  place_classes varchar(60)
);
create table attendance (
  id        SERIAL PRIMARY KEY,
  student_id INT REFERENCES students(id),
  class_id INT REFERENCES classes(id)
);
-------------------------------------------------------------------------------------------------------------------
-- insert into
insert into mentors (name, years_in_glasgow, address, favorite_language)
values('Isard', 4, 'Isard Street 3', 'Javascript'),
('Ricard', 1, 'Can Ribalta', 'Java'),
('Oswaldo',2,'Congress','JS'),
('Nata', 0, 'pipo street', 'html'),
('Carmel', 9, 'Carmel Street 9', 'CSS');
select * from mentors
insert into students(name, address, graduated_from_Code_Your_Future)
values('Alberto', 'Avenida Malaga 43', true),
('Alejandro', 'Diagonal 234, 1º', false),
('Maria', 'Gràcia 23', false),
('Gisela', 'Gran via 45, 2º', true);
select * from students
insert into classes(mentor_id, topic, date_classes, place_classes)
values(8, 'Phyton', '2022-12-17', 'Adevinta'),
(6,'HTML','2022-12-17','Barcelona'),
(7,'Java','2022-12-31','Barcelona'),
(9,'NodeJS','2022-12-30','online');
select * from classes
insert into attendance (student_id, class_id)
values(1,4),
(3,2),
(2,5),
(4,3)
select * from attendance
-- Retrieve all the mentors who lived more than 5 years in Glasgow
select * from mentors where years_in_Glasgow > 5;
-- Retrieve all the mentors whose favourite language is Javascript
select * from mentors where favorite_language = 'Javascript';
-- Retrieve all the students who are CYF graduates
select * from students where graduated_from_Code_Your_Future = true;
-- Retrieve all the classes taught before June this year
select * from classes where date_classes <= '2022-06-01';
-- Retrieve all the students (retrieving student ids only is fine) who attended the Javascript class (or any other class that you have in the classes table).
select * from attendance;




















