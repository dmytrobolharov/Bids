
Delete from sDeskMenuType where DeskMenuTypeName = 'Notices'

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01770'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01770', GetDate())
	END
GO