-- Creating the server login, if not exists
IF NOT EXISTS(SELECT * FROM master.sys.server_principals WHERE name='$(loginUser)')
BEGIN
	CREATE LOGIN $(loginUser) WITH PASSWORD = '$(loginPassword)'
END

USE $(dbName)

-- Creating the database user for given login, if not exists, and granting it all the needed permissions
IF NOT EXISTS (
	SELECT 1 FROM sys.database_principals users
	INNER JOIN sys.server_principals logins ON logins.sid = users.sid 
	WHERE (users.name='$(loginUser)' OR logins.name='$(loginUser)')
)
BEGIN
	CREATE USER $(loginUser) FOR LOGIN $(loginUser)
	EXEC sp_addrolemember 'db_owner', '$(loginUser)'
END


