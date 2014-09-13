--select TOP 10 * from sVersion
--EXEC sp_droplogin 'sem2'

CREATE LOGIN $(loginUser) WITH PASSWORD = '$(loginPassword)'
use $(dbName)
alter authorization on database::$(dbName) to $(loginUser);
EXEC sp_addrolemember 'db_owner', '$(loginUser)'

/*
CREATE LOGIN semTest WITH PASSWORD = 'custom@1234'
use plmOnTesty
alter authorization on database::plmOnTesty to semTest;
EXEC sp_addrolemember 'db_owner', '$(loginUser)'
*/
