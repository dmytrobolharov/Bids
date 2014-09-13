alter table pCompliance alter column ComplianceFileName nvarchar(500)
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02306'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02306', GetDate())
END	
GO