SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleBOLPageOperations_Unlink]
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
DECLARE @Sort as nvarchar(5)
DECLARE @StyleID as varchar(50)
DECLARE @StyleSet as int

DECLARE @IsException as int

BEGIN
	SELECT @OperationId = OperationId, @MacroId = MacroId, @StyleID = StyleID, @StyleSet = StyleSet, @IsException = IsException FROM pStyleBOLPageOperations WITH (NOLOCK) WHERE PageOperationId = @PageOperationId
	IF (@OperationId <> '')
	BEGIN
		SELECT @nCount = count(*) FROM pBOLOperations WITH (NOLOCK) WHERE OperationId = @OperationId
		IF  (@nCount <> 0)
		BEGIN
			SELECT @Code = OperationCode, @Name = OperationName, @ImageID = Image, @SAM = SAM, @BaseRateId = BaseRateId, @MachineId = MachineId FROM pBOLOperations WITH (NOLOCK) WHERE OperationId = @OperationId
			UPDATE pStyleBOLPageOperations SET isLinked = 0, ImageID = @ImageID, MUser = @MUser, MDate = @MDate, Code = @Code, Name = @Name, SAM = @SAM, BaseRateId = @BaseRateId, MachineId = @MachineId, ImageType = 'BOLOP' WHERE PageOperationId = @PageOperationId
		END
	END
	IF (@MacroId <> '')
	BEGIN
		SELECT @nCount = count(*) FROM pBOLMacro WITH (NOLOCK) WHERE MacroId = @MacroId
		IF  (@nCount <> 0)
		BEGIN
			SELECT @Code = MacroCode, @Name = MacroName, @ImageID = Image FROM pBOLMacro WITH (NOLOCK) WHERE MacroId = @MacroId
			UPDATE pStyleBOLPageOperations SET isLinked = 0, ImageID = @ImageID, MUser = @MUser, MDate = @MDate, Code = @Code, Name = @Name, SAM = NULL, BaseRateId = '00000000-0000-0000-0000-000000000000', MachineId = '00000000-0000-0000-0000-000000000000', ImageType = 'BOLMOP' WHERE PageOperationId = @PageOperationId
		END
		
		DECLARE @CURSOR CURSOR
		SET @CURSOR = CURSOR SCROLL
		FOR
		SELECT  OperationId, Sort  
		  FROM  pBOLOpToMacro WHERE  MacroId = @MacroId
		OPEN @CURSOR
		FETCH NEXT FROM @CURSOR INTO @OperationId, @Sort
		WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @CURSOR1 CURSOR
			SET @CURSOR1 = CURSOR SCROLL
			FOR
			SELECT  OperationCode, OperationName, BaseRateId, SAM, MachineId, Image  
			  FROM  pBOLOperations WHERE  OperationId = @OperationId
			OPEN @CURSOR1
			FETCH NEXT FROM @CURSOR1 INTO @Code, @Name, @BaseRateId, @SAM, @MachineId, @ImageID
			WHILE @@FETCH_STATUS = 0
			BEGIN
				IF (@IsException = 0)
				BEGIN
					INSERT INTO pStyleBOLPageOperations (StyleID, StyleSet, Sort, IsLinked, OperationId, MacroParentId, Code, Name, ImageID, ImageType, SAM, BaseRateId, MachineId) 
					VALUES (@StyleID, @StyleSet, @Sort, 0, @OperationId, @PageOperationId, @Code, @Name, @ImageID, 'BOLOP', @SAM, @BaseRateId, @MachineId)
				END					
				IF (@IsException = 1)
				BEGIN
					INSERT INTO pStyleBOLPageOperations (StyleID, StyleSet, Sort, IsLinked, OperationId, MacroParentId, Code, Name, ImageID, ImageType, SAM, BaseRateId, MachineId, IsException) 
					VALUES (@StyleID, @StyleSet, @Sort, 0, @OperationId, @PageOperationId, @Code, @Name, @ImageID, 'BOLOP', @SAM, @BaseRateId, @MachineId, @IsException)
				END					
			FETCH NEXT FROM @CURSOR1 INTO @Code, @Name, @BaseRateId, @SAM, @MachineId, @ImageID
			END
			CLOSE @CURSOR1
		FETCH NEXT FROM @CURSOR INTO @OperationId, @Sort
		END
		CLOSE @CURSOR
	END
	
	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01823'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01823', GetDate())
END

GO
