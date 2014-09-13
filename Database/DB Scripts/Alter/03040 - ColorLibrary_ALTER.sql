ALTER TABLE ColorLibrary ALTER COLUMN ColorSource nvarchar(150) NULL
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03040'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03040', GetDate())
END
GO