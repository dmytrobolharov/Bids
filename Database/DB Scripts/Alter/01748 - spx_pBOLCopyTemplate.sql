IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pBOLCopyTemplate]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_pBOLCopyTemplate]
GO

CREATE PROCEDURE [dbo].[spx_pBOLCopyTemplate] 
	(@NewTemplateId   uniqueidentifier,
	 @OldTemplateId  uniqueidentifier,
	 @CUser nvarchar(200),
	 @CDate datetime,
	 @Active int)
AS

INSERT INTO pBOLTemplateEntries (TemplateId, OperationId, MacroId, CUser, CDate, MUser, MDate, Active, Sort)
		SELECT @NewTemplateId, OperationId, MacroId, @CUser, @CDate, @CUser, @CDate, @Active, '99999'
		FROM pBOLTemplateEntries
		WHERE TemplateId = @OldTemplateId

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01748'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01748', GetDate())
END	

GO
