
IF(EXISTS(SELECT * FROM Mapping WHERE MapDetail = 'Body - Pattern Sheet'))
	BEGIN
		update Mapping set MapDetail = 'Body - Model' where MapDetail = 'Body - Pattern Sheet'
	END

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01842'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01842', GetDate())
	END
GO
 