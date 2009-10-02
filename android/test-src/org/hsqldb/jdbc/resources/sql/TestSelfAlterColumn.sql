drop table "testac" if exists;
drop table "testacc" if exists;
-- tests for various column definition statements
create table "testac" ("a" integer, "b" integer);
insert into "testac" values(6,6);
insert into "testac" values(5,5);
/*r2*/select count(*) from "testac";
-- add column without COLUMN keyword
alter table "testac" add "c" varchar(10)
/*e*/alter table "testac" add "c" varchar(10)
alter table "testac" alter column "c" varchar(2)
/*e*/insert into "testac" values(5,5,'long string');
insert into "testac" values(4,4,'ls');
/*r
 6,6,NULL
 5,5,NULL
 4,4,ls
*/select * from "testac" order by "a" desc
-- drop column without COLUMN keyword
alter table "testac" drop "c"
/*r
 6,6
 5,5
 4,4
*/select * from "testac" order by "a" desc
-- add column with COLUMN keyword
alter table "testac" add column "c" varchar(10) default 'XX' not null before "b"
/*e*/alter table "testac" add column "c" varchar(10) before "b"
/*r
 6,XX,6
 5,XX,5
 4,XX,4
*/select * from "testac" order by "a" desc;
-- drop column with COLUMN keyword
alter table "testac" drop column "c";
/*r
 6,6
 5,5
 4,4
*/select * from "testac" order by "a" desc;
--  add column without COLUMN keyword - unquoted
alter table "testac" add c varchar(10);
/*r
 6,6,NULL
 5,5,NULL
 4,4,NULL
*/select * from "testac" order by "a" desc;
--  drop column without COLUMN keyword - unquoted
alter table "testac" drop c;
/*r
 6,6
 5,5
 4,4
*/select * from "testac" order by "a" desc;
--
-- PK definition not allowed in alter column
/*e*/alter table "testac" alter column "a" integer primary key;
/*e*/alter table "testac" alter column "a" integer identity;
alter table "testac" add primary key("a");
/*e*/insert into "testac" values (null,7);
-- IDENTITY can be added to an existing PK column
alter table "testac" alter column "a" integer identity
insert into "testac" values (null,7);
insert into "testac" ("b") values (8);
/*r
 4,4
 5,5
 6,6
 7,7
 8,8
*/select * from "testac";
create table "testacc" as (select * from "testac") with data;
-- IDENTITY can be dropped from PK column
alter table "testac" alter column "a" integer;
/*e*/insert into "testac" values (null,9);
insert into "testac" values (9,9);
/*r
 4,4
 5,5
 6,6
 7,7
 8,8
 9,9
*/select * from "testac";
alter table "testac" drop primary key;
insert into "testac" values (null,12);
/*c7*/select * from "testac";
/*e*/alter table "testac" alter column "a" not null;

delete from "testac" where "a" is null
/*c6*/select * from "testac";
alter table "testac" alter column "a" set not null;
/*e*/insert into "testac" values (null,12);
alter table "testac" add primary key("a");
/*c6*/select * from "testac";
/*e*/insert into "testac" values (null,12);
alter table "testac" drop primary key;
/*e*/insert into "testac" values (null,12);
/*c6*/select * from "testac";
alter table "testac" alter column "a" set null;
insert into "testac" values (null,12);
delete from "testac" where "a" is null
/*c6*/select * from "testac";

-- column with a PK constraint can be added
alter table "testac" add column "c" integer generated by default as identity primary key
-- no second IDENTITY or PK
/*e*/alter table "testac" add column "d" integer generated by default as identity primary key
/*e*/alter table "testac" add column "d" integer generated by default as identity
/*e*/alter table "testac" add column "d" integer primary key;
-- column with a PK constraint can be dropped
alter table "testac" drop "c";
alter table "testac" add unique("a");
/*e*/insert into "testac" values(9,9);
alter table "testac" drop "a";
/*r
 4
 5
 6
 7
 8
 9
*/select * from "testac";
-- tests for changing column size
alter table "testacc" add column "c" varchar(4) default 'aa' not null;
update "testacc" set "c" = "c" || cast("a" as varchar(5));
/*r
 4,4,aa4
 5,5,aa5
 6,6,aa6
 7,7,aa7
 8,8,aa8
*/select * from "testacc";
alter table "testacc" add primary key ("c")
/*r
 4,4,aa4
 5,5,aa5
 6,6,aa6
 7,7,aa7
 8,8,aa8
*/select * from "testacc";
/*e*/insert into "testacc" values (9,9,'aa9000000');
alter table "testacc" alter column "c" varchar(10);
insert into "testacc" values (9,9,'aa9000000');
alter table "testacc" alter column "c" set not null
/*e*/insert into "testacc" values (10,10,null);
/*e*/alter table "testacc" alter column "c" set null;
alter table "testacc" drop primary key;
alter table "testacc" alter column "c" set null;
insert into "testacc" values (10,10,null);

