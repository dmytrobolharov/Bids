IF NOT EXISTS(SELECT * FROM sPackageDatabaseObjectType WHERE DatabaseObjectTypeID = 1)
BEGIN
	INSERT INTO sPackageDatabaseObjectType (DatabaseObjectTypeID, DatabaseObjectType)
	VALUES (1, 'Stored Procedure')
END

GO

IF NOT EXISTS(SELECT * FROM sPackageDatabaseObjectType WHERE DatabaseObjectTypeID = 2)
BEGIN
	INSERT INTO sPackageDatabaseObjectType (DatabaseObjectTypeID, DatabaseObjectType)
	VALUES (2, 'View')
END

GO

IF NOT EXISTS(SELECT * FROM sPackageDatabaseObjectType WHERE DatabaseObjectTypeID = 3)
BEGIN
	INSERT INTO sPackageDatabaseObjectType(DatabaseObjectTypeID, DatabaseObjectType)
	VALUES(3, 'Table')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07677', GetDate())
GO
