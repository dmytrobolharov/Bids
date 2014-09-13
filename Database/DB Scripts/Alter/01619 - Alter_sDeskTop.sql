IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sDeskTop' and COLUMN_NAME = N'DeskFolderID')
       BEGIN 
             ALTER TABLE sDeskTop ADD	DeskFolderID int NULL
       END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01619'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01619', GetDate())

END
GO