
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_pConLevel1]'))
DROP TRIGGER [dbo].[tD_pConLevel1]
GO
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_pConLevel2]'))
DROP TRIGGER [dbo].[tD_pConLevel2]
GO
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tD_pConLevel3]'))
DROP TRIGGER [dbo].[tD_pConLevel3]
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02140'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '02140', GetDate())
	END
GO
