Update sAccessBIFolder set BITypeDesc = 'Dashboard' where BITypeId = 1 and BITypeDesc is null
GO
Update sAccessBIFolder set BITypeDesc = 'Report' where BITypeId = 2  and BITypeDesc is null
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01914'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01914', GetDate())

END

GO 