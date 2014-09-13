IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pBOLOperationFromMacro_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_pBOLOperationFromMacro_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_pBOLOperationFromMacro_DELETE]
(@OpToMacroID uniqueidentifier)
AS
BEGIN
	DELETE FROM dbo.pBOLOpTOMacro WHERE OpToMacroId = @OpToMacroID
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01744'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01744', GetDate())
END	

GO
