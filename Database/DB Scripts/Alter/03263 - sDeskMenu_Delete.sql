
DELETE from sDeskMenu WHERE UPPER(DeskName) = 'PROFILE'
	 
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03262'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03263', GetDate())

END

GO