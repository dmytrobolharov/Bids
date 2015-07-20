IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pBOLOpAndMacroFromTemplate_DELETE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_pBOLOpAndMacroFromTemplate_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_pBOLOpAndMacroFromTemplate_DELETE] 
(@TemplateEntryId uniqueidentifier)
AS
BEGIN
	DELETE FROM dbo.pBOLTemplateEntries WHERE TemplateEntryId = @TemplateEntryId
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01747'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01747', GetDate())
END	

GO
