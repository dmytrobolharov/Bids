IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pBOLMacroToTemplate_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_pBOLMacroToTemplate_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_pBOLMacroToTemplate_INSERT] 
	(@TemplateId   uniqueidentifier,
	@MacroId  uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime,
	@Active int)
AS
INSERT INTO pBOLTemplateEntries
    (TemplateId, MacroId, CUser, CDate, MUser, MDate, Active, Sort)
VALUES (@TemplateId, @MacroId, @CUser, @CDate, @CUser, @CDate, @Active, '99999')

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01746'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01746', GetDate())
END	

GO
