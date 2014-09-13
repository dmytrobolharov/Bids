IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pBOLOperationToMacro_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_pBOLOperationToMacro_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_pBOLOperationToMacro_INSERT] 
	(@MacroId   uniqueidentifier,
	@OperationId  uniqueidentifier,
	@CUser nvarchar(200),
	@CDate datetime,
	@Active int)
AS
INSERT INTO pBOLOpToMacro
    (MacroId, OperationId, CUser, CDate, MUser, MDate, Active, Sort)
VALUES (@MacroId, @OperationId, @CUser, @CDate, @CUser, @CDate, @Active, '99999')

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01743'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01743', GetDate())
END	

GO
