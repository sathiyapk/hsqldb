-- This script depends on TestSelfTempTable1.txt to set up the objects tested.

SET AUTOCOMMIT false;
/*c0*/SELECT * FROM tmptbl1;
/*c0*/SELECT * FROM tmptbl2;
COMMIT;
CONNECT USER altuser2 PASSWORD password;
/*e*/SELECT * FROM tmptbl1;
/*e*/SELECT * FROM tmptbl2;
CONNECT USER altuser1 PASSWORD password;
/*c0*/SELECT * FROM tmptbl1;
/*c0*/SELECT * FROM tmptbl2;
/*u1*/INSERT INTO tmptbl1 VALUES(1);
/*u1*/INSERT INTO tmptbl1 VALUES(2);
/*c2*/SELECT * FROM tmptbl1;
COMMIT;
-- Purposefully not committing these inserts
/*c0*/SELECT * FROM tmptbl1;
/*u1*/INSERT INTO tmptbl2 VALUES(1);
/*u1*/INSERT INTO tmptbl2 VALUES(2);
/*c2*/SELECT * FROM tmptbl2;
ROLLBACK;
CONNECT USER SA password "";
SHUTDOWN;
