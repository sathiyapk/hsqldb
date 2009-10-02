-- TEST CACHED TABLE OBJECTS

-- This TESTS the schema-specific objects created in a previous script.

CREATE USER otheruser PASSWORD otheruser;


--                  ******************************       CACH Tables
/*c2*/SELECT * FROM ctblt1;
/*c1*/SELECT * FROM ctblt1 WHERE i = 0;
/*c2*/SELECT * FROM ctblt1 WHERE i in (0, 1, 11, 12);
/*c1*/SELECT * FROM ctblt1 WHERE i < 1;
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i = (SELECT i FROM tblj1);
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i = (SELECT i FROM tblj1 WHERE tblj1.i = 1);
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i in (SELECT i FROM tblj1);
/*c0*/SELECT * FROM ctblt1 WHERE ctblt1.i = (SELECT i FROM tblj1 WHERE i = 0);
/*c1*/SELECT * FROM public.ctblt1 WHERE ctblt1.i = (SELECT i FROM tblj1);
/*c1*/SELECT * FROM public.ctblt1 WHERE ctblt1.i in (SELECT i FROM tblj1);
/*c1*/SELECT * FROM public.ctblt1 WHERE ctblt1.i = (SELECT i FROM tblj1 WHERE i = 1);
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i = (SELECT i FROM public.tblj1);
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i in (SELECT i FROM public.tblj1);
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i = (SELECT i FROM public.tblj1 WHERE i = 1);
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i = (SELECT tblj1.i FROM public.tblj1);
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i in (SELECT tblj1.i FROM tblj1);
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i = (SELECT tblj1.i FROM tblj1 WHERE i = 1);
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i = (SELECT i FROM public.tblj1 WHERE tblj1.i = 1);
/*c1*/SELECT * FROM ctblt1 WHERE ctblt1.i = (SELECT tblj1.i FROM tblj1 WHERE tblj1.i = 1);
/*c1*/SELECT * FROM ctblt1 WHERE i = (SELECT i FROM tblj1);
/*c1*/SELECT * FROM ctblt1 WHERE i in (SELECT i FROM tblj1);
/*c1*/SELECT * FROM ctblt1 WHERE i = (SELECT i FROM tblj1 WHERE i = 1);
/*c1*/SELECT * FROM public.ctblt1 WHERE i = (SELECT i FROM tblj1);
/*c1*/SELECT * FROM public.ctblt1 WHERE i in (SELECT i FROM tblj1);
/*c0*/SELECT * FROM public.ctblt1 WHERE i = (SELECT i FROM tblj1 WHERE i = 0);
/*c1*/SELECT * FROM ctblt1 WHERE i = (SELECT i FROM public.tblj1);
/*c1*/SELECT * FROM ctblt1 WHERE i in (SELECT i FROM public.tblj1);
/*c0*/SELECT * FROM ctblt1 WHERE i = (SELECT i FROM public.tblj1 WHERE i = 0);
/*c1*/SELECT * FROM ctblt1 WHERE i = (SELECT tblj1.i FROM public.tblj1);
/*c1*/SELECT * FROM ctblt1 WHERE i in (SELECT tblj1.i FROM tblj1);
/*c0*/SELECT * FROM ctblt1 WHERE i = (SELECT tblj1.i FROM tblj1 WHERE i = 0);
/*c1*/SELECT * FROM ctblt1 WHERE i = (SELECT i FROM public.tblj1 WHERE tblj1.i = 1);
/*c1*/SELECT * FROM ctblt1 WHERE i = (SELECT tblj1.i FROM tblj1 WHERE tblj1.i = 1);
/*e*/SELECT * FROM system_users WHERE user_name = 'SA';
/*e*/SELECT * FROM other.ctblt1;
/*e*/SELECT * FROM other.system_users;
/*e*/SELECT * FROM information_schema.ctblt1;
/*e*/SELECT * FROM public.system_users;
/*c2*/SELECT * FROM public.ctblt1;
/*c1*/SELECT * FROM information_schema.system_users WHERE user_name = 'SA';
/*c1*/SELECT * FROM public.ctblt1 WHERE i = 0;
/*e*/SELECT * FROM other.ctblt1 WHERE i = 0;
/*e*/SELECT * FROM information_schema.ctblt1 WHERE i = 0;
/*c1*/SELECT * FROM public.ctblt1, public.tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT * FROM ctblt1, public.tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT * FROM public.ctblt1, tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT * FROM ctblt1, tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT vc FROM public.ctblt1, public.tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT vc FROM ctblt1, public.tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT vc FROM public.ctblt1, tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT vc FROM ctblt1, tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT tblj1.vc FROM public.ctblt1, public.tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT tblj1.vc FROM ctblt1, public.tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT tblj1.vc FROM public.ctblt1, tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT tblj1.vc FROM ctblt1, tblj1 WHERE ctblt1.i = tblj1.i;
/*c1*/SELECT lbla.vc FROM ctblt1, tblj1 lbla WHERE ctblt1.i = lbla.i;
/*c1*/SELECT tblj1.vc FROM ctblt1 lblb, tblj1 WHERE lblb.i = tblj1.i;
/*c1*/SELECT lbla.vc FROM ctblt1 lblb, tblj1 lbla WHERE lblb.i = lbla.i;
/*c1*/SELECT lbla.vc FROM public.ctblt1, tblj1 lbla WHERE ctblt1.i = lbla.i;
/*c1*/SELECT tblj1.vc FROM public.ctblt1 lblb, tblj1 WHERE lblb.i = tblj1.i;
/*c1*/SELECT lbla.vc FROM public.ctblt1 lblb, tblj1 lbla WHERE lblb.i = lbla.i;
/*c1*/SELECT lbla.vc FROM ctblt1, public.tblj1 lbla WHERE ctblt1.i = lbla.i;
/*c1*/SELECT tblj1.vc FROM ctblt1 lblb, public.tblj1 WHERE lblb.i = tblj1.i;
/*c1*/SELECT lbla.vc FROM ctblt1 lblb, public.tblj1 lbla WHERE lblb.i = lbla.i;
/*u0*/SET TABLE ctblt1 READONLY true;
/*e*/UPDATE ctblt1 set i = 11 WHERE i = 1;
/*u0*/SET TABLE public.ctblt1 READONLY true;
/*e*/SET TABLE information_schema.ctblt1 READONLY true;
/*e*/SET TABLE other.ctblt1 READONLY true;
/*u0*/SET TABLE ctblt1 READONLY false;
/*u0*/SET TABLE public.ctblt1 READONLY false;
/*c2*/SELECT i FROM ctblt1;
-- N.b.: Do not commit DML changes so that this whole block may be repeated.
COMMIT;
SET AUTOCOMMIT false;
/*u1*/UPDATE ctblt1 set i = 11 WHERE i = 1;
/*u1*/UPDATE ctblt1 set ctblt1.i = 12 WHERE i = 11;
/*u1*/UPDATE ctblt1 set ctblt1.i = 13 WHERE ctblt1.i = 12;
/*u1*/UPDATE public.ctblt1 set i = 14 WHERE i = 13;
/*u1*/UPDATE public.ctblt1 set ctblt1.i = 15 WHERE i = 14;
/*u1*/UPDATE public.ctblt1 set ctblt1.i = 16 WHERE ctblt1.i = 15;
/*e*/UPDATE other.ctblt1 set ctblt1.i = 17 WHERE ctblt1.i = 16;
/*e*/UPDATE information_schema.ctblt1 set ctblt1.i = 17 WHERE ctblt1.i = 16;
/*u1*/UPDATE ctblt1 ali set i = 17 WHERE i = 16;
/*u1*/UPDATE ctblt1 ali set ali.i = 18 WHERE i = 17;
/*u1*/UPDATE ctblt1 ali set ali.i = 19 WHERE ali.i = 18;
/*u1*/UPDATE ctblt1 ali set i = 20 WHERE ali.i = 19;
/*u1*/UPDATE public.ctblt1 ali set i = 21 WHERE i = 20;
/*u1*/UPDATE public.ctblt1 ali set ali.i = 22 WHERE i = 21;
/*u1*/UPDATE public.ctblt1 ali set ali.i = 23 WHERE ali.i = 22;
/*u1*/UPDATE public.ctblt1 ali set i = 24 WHERE ali.i = 23;
/*e*/UPDATE other.ctblt1 ali set i = 25 WHERE ali.i = 24;
/*e*/UPDATE other.ctblt1 ali set i = 25 WHERE .i = 24;
/*e*/UPDATE other.ctblt1 set i = 25 WHERE i = 24;
/*e*/DELETE FROM other.ctblt1 ali WHERE ali.i = 24;
/*e*/DELETE FROM other.ctblt1 ali;
/*e*/DELETE FROM other.ctblt1 set WHERE i = 24;
/*e*/DELETE FROM other.ctblt1 WHERE i = 24;
/*e*/DELETE FROM system_information.tblj1 WHERE tblj1.i = 1;
/*u1*/DELETE FROM ctblt1 WHERE i = 0;
/*u1*/DELETE FROM public.ctblt1 WHERE i = 24;
/*u1*/DELETE FROM public.tblj1 WHERE tblj1.i = 1;
ROLLBACK;
/*c2*/SELECT i FROM ctblt1;
/*u0*/GRANT ALL ON ctblt1 TO otheruser;
/*u0*/GRANT ALL ON public.ctblt2 TO otheruser;
/*e*/GRANT ALL ON other.ctblt3 TO otheruser;
/*e*/GRANT ALL ON information_schema.ctblt3 TO otheruser;
/*u0*/REVOKE ALL ON ctblt1 FROM otheruser RESTRICT;
/*u0*/REVOKE ALL ON public.ctblt2 FROM otheruser RESTRICT;
/*e*/REVOKE ALL ON other.ctblt3 FROM otheruser RESTRICT;
/*e*/REVOKE ALL ON information_schema.ctblt3 FROM otheruser RESTRICT;
/*e*/DROP TABLE other.ctblt3;
/*e*/DROP TABLE information_schema.ctblt4;
/*e*/DROP TABLE ctblt101;
/*e*/DROP TABLE public.ctblt101;
/*u0*/DROP TABLE ctblt101 IF EXISTS;
/*u0*/DROP TABLE public.ctblt101 IF EXISTS;
-- Should "DROP TABLE nonexistentschema.notable IF EXISTS" work?
/*u0*/DROP TABLE other.system_users IF exists;
/*u0*/DROP TABLE system_users IF exists;

--                  ******************************       ALTERs
-- Add tests when time permits.

DROP USER otheruser;


-- This to test .script persistence.
SHUTDOWN;
