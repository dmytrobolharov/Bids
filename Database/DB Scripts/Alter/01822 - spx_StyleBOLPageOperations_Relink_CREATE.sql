SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleBOLPageOperations_Relink]
(@PageOperationId UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME )
AS

DECLARE @OperationId as varchar(50)
DECLARE @MacroId as varchar(50)
DECLARE @Code as nvarchar(200)
DECLARE @Name as nvarchar(200)
DECLARE @Comments as nvarchar(200)
DECLARE @ImageID as varchar(50)
DECLARE @SAM as numeric(10, 2)
DECLARE @Coef as numeric(10, 2)
DECLARE @Adj as nvarchar(20)
DECLARE @AdjTime as nvarchar(20)
DECLARE @BaseRateId as varchar(50)
DECLARE @MachineId as varchar(50)
DECLARE @nCount as int

BEGIN
	SELECT @OperationId = OperationId, @MacroId = MacroId FROM pStyleBOLPageOperations WITH (NOLOCK) WHERE PageOperationId = @PageOperationId
	IF (@OperationId <> '')
	BEGIN
		SELECT @nCount = count(*) FROM pBOLOperations WITH (NOLOCK) WHERE OperationId = @OperationId
		IF  (@nCount <> 0)
		BEGIN
			SELECT @Code = OperationCode, @Name = OperationName, @ImageID = Image, @SAM = SAM, @BaseRateId = BaseRateId, @MachineId = MachineId FROM pBOLOperations WITH (NOLOCK) WHERE OperationId = @OperationId
			UPDATE pStyleBOLPageOperations SET isLinked = 1, ImageID = @ImageID, MUser = @MUser, MDate = @MDate, Code = @Code, Name = @Name, SAM = @SAM, BaseRateId = @BaseRateId, MachineId = @MachineId, ImageType = 'BOLOP' WHERE PageOperationId = @PageOperationId
		END
	END
	IF (@MacroId <> '')
	BEGIN
		SELECT @nCount = count(*) FROM pBOLMacro WITH (NOLOCK) WHERE MacroId = @MacroId
		IF  (@nCount <> 0)
		BEGIN
			SELECT @Code = MacroCode, @Name = MacroName, @ImageID = Image FROM pBOLMacro WITH (NOLOCK) WHERE MacroId = @MacroId
			UPDATE pStyleBOLPageOperations SET isLinked = 1, ImageID = @ImageID, MUser = @MUser, MDate = @MDate, Code = @Code, Name = @Name, SAM = NULL, BaseRateId = '00000000-0000-0000-0000-000000000000', MachineId = '00000000-0000-0000-0000-000000000000', ImageType = 'BOLMOP' WHERE PageOperationId = @PageOperationId
			DELETE FROM pStyleBOLPageOperations WHERE MacroParentId = @PageOperationId
		END
	END
	
	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01822'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01822', GetDate())
END

GO
